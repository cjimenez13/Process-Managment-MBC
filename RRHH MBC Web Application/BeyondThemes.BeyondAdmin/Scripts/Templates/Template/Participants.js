$(document).ready(function () {
    $('#selected_userParticipants_id').select2();
    $('#selected_groups_id').select2();
})

// Participant added
function ParticipantAddedSuccess(content) {
    if (content.usersAdded == 1) {
        Notify("Se ha agregado " + content.usersAdded.length + " usuario con éxito", 'bottom-right', '8000', 'success', 'fa-edit', true);
    }
    else if (content.usersAdded > 1) {
        Notify("Se han agregado " + content.usersAdded.length + " usuarios con éxito", 'bottom-right', '8000', 'success', 'fa-edit', true);
    }
    if (content.usersError == 1) {
        Notify(content.usersError + " de los usuarios ya se encuentra como participante", 'bottom-right', '8000', 'warning', 'fa-edit', true);
    }
    else if (content.usersError.length > 1) {
        Notify(content.usersError + " de los usuarios ya se encuentran como participante", 'bottom-right', '8000', 'warning', 'fa-edit', true);
    }
    var participants = $('#txtShowingParticipants').text().split(' ')[1]
    $('#txtShowingParticipants').text("Mostrando " + content.usersAdded + participants + " participantes")
    $("#participantsListDiv").html(content.viewHtml)
}
function ParticipantAddedFailure(content) {
    Notify("Error, no se agregó ningun usuario", 'bottom-right', '5000', 'danger', 'fa-edit', true);
}
// group added 
function GroupAddedSuccess(content) {
    if (content.usersAdded <= 1) {
        Notify("Se ha agregado " + content.usersAdded.length + " grupo con éxito", 'bottom-right', '8000', 'success', 'fa-edit', true);
    }
    else if (content.usersAdded > 1) {
        Notify("Se han agregado " + content.usersAdded.length + " grupos con éxito", 'bottom-right', '8000', 'success', 'fa-edit', true);
    }
    $("#participantsListDiv").html(content.viewHtml)
}
function GroupAddedFailure(content) {
    Notify("Error, no se agregó ningun grupo", 'bottom-right', '5000', 'danger', 'fa-edit', true);
}
// delete participant
function deleteParticipantUser(user_id, process_id, name, element) {
    $.ajax({
        url: "/Templates/_DeleteParticipant/?user_id=" + user_id + "&process_id=" + process_id,
        type: "DELETE",
        dataType: "html",
        traditional: true,
        contentType: false,
        success: function (data) {
            Notify("El usuario '" + name + "' ha sido removido", 'bottom-right', '5000', 'success', 'fa-edit', true);
            $(element).closest(".databox").parent().hide(300, function () {
                this.remove()
                var participants = $('#txtShowingParticipants').text().split(' ')[1];
                $('#txtShowingParticipants').text("Mostrando " + (participants - 1) + " participantes")
            });
        },
        error: function () {
            Notify("Error, no se puede remover el usuario '" + name + "'", 'bottom-right', '5000', 'danger', 'fa-edit', true);
        }
    });
}
//-- filter participants
function filterParticipantsUsers(element) {
    var value = $(element).val().toLowerCase();
    var count = 0;
    $("#ParticipantsList").children().each(function () {
        if ($(this).text().toLowerCase().includes(value)) {
            $(this).show(300);
            count += 1;
        }
        else {
            $(this).hide(300)
        }
    });
    if (count == 1) {
        $('#txtShowingParticipants').text("Mostrando " + count + " participante")

    } else {
        $('#txtShowingParticipants').text("Mostrando " + count + " participantes")
    }
}