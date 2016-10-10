using BeyondThemes.BeyondAdmin.Providers;
using DataTransferObjects;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;

namespace Model
{
    //-------------------------------------- Participants ---------------------------------------------
    public class ParticipantsModel
    {
        private ProcessManagmentProvider processManagmentProvider = new ProcessManagmentProvider();
        public List<ParticipantDTO> participants = new List<ParticipantDTO>();
        public string id_process;
        public ParticipantsModel(string id_process)
        {
            this.id_process = id_process;
            participants = processManagmentProvider.getParticipants(id_process).Result;
        }
    }
    public class AddParticipantUserModel
    {
        private UsersProvider userProvider = new UsersProvider();
        public List<UserDTO> userList = new List<UserDTO>();
        public SelectList _UsersSelect { get; set; }
        public AddParticipantUserModel(string process_id)
        {
            this.process_id = process_id;
            userList = userProvider.getUsers().Result;
            List<SelectListItem> usersSelectList = new List<SelectListItem>();
            foreach (UserDTO iUser in userList)
            {
                var name = iUser.name + " " + iUser.fLastName + " " + iUser.sLastName;
                usersSelectList.Add(new SelectListItem { Text = name, Value = iUser.user_id });
            }
            _UsersSelect = new SelectList(usersSelectList, "Value", "Text");
        }

        [Required]
        public string process_id { get; set; }

        [Display(Name = "Usuarios")]
        [Required(ErrorMessage = "Se debe seleccionar al menos un usuario")]
        public List<string> selected_userParticipants_id { get; set; }
    }
    public class AddGroupModel
    {
        private GroupProvider groupProvider = new GroupProvider();
        public List<GroupDTO> groupsList = new List<GroupDTO>();
        public SelectList _GroupsSelect { get; set; }
        public AddGroupModel(string process_id)
        {
            this.process_id = process_id;
            groupsList = groupProvider.getGroups().Result;
            List<SelectListItem> usersSelectList = new List<SelectListItem>();
            foreach (GroupDTO iGroup in groupsList)
            {
                usersSelectList.Add(new SelectListItem { Text = iGroup.groupName, Value = iGroup.id_group });
            }
            _GroupsSelect = new SelectList(usersSelectList, "Value", "Text");
        }

        [Required]
        public string process_id { get; set; }

        [Display(Name = "Grupos")]
        [Required(ErrorMessage = "Se debe seleccionar al menos un grupo")]
        public List<string> selected_groups_id { get; set; }
    }

    //-------------------------------------- Stages ---------------------------------------------
    public class StagesListModel
    {
        private ProcessManagmentProvider processManagmentProvider = new ProcessManagmentProvider();
        public List<StageDTO> stages = new List<StageDTO>();
        public string id_process;
        public StagesListModel(TemplateDTO templateDTO)
        {
            this.id_process = templateDTO.id_processManagment;
            stages = processManagmentProvider.getStages(id_process).Result;
            foreach (var stage in stages)
            {
                int stagePosition = Int32.Parse(stage.stagePosition);
                if (stagePosition >= maxStagePosition)
                {
                    maxStagePosition = stagePosition + 1;
                }
            }
        }
        [Required(ErrorMessage = "Se debe completar el campo del nombre")]
        public string name { get; set; }
        public int maxStagePosition { get; set; } = 0;
    }
    public class EditStageModel
    {
        public EditStageModel(StageDTO stage)
        {
            name = stage.name;
            id_stage = stage.id_stage;
            stagePosition = stage.stagePosition;
        }
        [Display(Name = "Nombre")]
        [Required(ErrorMessage = "Se debe completar el campo del nombre")]
        [StringLength(100, ErrorMessage = "La cantidad máxima de caracteres es 100")]
        public string name { get; set; }

        [Required]
        public string id_stage { get; set; }

        [Required]
        public string stagePosition { get; set; }
    }

}
