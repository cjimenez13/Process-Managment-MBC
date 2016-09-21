using BeyondThemes.BeyondAdmin.Providers;
using DataTransferObjects;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;

namespace Model
{
    public class CategoriesListModel
    {
        private CategorieProvider categorieProvider = new CategorieProvider();
        public List<CategorieDTO> categoriesList = new List<CategorieDTO>();
        public CategoriesListModel()
        {
            categoriesList = categorieProvider.getCategories().Result;
        }
    }
    public class CategorieModel
    {
        private CategorieProvider categorieProvider = new CategorieProvider();
        public CategorieDTO categorie = new CategorieDTO();
        public CategorieModel(string id_categorie)
        {
            categorie = categorieProvider.getCategorie(id_categorie).Result;
        }
    }
    public class AddCategorieModel
    {
        private CategorieProvider categorieProvider = new CategorieProvider();
        public AddCategorieModel()
        {
        }

        [Display(Name = "Nombre")]
        [Required(ErrorMessage = "Se debe completar el campo del nombre")]
        [StringLength(30, ErrorMessage = "La cantidad máxima de caracteres es 30")]
        public string name { get; set; }

        [Display(Name = "Descripción")]
        [Required(ErrorMessage = "Se debe completar el campo de la descripción")]
        [StringLength(100, ErrorMessage = "La cantidad máxima de caracteres es 100")]
        public string description { get; set; }

        [Required]
        public string createdBy_id { get; set; }

        [Required]
        public string createdBy_name { get; set; }
    }

    public class EditCategorieModel
    {
        private CategorieProvider categorieProvider = new CategorieProvider();
        public CategorieDTO categorieDTO = new CategorieDTO();
        public EditCategorieModel(string id_categorie)
        {
            categorieDTO = categorieProvider.getCategorie(id_categorie).Result;
            name = categorieDTO.name;
            description = categorieDTO.description;
            isEnabled = categorieDTO.isEnabled == "True" ? true : false ;
        }

        [Display(Name = "Nombre")]
        [Required(ErrorMessage = "Se debe completar el campo del nombre")]
        [StringLength(30, ErrorMessage = "La cantidad máxima de caracteres es 30")]
        public string name { get; set; }

        [Display(Name = "Descripción")]
        [Required(ErrorMessage = "Se debe completar el campo de la descripción")]
        [StringLength(100, ErrorMessage = "La cantidad máxima de caracteres es 100")]
        public string description { get; set; }

        [Display(Name = "Habilitado")]
        public bool isEnabled { get; set; }
    }

    public class GeneralAttributesModel
    {
        private CategorieProvider categorieProvider = new CategorieProvider();
        public List<GeneralAttributeDTO> generalAttributesDTO = new List<GeneralAttributeDTO>();
        public List<GeneralAttributeModel> generalAttributesModel = new List<GeneralAttributeModel>();
        public List<AttributeTypeDTO> attributeTypes = new List<AttributeTypeDTO>();
        public SelectList _TypeSelect { get; set; }
        public GeneralAttributesModel(string categorie_id)
        {
            this.categorie_id = categorie_id;

            //-- Generates types select 
            attributeTypes = categorieProvider.getAttributeTypes().Result;
            List<SelectListItem> _TypeSelectList = new List<SelectListItem>();
            foreach (AttributeTypeDTO iType in attributeTypes)
            {
                _TypeSelectList.Add(new SelectListItem { Text = iType.type, Value = iType.id_type });
            }
            _TypeSelect = new SelectList(_TypeSelectList, "Value", "Text");

            //-- Get attributes
            generalAttributesDTO = categorieProvider.getGeneralAttributes(categorie_id).Result;
            foreach (var attributeDTO in generalAttributesDTO)
            {
                generalAttributesModel.Add(new GeneralAttributeModel(attributeDTO));
            }
        }

        [Display(Name = "Nombre")]
        [Required(ErrorMessage = "Se debe completar el campo del nombre")]
        [StringLength(50, ErrorMessage = "La cantidad máxima de caracteres es 50")]
        public string attribute { get; set; }

        [Display(Name = "Valor")]
        [Required(ErrorMessage = "Se debe completar el campo del valor")]
        [StringLength(100, ErrorMessage = "La cantidad máxima de caracteres es 100")]
        public string value { get; set; }

        public bool isEnabled { get; set; }

        public string id_type { get; set; }

        public string categorie_id { get; set; }

    }

    public class GeneralAttributeModel
    {
        public GeneralAttributeDTO generalAttributesDTO = new GeneralAttributeDTO();
        public GeneralAttributeModel(GeneralAttributeDTO attributeDTO)
        {
            attribute = attributeDTO.name;
            value = attributeDTO.value;
            isEnabled = attributeDTO.isEnabled == "True" ? true: false;
            id_type = attributeDTO.type_id;
        }
        [Required(ErrorMessage = "Se debe completar el campo del nombre")]
        [StringLength(50, ErrorMessage = "La cantidad máxima de caracteres es 50")]
        public string attribute { get; set; }

