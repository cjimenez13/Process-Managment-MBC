using BeyondThemes.BeyondAdmin.Providers;
using DataTransferObjects;
using Model;
using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using System.Web.Mvc;
using BeyondThemes.BeyondAdmin.Tools;
using System.Text.RegularExpressions;

namespace BeyondThemes.BeyondAdmin.Controllers
{

    public class UsersController : Controller
    {
        UsersProvider userProvider = new UsersProvider();
        GroupProvider groupProvider = new GroupProvider();
        CategorieProvider categorieProvider = new CategorieProvider();

        // GET: Users
        [Authorize]
        [ValidateLogin]
        public ActionResult Index()
        {
            return View();
        }
        [Authorize]
        [ValidateLogin]
        public ActionResult Group(string id)
        {
            GroupModel groupModel = new GroupModel(id);
            if(groupModel.groupDTO.groupName != null)
                return View(groupModel);
            else
                return View("/Views/Home/Error404.cshtml");
        }
        [Authorize]
        [ValidateLogin]
        public new ActionResult Profile(string id)
        {
            string user = HttpUtility.UrlDecode(id);
            UserModel model = new UserModel(user);
            if (model.user.id != null)
                return View(model); 
            else
                return View("/Views/Home/Error404.cshtml");
        }
        [Authorize]
        [HttpGet]
        public ActionResult _UsersList()
        {
            return PartialView("/Views/Users/_Index/_UsersList.cshtml", new Model.ListUserModel());
        }
        [Authorize]
        [HttpGet]
        public ActionResult _ProfileConfigRoles(string user_id)
        {
            return PartialView("/Views/Users/_Profile/_ProfileConfigRoles.cshtml", new Model.UserRolesModel(user_id));
        }
        [Authorize]
        [HttpGet]
        public ActionResult _GroupList()
        {
            return PartialView("/Views/Users/_Index/_GroupsList.cshtml", new Model.GroupsListModel());
        }
        [Authorize]
        [HttpGet]
        public ActionResult _GroupUsersList(string id_group)
        {
            return PartialView("/Views/Users/_Group/GroupsUsersList.cshtml", new Model.GroupModel(id_group));
        } 

