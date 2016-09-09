using DataTransferObjects;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace Web_Service_API.DataAccess
{
    public class RolesData
    {
        //----------------------------------------- Gets -----------------------------------------
        public static List<RoleDTO> getRoles()
        {
            List<RoleDTO> roles = new List<RoleDTO>();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("sp_get_roles", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    RoleDTO rollDTO = new RoleDTO();
                    rollDTO.id_role = rdr["id_role"].ToString();
                    rollDTO.name = rdr["name"].ToString();
                    rollDTO.description = rdr["description"].ToString();
                    rollDTO.permissions = rdr["permissions"].ToString();
                    roles.Add(rollDTO);
                }
            };
            return roles;
        }

        public static List<ModuleDTO> getModules()
        {
            List<ModuleDTO> modules = new List<ModuleDTO>();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("sp_get_modules", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    ModuleDTO moduleDTO = new ModuleDTO();
                    moduleDTO.id_module = rdr["id_module"].ToString();
                    moduleDTO.name = rdr["name"].ToString();
                    modules.Add(moduleDTO);
                }
            };
            return modules;
        }
        public static List<PermissionDTO> getRolePermissions(string idRole, string idModule)
        {
            List<PermissionDTO> permissions = new List<PermissionDTO>();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("sp_get_rolePermissions_byModule", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("@role_id", SqlDbType.Int);
                command.Parameters["@role_id"].Value = idRole;
                command.Parameters.Add("@id_module", SqlDbType.Int);
                command.Parameters["@id_module"].Value = idModule;

                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    PermissionDTO permissionDTO = new PermissionDTO();
                    permissionDTO.id_permission = rdr["id_permission"].ToString();
                    permissionDTO.name = rdr["name"].ToString();
                    permissionDTO.module_id = rdr["id_permission"].ToString();
                    permissionDTO.isEnabled = rdr["isEnabled"].ToString();
                    permissionDTO.id_role_permission = rdr["id_role_permission"].ToString();
                    permissions.Add(permissionDTO);
                }
            };
            return permissions;
        }
        public static List<ElementDTO> getElements(string id_rolePermission)
        {
            List<ElementDTO> modules = new List<ElementDTO>();
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("sp_get_Elements", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@role_permission_id", SqlDbType.Int);
                command.Parameters["@role_permission_id"].Value = id_rolePermission;
                command.Connection.Open();
                SqlDataReader rdr = command.ExecuteReader();
                while (rdr.Read())
                {
                    ElementDTO elementDTO = new ElementDTO();
                    elementDTO.role_permission_id = rdr["role_permission_id"].ToString();
                    elementDTO.name = rdr["name"].ToString();
                    elementDTO.isEnabled = rdr["isEnabled"].ToString();
                    elementDTO.type = rdr["type"].ToString();
                    elementDTO.id_element = rdr["element_id"].ToString();
                    modules.Add(elementDTO);
                }
            };
            return modules;
        }
        //--------------------------------------------- Inserts --------------------------------------------
        public static string insertRoll(RoleDTO pRollDTO)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("sp_insert_role", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@name", SqlDbType.NVarChar);
                command.Parameters["@name"].Value = pRollDTO.name;

                command.Parameters.Add("@description", SqlDbType.NVarChar);
                command.Parameters["@description"].Value = pRollDTO.description;

                command.Connection.Open();
                string result = null;
                try
                {
                    result = command.ExecuteScalar().ToString();
                }
                catch (Exception e)
                {

                }
                return result;
            };
        }


        // ----------------------------------------------------- Updates --------------------------------------
        public static bool updateRoleElement(ElementDTO pElementDTO)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("sp_update_roleElement", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@element_id", SqlDbType.Int);
                command.Parameters["@element_id"].Value = pElementDTO.id_element;

                command.Parameters.Add("@role_permission_id", SqlDbType.Int);
                command.Parameters["@role_permission_id"].Value = pElementDTO.role_permission_id;

                command.Parameters.Add("@isEnabled", SqlDbType.Bit);
                command.Parameters["@isEnabled"].Value = pElementDTO.isEnabled;

                command.Connection.Open();
                int result = command.ExecuteNonQuery();
                if (result != 0)
                {
                    return true;
                }
                return false;
            };
        }
        public static bool updateRolePermission(PermissionDTO pPermissionDTO)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("sp_update_rolePermission", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@id_role_permission", SqlDbType.Int);
                command.Parameters["@id_role_permission"].Value = pPermissionDTO.id_role_permission;

                command.Parameters.Add("@isEnabled", SqlDbType.Bit);
                command.Parameters["@isEnabled"].Value = pPermissionDTO.isEnabled;

                command.Connection.Open();
                int result = command.ExecuteNonQuery();
                if (result != 0)
                {
                    return true;
                }
                return false;
            };
        }

        //------------------------------------------------ Deletes ----------------------------------------------------
        public static bool deleteRole(string id_role)
        {
            using (SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionRRHHDatabase"].ConnectionString))
            {
                SqlCommand command = new SqlCommand("sp_delete_role", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("@id_role", SqlDbType.Int);
                command.Parameters["@id_role"].Value = id_role;

                command.Connection.Open();
                string result = command.ExecuteScalar().ToString();
                if (result != "0")
                {
                    return true;
                }
            };
            return false;
        }
    }
}
