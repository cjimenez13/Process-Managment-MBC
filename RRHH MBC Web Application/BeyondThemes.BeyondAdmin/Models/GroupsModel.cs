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
    public class GroupsListModel
    {
        private GroupProvider groupProvider = new GroupProvider();
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
}
