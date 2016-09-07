using BeyondThemes.BeyondAdmin.Providers;
using DataTransferObjects;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class AddRoleModel
    {

        public RolesListModel rolesListModel { get; set; }
        public AddRoleModel()
        {
        }
        [Display(Name = "Nombre del rol")]
        [Required(ErrorMessage = "Se debe completar el campo del nombre")]
        [StringLength(30, ErrorMessage = "La cantidad máxima de caracteres es 30")]
        public string name { get; set; }

        [Display(Name = "Descripción")]
        [Required(ErrorMessage = "Se debe completar el campo del descripción")]
        [StringLength(50, ErrorMessage = "La cantidad máxima de caracteres es 50")]
        public string description { get; set; }
    }
    public class RolesListModel
    {
        private RoleProvider roleProvider = new RoleProvider();
        public List<RoleDTO> rolesList = new List<RoleDTO>();
        public RolesListModel()
        {
            rolesList = roleProvider.getRoles().Result;
        }
    }

}
