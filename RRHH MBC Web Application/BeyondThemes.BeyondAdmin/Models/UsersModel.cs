using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;
using DataTransferObjects;
using BeyondThemes.BeyondAdmin.Providers;
using System.Web.Mvc;
using System.Web;

namespace Model
{
    public class ListUserModel
    {
        public List<UserDTO> usersList = new List<UserDTO>();
        private UsersProvider userProvider = new UsersProvider();
        public string searchValue;
        public ListUserModel()
        {
            usersList = userProvider.getUsers().Result;
        }
    }

    public class UserModel
    {
        public UserDTO user;
        private UsersProvider userProvider = new UsersProvider();
        public string userName;
        public UserModel(string pUser)
        {
            userName = pUser;
            user = userProvider.getUser(pUser).Result;
        }
    }
    public class UpdateUserModel : UserDTO
    {

    }
    public class ConfigProfileModel
    {
        public HttpPostedFile file { get; set; }
    }
    public class RegisterModel
    {
        private UsersProvider userProvider = new UsersProvider();
        public List<SelectListItem> _ProvincesSelect { get; set; }
        List<ProvinceDTO> _ProvincesList = new List<ProvinceDTO>();
        public List<SelectListItem> _CantonesSelect { get; set; }
        List<CantonDTO> _CantonesList;
        public RegisterModel()
        {
            _ProvincesSelect = new List<SelectListItem>();
            _CantonesSelect = new List<SelectListItem>();
            _ProvincesList = userProvider.getProvinces().Result;
            foreach (ProvinceDTO iProvince in _ProvincesList)
            {
                _ProvincesSelect.Add(new SelectListItem { Text = iProvince.name, Value = iProvince.id.ToString() });
            }
            //refreshCantones(1);
        }
        public bool refreshCantones(int pProvinceID)
        {
            _CantonesList = userProvider.getCantones(pProvinceID).Result;

            foreach (CantonDTO iCanton in _CantonesList)
            {
                _CantonesSelect.Add(new SelectListItem { Text = iCanton.name, Value = iCanton.id.ToString() });
            }
            return false;
        }
        [Display(Name = "Nombre")]
        [Required(ErrorMessage = "Se debe completar el campo del nombre")]
        [StringLength(30,ErrorMessage = "La cantidad máxima de caracteres es 30")]
        public string name { get; set; }

        [Display(Name = "Primer Apellido")]
        [Required(ErrorMessage = "Se debe completar el campo del primer apellido")]
        [StringLength(30, ErrorMessage = "La cantidad máxima de caracteres es 30")]
        public string fLastName { get; set; }

        [Display(Name = "Segundo Apellido")]
        [Required(ErrorMessage = "Se debe completar el campo del segundo apellido")]
        [StringLength(30, ErrorMessage = "La cantidad máxima de caracteres es 30")]
        public string sLastName { get; set; }

        [Display(Name = "Correo")]
        [Required(ErrorMessage = "Se debe completar el campo del correo")]
        [StringLength(50, ErrorMessage = "La cantidad máxima de caracteres es 50")]
        public string email { get; set; }

        [Display(Name = "Provincia")]
        //[Required(ErrorMessage = "Se debe completar el campo de la provincia")]
        public string province { get; set; }
        public int id_province { get; set; }
        public int id_canton { get; set; }

        [Display(Name = "Cantón")]
        //[Required(ErrorMessage = "Se debe completar el campo del cantón")]
        public string canton { get; set; }

        [Display(Name = "Dirección")]
        public string direction { get; set; }

        [Display(Name = "Teléfono")]
        [RegularExpression(@"[0-9]{8}",ErrorMessage = "El numero de teléfono debe tener 8 numeros")]
        public string phoneNumber { get; set; }

        [Display(Name = "Fecha de Nacimiento")]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:dd-MM-yyyy}", ApplyFormatInEditMode = true)]
        public string birthdate { get; set; }

        [Display(Name = "Usuario")]
        //[StringLength(30, ErrorMessage = "La cantidad máxima de caracteres es 30")]
        public string userName { get; set; }

        [Display(Name = "Cédula")]
        [RegularExpression(@"[0-9]{9}",ErrorMessage = "La cédula debe contener 9 numeros")]
        public string id { get; set; }



    }
}
