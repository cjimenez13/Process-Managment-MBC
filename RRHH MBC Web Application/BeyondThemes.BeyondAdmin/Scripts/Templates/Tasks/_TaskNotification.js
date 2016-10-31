function TaskNotificationAddedSucces(content) {
    Notify("La notificación ha sido agregada con éxito", 'bottom-right', '5000', 'success', 'fa-edit', true);
    $('#table-taskNotifications tbody').html(content);
    $('.select2').select2()
}
function TaskNotificationAddedFailure(content) {
    Notify('Error, la notificación no se puede agregar', 'bottom-right', '5000', 'danger', 'fa-edit', true);
}
function deleteTaskNotification(id_taskNotification, self) {
    var btnColumn = $(self);
    var row = btnColumn.parents("tr").eq(0)
    var disposeinterval = 300;
    $.ajax({
        url: "/Tasks/_DeleteTaskNotification/?id_taskNotification=" + id_taskNotification,
        type: "DELETE",
        dataType: "html",
        traditional: true,
        contentType: false,
        success: function (data) {
            Notify("La notificación ha sido borrada con éxito", 'bottom-right', '5000', 'success', 'fa-edit', true);
            row.hide(disposeinterval, function () {
                row.remove();
            });
        },
        error: function () {
            Notify("Error, no se puede borrar la notificación", 'bottom-right', '5000', 'danger', 'fa-edit', true);
        }
    });
}

function NotificationUserAddedSuccess(content) {
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
    $("#NotificationsUsersList", '#modal_configTaskNotification' + content.id_notification).html(content.viewHtml)
    console.log($("#NotificationsUsersList", '#modal_configTaskNotification' + content.id_notification))
}
function NotificationUSerAddedFailure(content) {
    Notify('Error, el usuario no se puede agregar', 'bottom-right', '5000', 'danger', 'fa-edit', true);
}

function deleteNotificationUser(user_id, id_taskNotification, name, element) {
    $.ajax({
        url: "/Tasks/_DeleteTaskNotificationUser/?user_id=" + user_id + "&id_taskNotification=" + id_taskNotification,
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