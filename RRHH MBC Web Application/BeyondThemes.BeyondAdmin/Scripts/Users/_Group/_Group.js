$('#selected_userGroup_id').select2();
function GroupEditedSuccess(content) {
    Notify("El grupo ha sido editado con éxito", 'bottom-right', '5000', 'success', 'fa-edit', true);
    $("#groupTitle").text(content.groupName)
}
function UserEditedFailure(content) {
    Notify("Error, no se puede editar el grupo", 'bottom-right', '5000', 'danger', 'fa-edit', true);
}
function GroupDeletedSuccess(content) {
    Notify("El grupo ha sido borrado con éxito", 'bottom-right', '5000', 'success', 'fa-edit', true);
    window.location.href = "/Users";
}
function GroupDeletedFailure(content) {
    Notify("Error, no se puede borrar el grupo", 'bottom-right', '5000', 'danger', 'fa-edit', true);
}
isDeletedGroupConfirmed = false;
$('#btnEliminarGroup').on('click', function (e) {
    self = this;
    if (isDeletedGroupConfirmed == true) {
        isDeletedGroupConfirmed = false;
        return;
    }
    e.preventDefault()
    $.confirm({
        icon: 'fa fa-warning',
        keyboardEnabled: true,
        title: 'Precaución!',
        content: "¿Está seguro que desea eliminar el grupo?",
        confirmButton: "Confirmar",
        cancelButton: "Cancelar",
        confirm: function () {
            isDeletedGroupConfirmed = true;
            $(self).trigger('click');
        },
        cancel: function () {
        }
    });
})