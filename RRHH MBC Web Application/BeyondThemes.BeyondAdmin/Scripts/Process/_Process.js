function ProcessEditedSuccess(content) {
    Notify("El proceso ha sido editado con éxito", 'bottom-right', '5000', 'success', 'fa-edit', true);
    $('#processNameText').text(content.name)
}
function ProcessEditedFailure(content) {
    Notify("Error, no se puede editar el proceso", 'bottom-right', '5000', 'danger', 'fa-edit', true);
}

function ProcessDeletedSuccess(content) {
    Notify("El proceso ha sido editado con éxito", 'bottom-right', '5000', 'success', 'fa-edit', true);
    window.location.href = "/";
}
function ProcessDeletedFailure(content) {
    Notify("Error, no se puede editar el proceso", 'bottom-right', '5000', 'danger', 'fa-edit', true);
}