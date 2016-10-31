using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace BeyondThemes.BeyondAdmin.Models
{
    public class LoginViewModel
    {
        [Required(ErrorMessage = "Se debe completar el campo del usuario")]
        [Display(Name = "Email")]
        public string Email { get; set; }

        [Required(ErrorMessage = "Se debe completar el campo de la contraseña")]
        [DataType(DataType.Password)]
        [Display(Name = "Password")]
        public string Password { get; set; }

        public string forgot_email { get; set; }
    }

    public class ForgotPasswordViewModel
    {
        [Required]
        [EmailAddress]
        [Display(Name = "Email")]
        public string forgot_email { get; set; }
    }
}
