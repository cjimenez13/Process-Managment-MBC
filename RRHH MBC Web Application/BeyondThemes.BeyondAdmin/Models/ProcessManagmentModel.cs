using BeyondThemes.BeyondAdmin.Providers;
using DataTransferObjects;
using System.Collections.Generic;
namespace Model
{
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
}
