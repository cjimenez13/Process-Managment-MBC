namespace DataTransferObjects
{
    public class CategorieDTO
    {
        public string id_categorie { get; set; }
        public string name { get; set; }
        public string description { get; set; }
        public string createdBy_name { get; set; }
        public string createdBy_id { get; set; }
        public string createdDate { get; set; }
        public string isEnabled { get; set; }
    }

    public class AttributeTypeDTO
    {
        public string id_type { get; set; }
        public string type { get; set; }
        public string reg_expr { get; set; }
    }


    public class AttributeDTO
    {
        public string id_attribute { get; set; }
        public string categorie_id { get; set; }
        public string name { get; set; }
        public string type_id { get; set; }
        public string value { get; set; }
        public string isEnabled { get; set; }
        public string createdBy { get; set; }
        public string createdDate { get; set; }
        public string isGeneral { get; set; }
    }
    public class GeneralAttributeDTO : AttributeDTO
    {
        public string user { get; set; }
        public GeneralAttributeDTO()
        {
            isGeneral = "True";
        }
    }
    public class PersonalAttributeDTO : AttributeDTO
    {
        public string userLog { get; set; }
        public PersonalAttributeDTO()
        {
            isGeneral = "False";
        }
    }
    public class PersonalAttributeDTOmin
    {
        public string attribute_id { get; set; }
        public string value { get; set; }
        public string user_id { get; set; }
        public string isEnabled { get; set; }
        public string type_id { get; set; }
        public string name { get; set; }
        public string userLog { get; set; }
    }
    public class AttributeListDTO
    {
        public string id_attributeValue { get; set; }
        public string attribute_id { get; set; }
        public string name { get; set; }
        public string type_id { get; set; }
        public string value { get; set; }
        public string isEnabled { get; set; }
        public string createdBy { get; set; }
        public string createdDate { get; set; }
        public string user { get; set; }
    }
}
