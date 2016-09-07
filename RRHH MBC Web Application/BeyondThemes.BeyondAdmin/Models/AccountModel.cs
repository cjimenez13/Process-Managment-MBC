using BeyondThemes.BeyondAdmin.Providers;
using DataTransferObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Security;

namespace Model
{
    public class AccountModel
    {
        public string user { get; set; }
        public UserDTO userDTO { get; set; }
        private UsersProvider userProvider = new UsersProvider();
        public string imageURL { get; set; }
        public AccountModel(string pUser)
        {
            user = pUser;
            userDTO = userProvider.getUser(user).Result;
            imageURL = "data:Image/png;base64," + userDTO.photoBase64;
        }
    }
}
