using BeyondThemes.BeyondAdmin.Providers;
using DataTransferObjects;

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
