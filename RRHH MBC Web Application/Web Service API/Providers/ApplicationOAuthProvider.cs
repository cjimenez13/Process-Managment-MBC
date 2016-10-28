using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Security;
using Microsoft.Owin.Security.Cookies;
using Microsoft.Owin.Security.OAuth;
using Web_Service_API.Models;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.DirectoryServices;

namespace Web_Service_API.Providers
{
    public class ApplicationOAuthProvider : OAuthAuthorizationServerProvider
    {
        private readonly string _publicClientId;

        public ApplicationOAuthProvider(string publicClientId)
        {
            if (publicClientId == null)
            {
                throw new ArgumentNullException("publicClientId");
            }

            _publicClientId = publicClientId;
        }

        public override async Task GrantResourceOwnerCredentials(OAuthGrantResourceOwnerCredentialsContext context)
        {
            var userManager = context.OwinContext.GetUserManager<ApplicationUserManager>();
            if (context.UserName.Contains("@"))
            {
                using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
                {
                    SqlCommand command = new SqlCommand("usp_get_Users", connection);
                    command.CommandType = System.Data.CommandType.StoredProcedure;

                    command.Connection.Open();
                    SqlDataReader rdr = command.ExecuteReader();
                    while (rdr.Read())
                    {
                        System.Console.WriteLine(rdr["email"].ToString());
                        string email = (rdr["email"].ToString());

                        var tempUser = new ApplicationUser() { UserName = email, Email = email };
                        var result = userManager.Create(tempUser, rdr["password"].ToString()).Errors;
                    }
                };
            }
            else
            {
                if (IsAuthenticated("MBCGROUP", context.UserName, context.Password))
                {
                    var userAD = new ApplicationUser() { UserName = context.UserName, Email = context.UserName };
                    await userManager.CreateAsync(userAD, context.Password);
                }
            }

            ApplicationUser user = await userManager.FindAsync(context.UserName, context.Password);
            if (user == null)
            {
                
                context.SetError("invalid_grant", "The user name or password is incorrect."+ context.Password);
                return;
            }

            ClaimsIdentity oAuthIdentity = await user.GenerateUserIdentityAsync(userManager,
               OAuthDefaults.AuthenticationType);
            ClaimsIdentity cookiesIdentity = await user.GenerateUserIdentityAsync(userManager,
                CookieAuthenticationDefaults.AuthenticationType);

            AuthenticationProperties properties = CreateProperties(user.UserName);
            AuthenticationTicket ticket = new AuthenticationTicket(oAuthIdentity, properties);
            context.Validated(ticket);
            context.Request.Context.Authentication.SignIn(cookiesIdentity);
        }

        public override Task TokenEndpoint(OAuthTokenEndpointContext context)
        {
            foreach (KeyValuePair<string, string> property in context.Properties.Dictionary)
            {
                context.AdditionalResponseParameters.Add(property.Key, property.Value);
            }

            return Task.FromResult<object>(null);
        }

        public override Task ValidateClientAuthentication(OAuthValidateClientAuthenticationContext context)
        {
            // Resource owner password credentials does not provide a client ID.
            if (context.ClientId == null)
            {
                context.Validated();
            }

            return Task.FromResult<object>(null);
        }

        public override Task ValidateClientRedirectUri(OAuthValidateClientRedirectUriContext context)
        {
            if (context.ClientId == _publicClientId)
            {
                Uri expectedRootUri = new Uri(context.Request.Uri, "/");

                if (expectedRootUri.AbsoluteUri == context.RedirectUri)
                {
                    context.Validated();
                }
            }

            return Task.FromResult<object>(null);
        }

        public static AuthenticationProperties CreateProperties(string userName)
        {
            IDictionary<string, string> data = new Dictionary<string, string>
            {
                { "userName", userName }
            };
            return new AuthenticationProperties(data);
        }
        /// <summary>
        /// Indica si el usuario ha sido auntenticado en el dominio.
        /// </summary>
        /// <param name="domain">Dominio</param>
        /// <param name="username">Nombre de usuario</param>
        /// <param name="pwd">Password de usuario</param>
        /// <param name="name">Nombre de Usuario</param>
        /// <returns>True/False</returns>
        public bool IsAuthenticated(string domain, string username, string pwd)
        {
            //string _path = WebConfigurationManager.AppSettings["DomainServer"];
            //name = string.Empty;
            string _path = "LDAP://mbcgroup.ofi";
            string domainAndUsername = domain + @"\" + username;
            DirectoryEntry entry = new DirectoryEntry(_path, domainAndUsername, pwd);
            //entry.Path = "CN=glpi,CN=Users,DC=mbcgroup,DC=ofi";
            try
            {
                object obj = entry.NativeObject;
                string _filterAttribute;
                DirectorySearcher search = new DirectorySearcher(entry);
                search.Filter = "(SAMAccountName=" + username + ")";
                search.PropertiesToLoad.Add("cn");
                SearchResult result = search.FindOne();
                if (null == result)
                    return false;

                _path = result.Path;
                _filterAttribute = (string)result.Properties["cn"][0];
            }
            catch (Exception e)
            {
                //LogGral.Log(e);
                string name = e.Message.ToString();
                return false;
            }
            return true;
        }
    }
}