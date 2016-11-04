using BeyondThemes.BeyondAdmin.Providers;
using DataTransferObjects;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

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
    public class RoleModel
    {
        private RoleProvider roleProvider = new RoleProvider();
        public List<ModuleDTO> modulesList = new List<ModuleDTO>();
        public RoleDTO role = new RoleDTO();
        public string id_role;
        public RoleModel(string pId_role)
        {
            id_role = pId_role;
            modulesList = roleProvider.getModules().Result;
            role = roleProvider.getRole(pId_role).Result;
        }
    }
    public class PermissionsModel
    {
        private RoleProvider roleProvider = new RoleProvider();
        public List<PermissionDTO> permissionsList = new List<PermissionDTO>();
        public PermissionsModel(string id_role, string id_module)
        {
            permissionsList = roleProvider.getRolePermissions(id_module, id_role).Result;
        }
    }
    public class ElementsModel
    {
        private RoleProvider roleProvider = new RoleProvider();
        public List<ElementDTO> elementsList = new List<ElementDTO>();
        public ElementsModel(string id_rolePermission)
        {
            elementsList = roleProvider.getPermissionElements(id_rolePermission).Result;
        }
    }
}
