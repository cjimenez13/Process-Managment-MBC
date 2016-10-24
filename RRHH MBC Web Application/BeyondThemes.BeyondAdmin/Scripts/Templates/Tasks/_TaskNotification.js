function TaskNotificationAddedSucces(content) {
    Notify("La notificación ha sido agregada con éxito", 'bottom-right', '5000', 'success', 'fa-edit', true);
    $('#table-taskNotifications tbody').html(content);
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