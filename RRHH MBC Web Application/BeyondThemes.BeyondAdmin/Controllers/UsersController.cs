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
        public ActionResult Profile(string id)
        {
            string user = HttpUtility.UrlDecode(id);
            return View(new UserModel(user));
        }
        /*
        [ChildActionOnly]
        public ActionResult _Register()
        {
            return PartialView();
        }
        */

        [HttpPost]
        public ActionResult UploadPhoto()
        {

            if (Request.Files.Count > 0)
            {
                try
                {
                    //  Get all files from Request object  
                    HttpFileCollectionBase files = Request.Files;
                    for (int i = 0; i < files.Count; i++)
                    {
                        //string path = AppDomain.CurrentDomain.BaseDirectory + "Uploads/";  
                        //string filename = Path.GetFileName(Request.Files[i].FileName);  

                        HttpPostedFileBase file = files[i];
                        string fname;

                        // Checking for Internet Explorer  
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
                        if (fileExtension == ".jpg" || fileExtension == "png")
                        {
                            Stream stream = file.InputStream;
                            BinaryReader binaryReader = new BinaryReader(stream);
                            byte[] bytes = binaryReader.ReadBytes((int)stream.Length);

                        }
                        // Get the complete folder path and store the file inside it.  
                        //fname = Path.Combine(Server.MapPath("~/Uploads/"), fname);
                        //file.SaveAs(fname);
                    }
                    // Returns message that successfully uploaded  
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
        [ValidateAntiForgeryToken]
        public ActionResult _ProfileConfig(RegisterModel model)
        {
            if (ModelState.IsValid)
            {
                UserDTO userDTO = new UserDTO();
                //userDTO.id =  model
                userDTO.name = model.name;
                userDTO.fLastName = model.fLastName;
                userDTO.sLastName = model.sLastName;
                userDTO.email = model.email;
                userDTO.phoneNumber = model.phoneNumber.ToString();
                userDTO.userName = model.userName;
                userDTO.canton_id = model.canton;
                if (userProvider.postUser(userDTO).Result)
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
                //userDTO.id =  model
                userDTO.name = model.name;
                userDTO.fLastName = model.fLastName;
                userDTO.sLastName = model.sLastName;
                userDTO.email = model.email;
                userDTO.phoneNumber = model.phoneNumber.ToString();
                userDTO.userName = model.userName;
                userDTO.canton_id = model.canton;
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