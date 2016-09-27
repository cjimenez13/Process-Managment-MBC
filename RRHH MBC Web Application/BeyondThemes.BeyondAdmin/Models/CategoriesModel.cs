using BeyondThemes.BeyondAdmin.Providers;
using DataTransferObjects;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;

namespace Model
{

    //------------------------------------------ Categories ------------------------------------------------
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
        public List<GeneralAttributeDTO> generalAttributes = new List<GeneralAttributeDTO>();
        public CategorieModel(string id_categorie)
        {
            categorie = categorieProvider.getCategorie(id_categorie).Result;
            generalAttributes = categorieProvider.getGeneralAttributes(id_categorie).Result;
        }
        public List<AttributeListDTO> getValuesList(string id_attribute)
        {
            return categorieProvider.getAttributesList(id_attribute).Result;
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
        public string createdBy_id{ get; set; }

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
    //------------------------------------------ General Attributes ------------------------------------------------
    public class GeneralAttributesModel
    {
        private CategorieProvider categorieProvider = new CategorieProvider();
        public List<GeneralAttributeDTO> generalAttributesDTO = new List<GeneralAttributeDTO>();
        public List<AttributeTypeDTO> attributeTypes = new List<AttributeTypeDTO>();
        public SelectList _TypeSelect { get; set; }
        public GeneralAttributesModel(string categorie_id)
        {
            this.categorie_idA = categorie_id;
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
        }
        // values to add new general attribute

        [Display(Name = "Nombre")]
        [Required(ErrorMessage = "Se debe completar el campo del nombre")]
        [StringLength(50, ErrorMessage = "La cantidad máxima de caracteres es 50")]
        public string attributeA { get; set; }
        [Display(Name = "Valor")]
        [Required(ErrorMessage = "Se debe completar el campo del valor")]
        [StringLength(100, ErrorMessage = "La cantidad máxima de caracteres es 100")]
        public string valueA { get; set; } = "";
        public bool isEnabledA { get; set; } = true;
        public string id_typeA { get; set; }
        public string categorie_idA { get; set; }

    }
    public class AddGeneralAttributeModel
    {
        [Display(Name = "Nombre")]
        [Required(ErrorMessage = "Se debe completar el campo del nombre")]
        [StringLength(50, ErrorMessage = "La cantidad máxima de caracteres es 50")]
        public string attributeA { get; set; }

        [Display(Name = "Valor")]
        [Required(ErrorMessage = "Se debe completar el campo del valor")]
        [StringLength(100, ErrorMessage = "La cantidad máxima de caracteres es 100")]
        public string valueA { get; set; }
        public bool isEnabledA { get; set; } 
        public string id_typeA { get; set; }
        public string categorie_idA { get; set; }
    }
    public class EditGeneralAttributeModel
    {
        [Required(ErrorMessage = "Se debe completar el campo del nombre")]
        [StringLength(50, ErrorMessage = "La cantidad máxima de caracteres es 50")]
        public string attribute { get; set; }

        [Required(ErrorMessage = "Se debe completar el campo del valor")]
        [StringLength(100, ErrorMessage = "La cantidad máxima de caracteres es 100")]
        public string value { get; set; }
        public string isEnabled { get; set; } 
        public string id_type { get; set; }
        public string id_attribute { get; set; }
    }

    //---------------- Models for Attribute List ------------------------
    public class AttributesListModel
    {
        private CategorieProvider categorieProvider = new CategorieProvider();
        public List<AttributeListDTO> attributeListDTO = new List<AttributeListDTO>();
        public List<AttributeTypeDTO> attributeTypes = new List<AttributeTypeDTO>();
        public SelectList _TypeSelect { get; set; }
        public string attribute_nameVA { get; set; }
        public AttributesListModel(string attribute_id, string pAttribute_name)
        {
            this.attribute_nameVA = pAttribute_name;
            this.attribute_idVA = attribute_id;
            //-- Generates types select 
            attributeTypes = categorieProvider.getAttributeTypes().Result;
            List<SelectListItem> _TypeSelectList = new List<SelectListItem>();
            foreach (AttributeTypeDTO iType in attributeTypes)
            {
                if (iType.type != "Lista")
                {
                    _TypeSelectList.Add(new SelectListItem { Text = iType.type, Value = iType.id_type });
                }
            }
            _TypeSelect = new SelectList(_TypeSelectList, "Value", "Text");
            //-- Get attributes
            attributeListDTO = categorieProvider.getAttributesList(attribute_id).Result;
        }

        [Display(Name = "Nombre")]
        [Required(ErrorMessage = "Se debe completar el campo del nombre")]
        [StringLength(50, ErrorMessage = "La cantidad máxima de caracteres es 50")]
        public string attributeVA { get; set; }
        [Display(Name = "Valor")]
        [Required(ErrorMessage = "Se debe completar el campo del valor")]
        [StringLength(100, ErrorMessage = "La cantidad máxima de caracteres es 100")]
        public string valueVA { get; set; }
        public bool isEnabledVA { get; set; } = true;
        public string id_typeVA { get; set; }
        public string attribute_idVA { get; set; }
    }
    public class AddAttributeListModel
    {
        [Display(Name = "Nombre")]
        [Required(ErrorMessage = "Se debe completar el campo del nombre")]
        [StringLength(50, ErrorMessage = "La cantidad máxima de caracteres es 50")]
        public string attributeVA { get; set; }

        [Display(Name = "Valor")]
        [Required(ErrorMessage = "Se debe completar el campo del valor")]
        [StringLength(100, ErrorMessage = "La cantidad máxima de caracteres es 100")]
        public string valueVA { get; set; }
        public bool isEnabledVA { get; set; }
        public string id_typeVA { get; set; }
        public string attribute_idVA { get; set; }
        public string attribute_nameVA { get; set; }
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
        public string isEnabled { get; set; }
        public string id_type { get; set; }
        public string id_attributeValue { get; set; }
    }

    //---------------- Personal Attributes ------------------------
    public class PersonalAttributesModel
    {
        private CategorieProvider categorieProvider = new CategorieProvider();
        public List<PersonalAttributeDTO> attributeListDTO = new List<PersonalAttributeDTO>();
        public List<AttributeTypeDTO> attributeTypes = new List<AttributeTypeDTO>();
        public SelectList _TypeSelect { get; set; }
        public PersonalAttributesModel(string categorie_id)
        {
            this.categorie_idPA = categorie_id;
            //-- Generates types select 
            attributeTypes = categorieProvider.getAttributeTypes().Result;
            List<SelectListItem> _TypeSelectList = new List<SelectListItem>();
            foreach (AttributeTypeDTO iType in attributeTypes)
            {
                if (iType.type != "Lista")
                {
                    _TypeSelectList.Add(new SelectListItem { Text = iType.type, Value = iType.id_type });
                }
            }
            _TypeSelect = new SelectList(_TypeSelectList, "Value", "Text");
            //-- Get attributes
            attributeListDTO = categorieProvider.getPersonalAttributes(categorie_id).Result;
        }

        [Display(Name = "Nombre")]
        [Required(ErrorMessage = "Se debe completar el campo del nombre")]
        [StringLength(50, ErrorMessage = "La cantidad máxima de caracteres es 50")]
        public string attributePA { get; set; }
        [Display(Name = "Valor")]
        [Required(ErrorMessage = "Se debe completar el campo del valor")]
        [StringLength(100, ErrorMessage = "La cantidad máxima de caracteres es 100")]
        public string valuePA { get; set; }
        public bool isEnabledPA { get; set; } = true;
        public string id_typePA { get; set; }
        public string categorie_idPA { get; set; }
    }
    public class AddPersonalAttributeModel
    {
        [Display(Name = "Nombre")]
        [Required(ErrorMessage = "Se debe completar el campo del nombre")]
        [StringLength(50, ErrorMessage = "La cantidad máxima de caracteres es 50")]
        public string attributePA { get; set; }

        [Display(Name = "Valor")]
        [Required(ErrorMessage = "Se debe completar el campo del valor")]
        [StringLength(100, ErrorMessage = "La cantidad máxima de caracteres es 100")]
        public string valuePA { get; set; }
        public bool isEnabledPA { get; set; }
        public string id_typePA { get; set; }
        public string categorie_idPA { get; set; }
    }
    public class EditPersonalAttributeModel
    {
        [Display(Name = "Nombre")]
        [Required(ErrorMessage = "Se debe completar el campo del nombre")]
        [StringLength(50, ErrorMessage = "La cantidad máxima de caracteres es 50")]
        public string attribute { get; set; }

        [Display(Name = "Valor")]
        [Required(ErrorMessage = "Se debe completar el campo del valor")]
        [StringLength(100, ErrorMessage = "La cantidad máxima de caracteres es 100")]
        public string value { get; set; }
        public string isEnabled { get; set; }
        public string id_type { get; set; }
        public string id_attribute { get; set; }
    }

}
