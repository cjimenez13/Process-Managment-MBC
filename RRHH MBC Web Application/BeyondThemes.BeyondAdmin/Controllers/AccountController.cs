using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using BeyondThemes.BeyondAdmin.Models;
using System;
using System.Web.Security;
using BeyondThemes.BeyondAdmin.Providers;
using Model;
using DataTransferObjects;

namespace BeyondThemes.BeyondAdmin.Controllers
{
    [Authorize]
    public class AccountController : Controller
    {
        private AccountProvider _AccountProvider;
        public AccountController()
        {
            _AccountProvider = new AccountProvider();
        }

        //
        // GET: /Account/Login
        [AllowAnonymous]
        public ActionResult Login(string returnUrl)
        {
            ViewBag.ReturnUrl = returnUrl;
            return View();
        }
        [AllowAnonymous]
        public async Task<ActionResult> _ForgotPassword(PasswordForgottedModel model)
        {
            UsersProvider userProvider = new UsersProvider();
            UserDTO user = await userProvider.getUser(model.forgot_email);
            string name = user.name + " " + user.fLastName + " " + user.sLastName;
            Tools.EmailService.sendEmail(model.forgot_email, "Recuperación de contraseña, MBC Developers", name + " ,la contraseña de su cuenta actualmente es:" + user .password);
            return new HttpStatusCodeResult(200);
        }

        // POST: /Account/Login
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Login(LoginViewModel model, string returnUrl)
        {
            if (!ModelState.IsValid)
            {
                return View(model);
            }
            string token;
            if ((token = await _AccountProvider.postToken(model.Email, model.Password)) != null){
                DateTime expireTime = DateTime.Now.AddHours(2);

                HttpCookie tokenCookie = new HttpCookie("token");
                tokenCookie.Value = token;
                tokenCookie.Expires = expireTime;
                Response.Cookies.Add(tokenCookie);

                HttpCookie userCookie = new HttpCookie("user");
                userCookie.Value = model.Email;
                userCookie.Expires = expireTime;
                Response.Cookies.Add(userCookie);

                HttpCookie user_idCookie = new HttpCookie("user_id");
                user_idCookie.Value = new UsersProvider().getUser(model.Email).Result.user_id;
                user_idCookie.Expires = expireTime;
                Response.Cookies.Add(user_idCookie);


                FormsAuthentication.SetAuthCookie(model.Email, false);
                return RedirectToAction("Index", "Processes");
            }
            ModelState.AddModelError("", "Correo o contraseña invalidos");
            return View(model);
        }

        //
        // GET: /Account/Register
        [AllowAnonymous]
        public ActionResult Register()
        {
            return View();
        }
        //
        // GET: /Account/ForgotPassword
        [AllowAnonymous]
        public ActionResult ForgotPassword()
        {
            return View();
        }

        //
        // POST: /Account/ForgotPassword
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> ForgotPassword(ForgotPasswordViewModel model)
        {   
            /*
            if (ModelState.IsValid)
            {
                var user = await UserManager.FindByNameAsync(model.Email);
                if (user == null || !(await UserManager.IsEmailConfirmedAsync(user.Id)))
                {
                    // Don't reveal that the user does not exist or is not confirmed
                    return View("ForgotPasswordConfirmation");
                }

                // For more information on how to enable account confirmation and password reset please visit http://go.microsoft.com/fwlink/?LinkID=320771
                // Send an email with this link
                // string code = await UserManager.GeneratePasswordResetTokenAsync(user.Id);
                // var callbackUrl = Url.Action("ResetPassword", "Account", new { userId = user.Id, code = code }, protocol: Request.Url.Scheme);		
                // await UserManager.SendEmailAsync(user.Id, "Reset Password", "Please reset your password by clicking <a href=\"" + callbackUrl + "\">here</a>");
                // return RedirectToAction("ForgotPasswordConfirmation", "Account");
            }
            */

            // If we got this far, something failed, redisplay form
            return View(model);
        }

        //
        // GET: /Account/ForgotPasswordConfirmation
        [AllowAnonymous]
        public ActionResult ForgotPasswordConfirmation()
        {
            return View();
        }

        //
        // GET: /Account/ResetPassword
        [AllowAnonymous]
        public ActionResult ResetPassword(string code)
        {
            return code == null ? View("Error") : View();
        }

        //
        // POST: /Account/ResetPassword
        //[HttpPost]
        //[AllowAnonymous]
        //[ValidateAntiForgeryToken]
        //public async Task<ActionResult> ResetPassword(ResetPasswordViewModel model)
        //{

        //    if (!ModelState.IsValid)
        //    {
        //        return View(model);
        //    }
        //    var user = await UserManager.FindByNameAsync(model.Email);
        //    if (user == null)
        //    {
        //        Don't reveal that the user does not exist
        //        return RedirectToAction("ResetPasswordConfirmation", "Account");
        //    }
        //    var result = await UserManager.ResetPasswordAsync(user.Id, model.Code, model.Password);
        //    if (result.Succeeded)
        //    {
        //        return RedirectToAction("ResetPasswordConfirmation", "Account");
        //    }

        //    AddErrors(result);

        //    return View();
        //}

        //
        // GET: /Account/ResetPasswordConfirmation
        [AllowAnonymous]
        public ActionResult ResetPasswordConfirmation()
        {
            return View();
        }

        //
        // POST: /Account/LogOff
        //[HttpPost]
        //[ValidateAntiForgeryToken]
        public ActionResult Logout()
        {
            Response.Cookies["token"].Expires = DateTime.Now.AddDays(-1);
            FormsAuthentication.SignOut();
            return RedirectToAction("Login", "Account");
        }

    }
}