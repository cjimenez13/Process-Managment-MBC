using BeyondThemes.BeyondAdmin.Providers;
using DataTransferObjects;
using Model;
using System;
using System.Collections.Generic;
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