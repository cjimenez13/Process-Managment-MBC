using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using DataTransferObjects;
using BeyondThemes.BeyondAdmin.Providers;
using System.Web.Mvc;
using System.Web;

namespace Model
{
    public class EditUserAttributeModel
    {
        [Display(Name = "Valor")]
        [Required(ErrorMessage = "Se debe completar el campo del valor")]
        [StringLength(100, ErrorMessage = "La cantidad máxima de caracteres es 100")]
        public string value { get; set; }
        [Required]
        public string attribute_id { get; set; }
        [Required]
        public string user_id { get; set; }
        [Required]
        public string type_id { get; set; }
    }

    public class UserCategoriesModel
    {
        private UsersProvider userProvider = new UsersProvider();
        public List<CategorieDTO> userCategories = new List<CategorieDTO>();
        public string user_id;
        public UserCategoriesModel(string user_id)
        {
            this.user_id = user_id;
            userCategories = userProvider.getUserCategories(user_id).Result;
        }
    }
    public class UserAttributesModel
    {
        private UsersProvider userProvider = new UsersProvider();
        private CategorieProvider categorieProvider = new CategorieProvider();
        public List<PersonalAttributeDTOmin> userAttributes = new List<PersonalAttributeDTOmin>();
        public string user_id;
        public AttributeTypeDTO type = new AttributeTypeDTO();
        public UserAttributesModel(string user_id, string categorie_id)
        {
            this.user_id = user_id;
            userAttributes = userProvider.getUserAttributesbyCategorie(user_id, categorie_id).Result;
        }
        public string getTypeName(string id_type)
        {
            return categorieProvider.getAttributeType(id_type).Result.type;
        }
    }
    public class ListUserFilesModel
    {
        private UsersProvider userProvider = new UsersProvider();
        public List<FileDTO> filesList = new List<FileDTO>();
        public string user_id;
        public ListUserFilesModel(string pUser,string user_id)
        {
            this.user_id = user_id;
            filesList = userProvider.getFiles(pUser).Result;
        }
    }
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
        public string imageURL;
        public UserModel(string pUser)
        {
            userName = pUser;
            user = userProvider.getUser(pUser).Result;
            imageURL = "data:Image/png;base64," + user.photoBase64;
        }
    }
    public class UserRolesModel
    {
        private UsersProvider userProvider = new UsersProvider();
        private RoleProvider roleProvider = new RoleProvider();

        public List<RoleDTO> rolesList = new List<RoleDTO>();
        public List<RoleDTO> userRolesList = new List<RoleDTO>();
        public SelectList _RolesSelect { get; set; }
        public string user_id { get; set; }
        public UserRolesModel(string pUser_id)
        {
            user_id = pUser_id;
            userRolesList = userProvider.getUserRoles(pUser_id).Result;
            rolesList = roleProvider.getRoles().Result;
            List<SelectListItem> rolesSelectList = new List<SelectListItem>();
            foreach (RoleDTO iRole in rolesList)
            {
                rolesSelectList.Add(new SelectListItem { Text = iRole.name, Value = iRole.id_role });

            }
            _RolesSelect = new SelectList(rolesSelectList, "Value", "Text");
        }

        [Display(Name = "Rol")]
        [Required(ErrorMessage = "Se debe completar el campo del rol")]
        public string selectedRole { get; set; }
    }
    public class AddFileModel
    {
        private UsersProvider userProvider = new UsersProvider();

        public AddFileModel() { }
        public AddFileModel(string user_id)
        {
            this.user_id = user_id;
        }
        [Display(Name = "Nombre")]
        [Required(ErrorMessage = "Se debe completar el campo del nombre")]
        [StringLength(30, ErrorMessage = "La cantidad máxima de caracteres es 30")]
        public string name { get; set; }
        [Display(Name = "Descripción")]
        [Required(ErrorMessage = "Se debe completar el campo de la descripción")]
        [StringLength(50, ErrorMessage = "La cantidad máxima de caracteres es 50")]
        public string description { get; set; }
        public string user_id { get; set;}
    }
    public class ConfigProfileModel
    {
        public HttpPostedFile file { get; set; }
    }
    public class UpdateUserModel
    {
        private UsersProvider userProvider = new UsersProvider();
        public List<SelectListItem> _ProvincesSelect { get; set; }  
        List<ProvinceDTO> _ProvincesList = new List<ProvinceDTO>();
        public List<SelectListItem> _CantonesSelect { get; set; }
        List<CantonDTO> _CantonesList;
        public UserDTO userDTO = new UserDTO();
        public UpdateUserModel() { }
        public UpdateUserModel(UserDTO userDTO)
        {
            this.userDTO = userDTO;
            cedula = userDTO.id;
            name = userDTO.name;
            fLastName = userDTO.fLastName;
            sLastName = userDTO.sLastName;
            email = userDTO.email;
            province = userDTO.province_name;
            province_id = userDTO.province_id;
            canton_id = userDTO.canton_id;
            canton = userDTO.canton_name;
            direction = userDTO.direction;
            phoneNumber = userDTO.phoneNumber;
            birthdate = userDTO.birthdate;
            userName = userDTO.userName;
            user_id = userDTO.user_id;
            _ProvincesSelect = new List<SelectListItem>();
            _CantonesSelect = new List<SelectListItem>();
            _ProvincesList = userProvider.getProvinces().Result;
            foreach (ProvinceDTO iProvince in _ProvincesList)
            {
                _ProvincesSelect.Add(new SelectListItem { Text = iProvince.name, Value = iProvince.id.ToString() });
                int province_id;
                Int32.TryParse(userDTO.province_id, out province_id);
                refreshCantones(province_id);
            }
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
        [StringLength(30, ErrorMessage = "La cantidad máxima de caracteres es 30")]
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
        public string province_id { get; set; }
        public string canton_id { get; set; }

        [Display(Name = "Cantón")]
        //[Required(ErrorMessage = "Se debe completar el campo del cantón")]
        public string canton { get; set; }

        [Display(Name = "Dirección")]
        public string direction { get; set; }

        [Display(Name = "Teléfono")]
        [RegularExpression(@"[0-9]{8}", ErrorMessage = "El numero de teléfono debe tener 8 numeros")]
        public string phoneNumber { get; set; }

        [Display(Name = "Fecha de Nacimiento")]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:dd-MM-yyyy}", ApplyFormatInEditMode = true)]
        public string birthdate { get; set; }

        [Display(Name = "Usuario")]
        //[StringLength(30, ErrorMessage = "La cantidad máxima de caracteres es 30")]
        public string userName { get; set; }

        [Display(Name = "Cédula")]
        [RegularExpression(@"[0-9]{9}", ErrorMessage = "La cédula debe contener 9 numeros")]
        public string cedula { get; set; }
        public string user_id { get; set; } 

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