        public ActionResult getCantones(string pProvinceID)
        {
            int id;
            Int32.TryParse(pProvinceID, out id);
            List<CantonDTO> cantones;
            cantones = userProvider.getCantones(id).Result;
            return Json(cantones, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult UploadFile(AddFileModel model)
        {
            if (Request.Files.Count > 0)
            {
                try
                {
                    HttpFileCollectionBase files = Request.Files;
                    for (int i = 0; i < files.Count; i++)
                    {
                        HttpPostedFileBase file = files[i];
                        string fname = file.FileName;
                        string fileName = Path.GetFileName(fname);
                        string fileExtension = Path.GetExtension(fileName).ToLower();
                        int fileSize = file.ContentLength;
                        Stream stream = file.InputStream;
                        BinaryReader binaryReader = new BinaryReader(stream);
                        byte[] bytes = binaryReader.ReadBytes((int)stream.Length);
                        FileDTO fileDTO = new FileDTO();
                        fileDTO.fileData = bytes;
                        fileDTO.user = model.user_id;
                        fileDTO.name = model.name;
                        fileDTO.description = model.description;
                        fileDTO.fileName = fileName;
                        fileDTO.fileType = file.ContentType;
                        if (userProvider.putFile(fileDTO).Result)
                        {
                            return new HttpStatusCodeResult(200, "El archivo se cargo con éxito");
                        }
                    }
                    return new HttpStatusCodeResult(404, "Error, el archivo no se puede cargar");
                }
                catch (Exception ex)
                {
                    return new HttpStatusCodeResult(404, "Error, el archivo no se puede cargar");
                }
            }
            else
            {
                return new HttpStatusCodeResult(404, "Error, No se selecciono ningun archivo");
            }
        }

        [HttpDelete]
        public ActionResult _DeleteUserFile(string id_file)
        {
            FileDTO fileDTO = new FileDTO();
            fileDTO.id_file = id_file;
            if (userProvider.deleteUserFile(fileDTO).Result)
            {
                return new HttpStatusCodeResult(200);
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }

        [HttpPost]
        public ActionResult UploadPhoto(string user)
        {
            if (Request.Files.Count > 0)
            {
                try
                {
                    HttpFileCollectionBase files = Request.Files;
                    for (int i = 0; i < files.Count; i++)
                    {
                        HttpPostedFileBase file = files[i];
                        string fname;
                        if (Request.Browser.Browser.ToUpper() == "IE" || Request.Browser.Browser.ToUpper() == "INTERNETEXPLORER")
                        {
                            string[] testfiles = file.FileName.Split(new char[] { '\\' });
                            fname = testfiles[testfiles.Length - 1];
                        }
                        else
                        {
                            fname = file.FileName;
                        }
                        string fileName = Path.GetFileName(fname);
                        string fileExtension = Path.GetExtension(fileName).ToLower();
                        int fileSize = file.ContentLength;
                        if (fileExtension == ".jpg" || fileExtension == ".png")
                        {
                            Stream stream = file.InputStream;
                            BinaryReader binaryReader = new BinaryReader(stream);
                            byte[] bytes = binaryReader.ReadBytes((int)stream.Length);
                            FileDTO fileDTO = new FileDTO();
                            fileDTO.fileData = bytes;
                            fileDTO.user = user;
                            if (userProvider.putPhoto(fileDTO).Result)
                            {
                                return new HttpStatusCodeResult(200, "El archivo se cargo con éxito");
                            }
                        }
                        //fname = Path.Combine(Server.MapPath("~/Uploads/"), fname);
                        //file.SaveAs(fname);
                    }
                    return new HttpStatusCodeResult(404, "Error, el archivo no se puede cargar");
                }
                catch (Exception ex)
                {
                    return new HttpStatusCodeResult(404, "Error, el archivo no se puede cargar");
                }
            }
            else
            {
                return new HttpStatusCodeResult(404, "Error, No se selecciono ningun archivo");
            }
        }

        [HttpPut]
        public ActionResult _ProfileConfigInfo(UpdateUserModel model)
        {
            if (ModelState.IsValid)
            {
                string selectedCanton = Request.Form["canton_id"].ToString();
                UserDTO userDTO = new UserDTO();
                userDTO.id = model.cedula;
                userDTO.name = model.name;
                userDTO.fLastName = model.fLastName;
                userDTO.sLastName = model.sLastName;
                userDTO.email = model.email;
                userDTO.phoneNumber = model.phoneNumber;
                userDTO.userName = model.userName;
                userDTO.canton_id = selectedCanton;
                userDTO.direction = model.direction;
                userDTO.birthdate = model.birthdate;

                if (userProvider.putUser(userDTO).Result)
                {
                    return new HttpStatusCodeResult(200);
                }
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult _Register(RegisterModel model)
        {
            if (ModelState.IsValid)
            {
                UserDTO userDTO = new UserDTO();
                userDTO.id = model.id;
                userDTO.name = model.name;
                userDTO.fLastName = model.fLastName;
                userDTO.sLastName = model.sLastName;
                userDTO.email = model.email;
                userDTO.phoneNumber = model.phoneNumber;
                userDTO.userName = model.userName;
                userDTO.canton_id = model.canton;
                userDTO.direction = model.direction;
                userDTO.birthdate = model.birthdate;
                if (userProvider.postUser(userDTO).Result)
                {
                    return _UsersList();
                }
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }

        [HttpPost]
        public ActionResult _AddUserRole(string user_id, string selectedRole)
        {
            if (ModelState.IsValid)
            {
                RoleDTO roleDTO = new RoleDTO();
                roleDTO.id_role = selectedRole;
                roleDTO.user_id = user_id;
                if (userProvider.postUserRole(roleDTO).Result)
                {
                    return _ProfileConfigRoles(user_id);
                }
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }
        [HttpDelete]
        public ActionResult _DeleteUserRole(string user_id, string id_role)
        {
            RoleDTO roleDTO = new RoleDTO();
            roleDTO.id_role = id_role;
            roleDTO.user_id = user_id;
            if (userProvider.deleteUsersRole(roleDTO).Result)
            {
                return new HttpStatusCodeResult(200);
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }

        [HttpPost]
        public ActionResult _AddGroup(string name)
        {
            if (ModelState.IsValid)
            {
                GroupDTO groupDTO = new GroupDTO();
                groupDTO.groupName = name;
                if (groupProvider.postGroup(groupDTO).Result)
                {
                    return _GroupList();
                }
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }

        [HttpPut]
        public ActionResult _EditGroup(string id_group, string name)
        {
            if (ModelState.IsValid)
            {
                GroupDTO groupDTO = new GroupDTO();
                groupDTO.id_group = id_group;
                groupDTO.groupName = name;
                if (groupProvider.putGroup(groupDTO).Result)
                {
                    return Json(groupDTO);
                }
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }

        [HttpDelete]
        public ActionResult _DeleteGroup(string group_id)
        {
            GroupDTO groupDTO = new GroupDTO();
            groupDTO.id_group = group_id;
            if (groupProvider.deleteGroup(groupDTO).Result)
            {
                return new HttpStatusCodeResult(200);
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }
        [HttpDelete]
        public ActionResult _DeleteGroupRedirect(string id_group)
        {
            GroupDTO groupDTO = new GroupDTO();
            groupDTO.id_group = id_group;
            if (groupProvider.deleteGroup(groupDTO).Result)
            {
                return RedirectToAction("Index","Users");
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }
        [HttpPost]
        public ActionResult _AddGroupUsers(string id_group, List<string> selected_userGroup_id)
        {
            if (ModelState.IsValid)
            {
                //Getting data to post
                List<GroupUserDTO> groupUserDTOList = new List<GroupUserDTO>();
                foreach(var user_id in selected_userGroup_id)
                {
                    GroupUserDTO groupUserDTO = new GroupUserDTO();
                    groupUserDTO.id_group = id_group;
                    groupUserDTO.user_id = user_id;
                    groupUserDTOList.Add(groupUserDTO);
                }
                //Post
                List<GroupUserDTO> groupUsersAdded = new List<GroupUserDTO>();
                List<GroupUserDTO> groupUserError = new List<GroupUserDTO>();
                groupUsersAdded = groupProvider.postUsersGroups(groupUserDTOList).Result;
                if (groupUsersAdded.Count != 0)
                {
                    //Compare and get not added users
                    foreach (var user_added in groupUsersAdded)
                    {
                        bool isAdded = false;
                        foreach (var user_id in selected_userGroup_id)
                        {
                            if (user_id == user_added.user_id)
                            {
                                isAdded = true;
                                break;
                            }
                        }
                        if (!isAdded)
                        {
                            groupUserError.Add(user_added);
                            groupUsersAdded.Remove(user_added);
                        }
                    }
                    // creates a json to return result
                    var result = new { usersAdded = groupUsersAdded, usersError = groupUserError, viewHtml = PartialView("/Views/Users/_Group/_GroupUsersList.cshtml", new Model.GroupModel(id_group)).RenderToString()};
                    return Json(result);
                }
            }
            return new HttpStatusCodeResult(404, "Repeated users");
        }
        [HttpDelete]
        public ActionResult _DeleteGroupUser(string group_id, string user_id)
        {
            GroupUserDTO groupUserDTO = new GroupUserDTO();
            groupUserDTO.id_group = group_id;
            groupUserDTO.user_id = user_id;
            if (groupProvider.deleteGroupUser(groupUserDTO).Result)
            {
                return new HttpStatusCodeResult(200);
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }
        [HttpPut]
        public JsonResult _EditUserAttribute(Model.EditUserAttributeModel model)
        {
            if (ModelState.IsValid)
            {
                AttributeTypeDTO attributesType = categorieProvider.getAttributeType(model.type_id).Result;
                Regex r = new Regex(attributesType.reg_expr);
                if (r.Match(model.value).Success)
                {
                    PersonalAttributeDTOmin userAttribute = new PersonalAttributeDTOmin();
                    userAttribute.attribute_id = model.attribute_id;
                    userAttribute.value = model.value;
                    userAttribute.user_id = model.user_id;
                    userAttribute.userLog = Request.Cookies["user_id"].Value;
                    if (userProvider.putUserAttribute(userAttribute).Result)
                    {
                        Response.StatusCode = 200;
                        return Json(model, JsonRequestBehavior.AllowGet);
                        //return new HttpStatusCodeResult(200, "hola");
                    }
                }
                Response.StatusCode = 400;
                Response.StatusDescription = "El campo valor es incorrecto";
                return Json(new { error = "El campo valor es incorrecto" }, JsonRequestBehavior.AllowGet);
            }
            Response.StatusCode = 400;
            Response.StatusDescription = "Error, debe completar todos los campos";
            return Json(new { error = "Error, debe completar todos los campos" }, JsonRequestBehavior.AllowGet);
        }

    }
    
}