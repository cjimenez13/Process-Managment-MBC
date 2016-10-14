function TaskChangeAddedSucces(content) {
    Notify("El cambio del dato ha sido agregado con éxito", 'bottom-right', '5000', 'success', 'fa-edit', true);
    var taskChangesTable = $('#taskChanges-table').find('tbody');
    taskChangesTable.children().not(':last').remove();
    taskChangesTable.prepend(content);
    console.log(content);
    console.log(taskChangesTable);
}
function TaskChangeAddedFailure(content) {
    Notify(content.statusText, 'bottom-right', '5000', 'danger', 'fa-edit', true);
}

function TaskChangeEditedSucces(content) {
    Notify("El cambio del dato ha sido editado con éxito", 'bottom-right', '5000', 'success', 'fa-edit', true);
    console.log(content)
}
function TaskChangeEditedFailure(content) {
    Notify(content.statusText, 'bottom-right', '5000', 'danger', 'fa-edit', true);
}

function deleteTaskChange(id_taskChange, element) {
    $.ajax({
        url: "/Tasks/_DeleteTaskChange/?id_taskChange=" + id_taskChange,
        type: "DELETE",
        dataType: "html",
        traditional: true,
        contentType: false,
        success: function (data) {
            Notify("El cambio de dato ha sido removida", 'bottom-right', '5000', 'success', 'fa-edit', true);
            $(element).closest("tr").hide(300, function () {
                this.remove()
            });
        },
        error: function () {
            Notify("Error, no se puede remover la cambio del dato", 'bottom-right', '5000', 'danger', 'fa-edit', true);
        }
    });
}