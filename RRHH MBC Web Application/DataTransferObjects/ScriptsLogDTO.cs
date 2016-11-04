using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataTransferObjects
{
    public class ScriptsLogDTO
    {
        public string script { get; set; }
        public string id_scriptLog { get; set; }
        public string ejecutedDate { get; set; }
        public string ejecutedBy { get; set; }
        public string ejecutedBy_name { get; set; }
        public string userLog { get; set; }
    }
}
