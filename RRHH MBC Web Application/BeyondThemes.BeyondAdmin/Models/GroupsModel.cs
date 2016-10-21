using BeyondThemes.BeyondAdmin.Providers;
using DataTransferObjects;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;

namespace Model
{
    public class GroupsListModel
    {
        public GroupProvider groupProvider = new GroupProvider();
        public List<GroupDTO> groupsList = new List<GroupDTO>();
        public GroupsListModel()
        {
            groupsList = groupProvider.getGroups().Result;
        }
    }
    public class GroupModel
    {
        private GroupProvider groupProvider = new GroupProvider();
        public GroupDTO groupDTO = new GroupDTO();
        public List<UserDTO> groupUsers = new List<UserDTO>();
        public GroupModel(string group_id)
        {
            groupDTO = groupProvider.getGroup(group_id).Result;
            groupUsers = groupProvider.getGroupMembers(group_id).Result;
        }
    }
    public class AddGroup
    {
        private GroupProvider groupProvider = new GroupProvider();
        public AddGroup(string group_id)
        {
        }

        [Display(Name = "Nombre")]
        [Required(ErrorMessage = "Se debe completar el campo del nombre")]
        [StringLength(30, ErrorMessage = "La cantidad máxima de caracteres es 30")]
        public string name { get; set; }
    }

    public class EditGroup
    {
        private GroupProvider groupProvider = new GroupProvider();
        public EditGroup(string group_id, string groupName)
        {
            name = groupName;
            id_group = group_id;
        }

        [Display(Name = "Nombre")]
        [Required(ErrorMessage = "Se debe completar el campo del nombre")]
        [StringLength(30, ErrorMessage = "La cantidad máxima de caracteres es 30")]
        public string name { get; set; }

        [Required(ErrorMessage = "Se debe completar el campo del nombre")]
        public string id_group { get; set; }
    }

    public class AddGroupUser
    {
        private GroupProvider groupProvider = new GroupProvider();
        private UsersProvider userProvider = new UsersProvider();
        public List<UserDTO> userList = new List<UserDTO>();
        public SelectList _UsersSelect { get; set; }
        public AddGroupUser(string group_id, string groupName)
        {
            userList = userProvider.getUsers().Result;
            List<SelectListItem> usersSelectList = new List<SelectListItem>();
            foreach (UserDTO iUser in userList)
            {
                var name = iUser.name + " " + iUser.fLastName + " " + iUser.sLastName;
                usersSelectList.Add(new SelectListItem { Text = name, Value = iUser.user_id });
            }
            _UsersSelect = new SelectList(usersSelectList, "Value", "Text");
            name = groupName;
            id_group = group_id;
        }

        [Display(Name = "Nombre")]
        [Required(ErrorMessage = "Se debe completar el campo del nombre")]
        [StringLength(30, ErrorMessage = "La cantidad máxima de caracteres es 30")]
        public string name { get; set; }

        [Required(ErrorMessage = "Se debe completar el campo del nombre")]
        public string id_group { get; set; }

        [Display(Name = "Usuarios")]
        [Required(ErrorMessage = "Se debe seleccionar al menos un usuario")]
        public string selected_userGroup_id { get; set; }
    }
}
