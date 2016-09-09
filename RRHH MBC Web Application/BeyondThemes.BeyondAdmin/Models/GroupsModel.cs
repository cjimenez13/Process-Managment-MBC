using BeyondThemes.BeyondAdmin.Providers;
using DataTransferObjects;
using System;
using System.Collections.Generic;
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
}
