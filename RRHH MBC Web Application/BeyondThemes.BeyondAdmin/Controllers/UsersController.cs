using BeyondThemes.BeyondAdmin.Providers;
using DataTransferObjects;
using Model;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web;
using System.Web.Configuration;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace BeyondThemes.BeyondAdmin.Controllers
{
    public class UsersController : Controller
    {
        UsersProvider userProvider = new UsersProvider();
        // GET: Users
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult Group()
        {
            return View();
        }
        public new ActionResult Profile(string id)
        {
            string user = HttpUtility.UrlDecode(id);
            return View(new UserModel(user));
        }

        [HttpPost]
        public ActionResult UploadFile(string user)
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
                                return Json("File Uploaded Successfully!");
                            }
                        }
                        //fname = Path.Combine(Server.MapPath("~/Uploads/"), fname);
                        //file.SaveAs(fname);
                    }
                    return Json("File Uploaded Successfully!");
                }
                catch (Exception ex)
                {
                    return Json("Error occurred. Error details: " + ex.Message);
                }
            }
            else
            {
                return Json("No files selected.");
            }
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
                                return Json("File Uploaded Successfully!");
                            }
                        }
                        //fname = Path.Combine(Server.MapPath("~/Uploads/"), fname);
                        //file.SaveAs(fname);
                    }
                    return Json("File Uploaded Successfully!");
                }
                catch (Exception ex)
                {
                    return Json("Error occurred. Error details: " + ex.Message);
                }
            }
            else
            {
                return Json("No files selected.");
            }
        }

        [HttpPut]
        public ActionResult _ProfileConfig(UpdateUserModel model)
        {
            if (ModelState.IsValid)
            {
                string selectedCanton = Request.Form["canton_id"].ToString();
                UserDTO userDTO = new UserDTO();
                userDTO.id = model.id;
                userDTO.name = model.name;
                userDTO.fLastName = model.fLastName;
                userDTO.sLastName = model.sLastName;
                userDTO.email = model.email;
                userDTO.phoneNumber = model.phoneNumber.ToString();
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
                userDTO.phoneNumber = model.phoneNumber.ToString();
                userDTO.userName = model.userName;
                userDTO.canton_id = model.canton;
                userDTO.direction = model.direction;
                userDTO.birthdate = model.birthdate;
                if (userProvider.postUser(userDTO).Result)
                {
                    return new HttpStatusCodeResult(200);
                }
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }
        public ActionResult getCantones(string pProvinceID)
        {
            int id;
            Int32.TryParse(pProvinceID, out id);
            List<CantonDTO> cantones;
            cantones = userProvider.getCantones(id).Result;
            return Json(cantones, JsonRequestBehavior.AllowGet);
        }

    }
}