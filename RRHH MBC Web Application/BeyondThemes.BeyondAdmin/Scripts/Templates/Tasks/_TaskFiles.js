function getFormData($form) {
    var unindexed_array = $form.serializeArray();
    var indexed_array = {};
    $.map(unindexed_array, function (n, i) {
        indexed_array[n['name']] = n['value'];
    });
    return indexed_array;
}
function uploadTaskFile(event, self) {
    event.preventDefault()
    var form = $(self).closest("form")
    var formData = getFormData(form);
    if (window.FormData !== undefined) {
        var fileUpload = $("#userFileUpload").get(0);
        var files = fileUpload.files;
        var fileData = new FormData();
        for (var i = 0; i < files.length; i++) {
            fileData.append(files[i].name, files[i]);
        }
        $.ajax({
            url: '/Tasks/UploadTaskFile/?user_id=' + formData.task_id + '&name=' + formData.name + '&description=' + formData.description,
            type: "POST",
            contentType: false,
            processData: false,
            data: fileData,
            success: function (result) {
                Notify("El archivo se cargo con éxito", 'bottom-right', '5000', 'success', 'fa-edit', true);
            },
            error: function (result) {
                Notify(result.statusText, 'bottom-right', '5000', 'danger', 'fa-edit', true);
            }
        });
    } else {
        Notify("Error, explorador no soportado", 'bottom-right', '5000', 'danger', 'fa-edit', true);
    }
};
function deleteTaskFile(id_taskFile, name, self) {
    var btnColumn = $(self);
    var row = btnColumn.parents("tr").eq(0)
    var disposeinterval = 300;
    $.ajax({
        url: "/Tasks/_DeleteTaskFile/?id_taskFile=" + id_taskFile,
        type: "DELETE",
        dataType: "html",
        traditional: true,
        contentType: false,
        success: function (data) {
            Notify("El archivo '" + name + "' ha sido borrado", 'bottom-right', '5000', 'success', 'fa-edit', true);
            row.hide(disposeinterval, function () {
                row.remove();
            });
        },
        error: function () {
            Notify("Error, no se puede borrar el archivo '" + name + "'", 'bottom-right', '5000', 'danger', 'fa-edit', true);
        }
    });
}