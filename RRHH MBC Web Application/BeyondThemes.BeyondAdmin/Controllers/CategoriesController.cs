using BeyondThemes.BeyondAdmin.Providers;
using DataTransferObjects;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Web.Mvc;

namespace BeyondThemes.BeyondAdmin.Controllers
{
    [ValidateLogin]
    public class CategoriesController : Controller
    {
        CategorieProvider categorieProvider = new CategorieProvider();
        // GET: Categories
        public ActionResult Index()
        {
            return View(new Model.CategoriesListModel());
        }
        public ActionResult Categorie(string id)
        {
            return View(new Model.CategorieModel(id));
        }
        public ActionResult _CategoriesList()
        {
            return PartialView("/Views/Categories/_CategoriesList.cshtml", new Model.CategoriesListModel());
        }
        public ActionResult _GeneralAttrList(string categorie_id)
        {
            return PartialView("/Views/Categories/_GeneralAttrList.cshtml", new Model.GeneralAttributesModel(categorie_id));
        }
        public ActionResult _CategorieGeneralAtr(string categorie_id)
        {
            return PartialView("/Views/Categories/_CategorieGeneralAtr.cshtml", new Model.GeneralAttributesModel(categorie_id));
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult _AddCategorie(Model.AddCategorieModel pModel)
        {
            CategorieDTO categorieDTO = new CategorieDTO();
            categorieDTO.name = pModel.name;
            categorieDTO.description = pModel.description;
            string user = Request.Cookies["user"].Value;
            UserDTO userDTO = new UsersProvider().getUser(user).Result;

            categorieDTO.createdBy_id = userDTO.user_id;
            categorieDTO.createdBy_name = userDTO.name + " " + userDTO.fLastName + " " + userDTO.sLastName;

            if (categorieProvider.postCategorie(categorieDTO).Result)
            {
                return _CategoriesList();
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }
        
        [HttpPut]
        public ActionResult _EditCategorie(string name, string description, bool isEnabled, string id_categorie)
        {
            CategorieDTO categorieDTO = new CategorieDTO();
            categorieDTO.name = name;
            categorieDTO.description = description;
            categorieDTO.isEnabled = isEnabled.ToString();
            categorieDTO.id_categorie = id_categorie;
            if (categorieProvider.putCategorie(categorieDTO).Result)
            {
                return Json(categorieDTO);
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }

        [HttpDelete]
        [ValidateAntiForgeryToken]
        public ActionResult _DeleteCategorieRedirect(string id_categorie)
        {
            CategorieDTO categorieDTO  = new CategorieDTO();
            categorieDTO.id_categorie = id_categorie;
            if (categorieProvider.deleteCategorie(categorieDTO).Result)
            {
                return RedirectToAction("Index", "Categories");
            }
            return new HttpStatusCodeResult(404, "Can't find that");
        }
        
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult _AddGeneralAttribute(Model.AddGeneralAttributeModel pModel)
        {
            if (ModelState.IsValid || (pModel.id_typeA == "4" && pModel.attributeA != null) )
            {
                AttributeTypeDTO attributesType = categorieProvider.getAttributeType(pModel.id_typeA).Result;
                Regex r = new Regex(attributesType.reg_expr);
                GeneralAttributeDTO generalAttributeDTO = new GeneralAttributeDTO();
                if (attributesType.reg_expr == "" || r.Match(pModel.valueA).Success)
                {
                    generalAttributeDTO.name = pModel.attributeA;
                    generalAttributeDTO.value = pModel.valueA != null ? pModel.valueA : "";
                    generalAttributeDTO.type_id = pModel.id_typeA;
                    generalAttributeDTO.user = Request.Cookies["user_id"].Value;
                    generalAttributeDTO.createdBy = generalAttributeDTO.user;
                    generalAttributeDTO.categorie_id = pModel.categorie_idA;
                    if (categorieProvider.postGeneralAttribute(generalAttributeDTO).Result)
                    {
                        return _GeneralAttrList(pModel.categorie_idA);
                        //return _CategorieGeneralAtr(pModel.categorie_id);
                    }
                }
                else
                {
                    return new HttpStatusCodeResult(404, "Error, el campo valor es inválido");
                }
            }
            else
            {
                return new HttpStatusCodeResult(404, "Error, debe completar todos los campos");
            }
            return new HttpStatusCodeResult(404, "Error, no se puede agregar el atributo");
        }

        [HttpPut]
        [ValidateAntiForgeryToken]
        public ActionResult _EditGeneralAttribute(Model.EditGeneralAttributeModel pModel)
        {
            if (ModelState.IsValid || (pModel.id_type == "4" && pModel.attribute != null))
            {
                AttributeTypeDTO attributesType = categorieProvider.getAttributeType(pModel.id_type).Result;
                Regex r = new Regex("^"+attributesType.reg_expr+ "$");
                GeneralAttributeDTO generalAttributeDTO = new GeneralAttributeDTO();
                if (attributesType.reg_expr == "" || r.Match(pModel.value).Success)
                {
                    generalAttributeDTO.name = pModel.attribute;
                    generalAttributeDTO.value = pModel.value;
                    generalAttributeDTO.type_id = pModel.id_type;
                    generalAttributeDTO.isEnabled = pModel.isEnabled == "on" ? "true" : "false";
                    generalAttributeDTO.user = Request.Cookies["user_id"].Value;
                    generalAttributeDTO.id_attribute = pModel.id_attribute;
                    if (categorieProvider.putGeneralAttribute(generalAttributeDTO).Result)
                    {
                        return new HttpStatusCodeResult(200);
                    }
                }
                else
                {
                    return new HttpStatusCodeResult(404, "El campo valor es inválido");
                }
            }
            else
            {
                foreach (ModelState modelState in ViewData.ModelState.Values)
                {
                    foreach (ModelError error in modelState.Errors)
                    {
                        string sError = error.ErrorMessage;
                    }
                }
                return new HttpStatusCodeResult(404, "Error, debe completar todos los campos");
            }
            return new HttpStatusCodeResult(404, "Error, no se puede agregar el atributo");
        }
        [HttpDelete]
        public ActionResult _DeleteGeneralAttribute(string id_attribute)
        {
            GeneralAttributeDTO generalAttributeDTO = new GeneralAttributeDTO();
            generalAttributeDTO.id_attribute = id_attribute;
            generalAttributeDTO.user = Request.Cookies["user_id"].Value; ;
            if (categorieProvider.deleteGeneralAttribute(generalAttributeDTO).Result)
            {
                return new HttpStatusCodeResult(200);
            }
            return new HttpStatusCodeResult(404, "Error, el atributo no se puede eliminar");
        }

        //------------------------------------------ Attributes List ----------------------------------------------
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult _AddAttributeList(Model.AddAttributeListModel pModel)
        {
            if (ModelState.IsValid)
            {
                AttributeTypeDTO attributesTypes = categorieProvider.getAttributeType(pModel.id_type).Result;
                Regex r = new Regex(attributesTypes.reg_expr);
                AttributeListDTO generalAttributeDTO = new AttributeListDTO();
                if (!r.IsMatch(pModel.value))
                {
                    generalAttributeDTO.name = pModel.attribute;
                    generalAttributeDTO.value = pModel.value;
                    generalAttributeDTO.type_id = pModel.id_type;
                    generalAttributeDTO.user = Request.Cookies["user_id"].Value;
                    generalAttributeDTO.createdBy = generalAttributeDTO.user;
                    generalAttributeDTO.attribute_id = pModel.attribute_id;
                    if (categorieProvider.postAttributeList(generalAttributeDTO).Result)
                    {
                        return _GeneralAttrList(pModel.attribute_id);
                    }
                }
                else
                {
                    return new HttpStatusCodeResult(404, "El campo valor es inválido");
                }
            }
            return new HttpStatusCodeResult(404, "Error no se puede agregar el atributo");
        }
    }
}