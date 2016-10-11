// responsable added
function ResponsableAddedSuccess(content) {
    if (content.usersAdded == 1) {
        Notify("Se ha agregado " + content.usersAdded + " usuario con éxito", 'bottom-right', '8000', 'success', 'fa-edit', true);
    }
    else if (content.usersAdded > 1) {
        Notify("Se han agregado " + content.usersAdded + " usuarios con éxito", 'bottom-right', '8000', 'success', 'fa-edit', true);
    }
    if (content.usersError == 1) {
        Notify(content.usersError + " de los usuarios ya se encuentra como participante", 'bottom-right', '8000', 'warning', 'fa-edit', true);
    }
    else if (content.usersError.length > 1) {
        Notify(content.usersError + " de los usuarios ya se encuentran como participante", 'bottom-right', '8000', 'warning', 'fa-edit', true);
    }
    $("#ParticipantsList").html(content.viewHtml)
}

function ResponsableAddedFailure() {
    Notify("Error, no se agregó ningun usuario", 'bottom-right', '5000', 'danger', 'fa-edit', true);
}

// delete participant user 
function deleteResponsableUser(user_id, task_id, name, element) {
    $.ajax({
        url: "/Tasks/_DeleteTaskResponsableUser/?user_id=" + user_id + "&id_task=" + task_id,
        type: "DELETE",
        dataType: "html",
        traditional: true,
        contentType: false,
        success: function (data) {
            Notify("El usuario '" + name + "' ha sido removido", 'bottom-right', '5000', 'success', 'fa-edit', true);
            $(element).closest(".databox").parent().hide(300, function () {
                this.remove()
            });
        },
        error: function () {
            Notify("Error, no se puede remover el usuario '" + name + "'", 'bottom-right', '5000', 'danger', 'fa-edit', true);
        }
    });
}
// filter responsables
function filterResponsablesUsers(element) {
    var value = $(element).val().toLowerCase();
    $("#ParticipantsList").children().each(function () {
        if ($(this).text().toLowerCase().includes(value)) {
            $(this).show(300);
        }
        else {
            $(this).hide(300)
        }
    });
}