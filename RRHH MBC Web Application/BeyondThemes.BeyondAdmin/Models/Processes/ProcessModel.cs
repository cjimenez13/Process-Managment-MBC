using BeyondThemes.BeyondAdmin.Providers;
using DataTransferObjects;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;

namespace Model
{
    public class ProcessModel
    {
        private ProcessProvider processProvider = new ProcessProvider();
        private UsersProvider userProvider = new UsersProvider();
        ProcessManagmentProvider processManagmentProvider = new ProcessManagmentProvider();
        public ProcessDTO processDTO;
        public UserDTO userDTO;
        public Model.ParticipantsModel participantsModel;
        public ProcessModel(string id)
        {
            processDTO = processProvider.getProcess(id).Result;
            userDTO = userProvider.getUserbyID(processDTO.createdBy).Result;
            participantsModel = new Model.ParticipantsModel(processDTO.id_processManagment);
        }
    }
    public class UserProcessModel
    {
        private ProcessProvider processProvider = new ProcessProvider();
        public List<ProcessDTO> processesDTO = new List<ProcessDTO>();

        public UserProcessModel(string user_id)
        {
            processesDTO = processProvider.getProcessesbyUser(user_id).Result;
        }
    }
    public class ProcessListModel
    {
        private ProcessProvider processProvider = new ProcessProvider();
        public List<ProcessDTO> processesDTO = new List<ProcessDTO>();
        public string actualUser;
        public ProcessListModel()
        {
            
            processesDTO = processProvider.getProcesses().Result;
        }
        public List<ParticipantDTO> getParticipants(string id_template)
        {
            return processProvider.getParticipants(id_template).Result;
        }
    }
    public class EditProcessModel
    {
        public EditProcessModel() { }
        public EditProcessModel(ProcessDTO processDTO)
        {
            this.id_process = processDTO.id_processManagment;
            this.name = processDTO.name;
        }
        [Required]
        public string id_process;
        [Display(Name = "Nombre")]
        [Required(ErrorMessage = "Se debe completar el campo del nombre")]
        [StringLength(50, ErrorMessage = "La cantidad máxima de caracteres es 50")]
        public string name { get; set; }
    }
    public class AddProcessModel
    {
        // Categories
        private CategorieProvider categorieProvider = new CategorieProvider();
        public List<CategorieDTO> categoriesList = new List<CategorieDTO>();
        public SelectList _CategoriesSelect { get; set; }
        //Templates
        private TemplatesProvider templatesProvider = new TemplatesProvider();
        public List<TemplateDTO> templatesList = new List<TemplateDTO>();
        public SelectList _TemplatesSelect { get; set; }
        public string ajaxAction = "";
        public AddProcessModel() { }
        public AddProcessModel(string pAjaxAction, string bifurcateProcess_id)
        {
            ajaxAction = pAjaxAction;
            this.bifurcateProcess_id = bifurcateProcess_id;
            categoriesList = categorieProvider.getCategories().Result;
            List<SelectListItem> categoriesSelectList = new List<SelectListItem>();
            foreach (CategorieDTO iCategorie in categoriesList)
            {
                categoriesSelectList.Add(new SelectListItem { Text = iCategorie.name, Value = iCategorie.id_categorie });
            }
            _CategoriesSelect = new SelectList(categoriesSelectList, "Value", "Text");
            if (categoriesList.Count > 0)
            {
                templatesList = templatesProvider.getTemplatesByCategorie(categoriesList[0].id_categorie).Result;
            }
            List<SelectListItem> templatesSelectList = new List<SelectListItem>();
            foreach (TemplateDTO iTemmplate in templatesList)
            {
                templatesSelectList.Add(new SelectListItem { Text = iTemmplate.name, Value = iTemmplate.id_processManagment });
            }
            _TemplatesSelect = new SelectList(templatesSelectList, "Value", "Text");
        }
        public string bifurcateProcess_id { get; set; }

        [Display(Name = "Nombre")]
        [Required(ErrorMessage = "Se debe completar el campo del nombre")]
        [StringLength(100, ErrorMessage = "La cantidad máxima de caracteres es 100")]
        public string name { get; set; }

        [Display(Name = "Categoría")]
        [Required(ErrorMessage = "Se debe completar el campo de la categoría")]
        public string categorie_id { get; set; }

        [Display(Name = "Plantilla")]
        [Required(ErrorMessage = "Se debe completar el campo de la plantilla")]
        public string template_id { get; set; }
    }
}