        [Required(ErrorMessage = "Se debe completar el campo del valor")]
        [StringLength(100, ErrorMessage = "La cantidad máxima de caracteres es 100")]
        public string value { get; set; }

        [Required(ErrorMessage = "Se debe completar el campo del nombre")]
        [StringLength(30, ErrorMessage = "La cantidad máxima de caracteres es 30")]
        public bool isEnabled { get; set; }

        [Required(ErrorMessage = "Se debe completar el campo del tipo")]
        public string id_type { get; set; }
    }
    public class AddGeneralAttributeModel
    {
        [Display(Name = "Nombre")]
        [Required(ErrorMessage = "Se debe completar el campo del nombre")]
        [StringLength(50, ErrorMessage = "La cantidad máxima de caracteres es 50")]
        public string attribute { get; set; }

        [Display(Name = "Valor")]
        [Required(ErrorMessage = "Se debe completar el campo del valor")]
        [StringLength(100, ErrorMessage = "La cantidad máxima de caracteres es 100")]
        public string value { get; set; }
        public bool isEnabled { get; set; }
        public string id_type { get; set; }
        public string categorie_id { get; set; }
    }
    public class EditGeneralAttributeModel
    {
        [Display(Name = "Nombre")]
        [Required(ErrorMessage = "Se debe completar el campo del nombre")]
        [StringLength(50, ErrorMessage = "La cantidad máxima de caracteres es 50")]
        public string attribute { get; set; }

        [Display(Name = "Valor")]
        [Required(ErrorMessage = "Se debe completar el campo del valor")]
        [StringLength(100, ErrorMessage = "La cantidad máxima de caracteres es 100")]
        public string value { get; set; }
        public bool isEnabled { get; set; }
        public string id_type { get; set; }
        public string id_attribute { get; set; }
    }

    //---------------- Models for Attribute List ------------------------
    public class AttributesListModel
    {
        private CategorieProvider categorieProvider = new CategorieProvider();
        public List<AttributeListDTO> attributeListDTO = new List<AttributeListDTO>();
        //public List<GeneralAttributeModel> generalAttributesModel = new List<GeneralAttributeModel>();
        public List<AttributeTypeDTO> attributeTypes = new List<AttributeTypeDTO>();
        public SelectList _TypeSelect { get; set; }
        public AttributesListModel(string attribute_id)
        {
            this.attribute_id = attribute_id;
            //-- Generates types select 
            attributeTypes = categorieProvider.getAttributeTypes().Result;
            List<SelectListItem> _TypeSelectList = new List<SelectListItem>();
            foreach (AttributeTypeDTO iType in attributeTypes)
            {
                _TypeSelectList.Add(new SelectListItem { Text = iType.type, Value = iType.id_type });
            }
            _TypeSelect = new SelectList(_TypeSelectList, "Value", "Text");
            //-- Get attributes
            attributeListDTO = categorieProvider.getAttributesList(attribute_id).Result;
            foreach (var attributeDTO in attributeListDTO)
            {
                //generalAttributesModel.Add(new GeneralAttributeModel(attributeDTO));
            }
        }

        [Display(Name = "Nombre")]
        [Required(ErrorMessage = "Se debe completar el campo del nombre")]
        [StringLength(50, ErrorMessage = "La cantidad máxima de caracteres es 50")]
        public string attribute { get; set; }

        [Display(Name = "Valor")]
        [Required(ErrorMessage = "Se debe completar el campo del valor")]
        [StringLength(100, ErrorMessage = "La cantidad máxima de caracteres es 100")]
        public string value { get; set; }

        public bool isEnabled { get; set; }

        public string id_type { get; set; }

        public string attribute_id { get; set; }

    }
    public class AddAttributeListModel
    {
        [Display(Name = "Nombre")]
        [Required(ErrorMessage = "Se debe completar el campo del nombre")]
        [StringLength(50, ErrorMessage = "La cantidad máxima de caracteres es 50")]
        public string attribute { get; set; }

        [Display(Name = "Valor")]
        [Required(ErrorMessage = "Se debe completar el campo del valor")]
        [StringLength(100, ErrorMessage = "La cantidad máxima de caracteres es 100")]
        public string value { get; set; }
        public bool isEnabled { get; set; }
        public string id_type { get; set; }
        public string attribute_id { get; set; }
    }
    public class EditAttributeListModel
    {
        [Display(Name = "Nombre")]
        [Required(ErrorMessage = "Se debe completar el campo del nombre")]
        [StringLength(50, ErrorMessage = "La cantidad máxima de caracteres es 50")]
        public string attribute { get; set; }

        [Display(Name = "Valor")]
        [Required(ErrorMessage = "Se debe completar el campo del valor")]
        [StringLength(100, ErrorMessage = "La cantidad máxima de caracteres es 100")]
        public string value { get; set; }
        public bool isEnabled { get; set; }
        public string id_type { get; set; }
        public string id_attributeValue { get; set; }
    }

}
