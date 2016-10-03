using BeyondThemes.BeyondAdmin.Providers;
using DataTransferObjects;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;

namespace Model
{
    public class TemplateModel
    {
        private TemplatesProvider templateProvider = new TemplatesProvider();
        private UsersProvider userProvider = new UsersProvider();
        public TemplateDTO templateDTO = new TemplateDTO();
        public UserDTO userDTO = new UserDTO();
        public TemplateModel(string id)
        {
            templateDTO = templateProvider.getTemplate(id).Result;
            userDTO = userProvider.getUserbyID(templateDTO.createdBy).Result;
        }
    }
    public class TemplatesListModel
    {
        private TemplatesProvider templateProvider = new TemplatesProvider();
        public List<TemplateDTO> templatesDTO = new List<TemplateDTO>();
        public TemplatesListModel()
        {
            templatesDTO = templateProvider.getTemplates().Result;
        }
    }
    public class AddTemplateModel
    {
        private CategorieProvider categorieProvider = new CategorieProvider();
        public List<CategorieDTO> categoriesList = new List<CategorieDTO>();
        public SelectList _CategoriesSelect { get; set; }
        public AddTemplateModel()
        {
            categoriesList = categorieProvider.getCategories().Result;
            List<SelectListItem> categoriesSelectList = new List<SelectListItem>();
            foreach (CategorieDTO iCategorie in categoriesList)
            {
                categoriesSelectList.Add(new SelectListItem { Text = iCategorie.name, Value = iCategorie.id_categorie });
            }
            _CategoriesSelect = new SelectList(categoriesSelectList, "Value", "Text");
        }
        [Display(Name = "Nombre")]
        [Required(ErrorMessage = "Se debe completar el campo del nombre")]
        [StringLength(100, ErrorMessage = "La cantidad máxima de caracteres es 100")]
        public string name { get; set; }

        [Display(Name = "Categoría")]
        [Required(ErrorMessage = "Se debe completar el campo de la categoría")]
        public string categorie_id { get; set; }
    }

    public class EditTemplateModel
    {
        public EditTemplateModel(TemplateDTO template)
        {
            name = template.name;
            template_id = template.id_processManagment;
        }
        [Display(Name = "Nombre")]
        [Required(ErrorMessage = "Se debe completar el campo del nombre")]
        [StringLength(100, ErrorMessage = "La cantidad máxima de caracteres es 100")]
        public string name { get; set; }

        [Required]
        public string template_id { get; set; }
    }
    public class ParticipantModel
    {
        private TemplatesProvider templateProvider = new TemplatesProvider();
        public List<TemplateDTO> templatesDTO = new List<TemplateDTO>();
        public ParticipantModel()
        {
            templatesDTO = templateProvider.getTemplates().Result;
        }
    }

}
