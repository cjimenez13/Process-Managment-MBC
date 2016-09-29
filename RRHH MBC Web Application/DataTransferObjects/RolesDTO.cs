namespace DataTransferObjects
{
    public class RoleDTO
    {
        public string id_role { get; set; }
        public string name { get; set; }
        public string description { get; set; }
        public string permissions { get; set; }
        public string user_id { get; set; }
    }

    public class ModuleDTO
    {
        public string id_module { get; set; }
        public string name { get; set; }
    }
    public class PermissionDTO
    {
        public string id_permission { get; set; }
        public string name { get; set; }
        public string module_id { get; set; }
        public string isEnabled { get; set; }
        public string id_role_permission { get; set; }
    }
    public class ElementDTO
    {
        public string id_element { get; set; }
        public string name { get; set; }
        public string type_id { get; set; }
        public string type { get; set; }
        public string isEnabled { get; set; }
        public string role_permission_id { get; set; }
    }
}
