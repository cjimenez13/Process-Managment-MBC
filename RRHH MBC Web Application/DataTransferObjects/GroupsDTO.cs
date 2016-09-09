using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataTransferObjects
{
    public class GroupDTO
    {
        public string id_group { get; set; }
        public string groupName { get; set; }
        public string createdDate { get; set; }
        public string isEnabled { get; set; }
        public string user_id { get; set; }
    }
}
