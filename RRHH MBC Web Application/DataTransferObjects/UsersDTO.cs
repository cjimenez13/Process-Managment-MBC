using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataTransferObjects
{
    public class FileDTO
    {
        public byte[] fileData { get; set; }
        public string user { get; set; }
        public string fileName { get; set; }

    }
    public class UserDTO
    {
        public string user_id { get; set; }
        public string id { get; set; }
        public string name { get; set; }
        public string fLastName { get; set; }
        public string sLastName { get; set; }
        public string email { get; set; }
        public string province_name { get; set; }
        public string province_id { get; set; }
        public string canton_id { get; set; }
        public string canton_name { get; set; }
        public string direction { get; set; }
        public string phoneNumber { get; set; }
        public string birthdate { get; set; }
        public string userName { get; set; }
        public byte[] photoData { get; set; }
        public string photoBase64 { get; set; }
    }
    public class ProvinceDTO
    {
        public string name { get; set; }
        public int id { get; set; }

        public ProvinceDTO(int pID, string pName)
        {
            name = pName;
            id = pID;
        }
        public ProvinceDTO() { }

    }
    public class CantonDTO
    {
        public string name { get; set; }
        public int id { get; set; }
        public int province_id { get; set; }
        public string province_name { get; set; }
        public CantonDTO(int pID, string pName, int pProvince_id, string pProvince_name)
        {
            name = pName;
            id = pID;
        }
        public CantonDTO() { }
    }
}
