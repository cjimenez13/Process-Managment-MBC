using BeyondThemes.BeyondAdmin.Providers;
using DataTransferObjects;
using System.ComponentModel.DataAnnotations;

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
    public class PasswordForgottedModel
    {
        [Display(Name = "Correo")]
        [Required(ErrorMessage = "Se debe completar el campo del correo")]
        [StringLength(100, ErrorMessage = "La cantidad máxima de caracteres es 100")]
        public string email { get; set; }
    }
}
