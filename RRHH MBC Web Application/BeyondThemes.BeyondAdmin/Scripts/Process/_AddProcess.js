function onCategoriesSelectChanged() {
    var id = $("#categorie_id").val();
    $.ajax({
        url: '/Processes/getTemplates?categorie_id=' + id,
        type: 'get',
        success: function (json, textStatus) {
            $("#template_id").empty();
            json = json || {};
            for (var i = 0; i < json.length; i++) {
                $("#template_id").append('<option value="' + json[i].id_processManagment + '">' + json[i].name + '</option>');
            }
            $("#template_id").prop("disabled", false);
        }
    });
}
function ProcessAddedSuccess(content) {
    Notify("La gestión ha sido creada con éxito", 'bottom-right', '5000', 'success', 'fa-edit', true);
    console.log(content)
    console.log($('#table-processes tbody'))
    $('#table-processes tbody').html(content)
    $("[data-toggle='tooltip']").tooltip();
}
function ProcessAddedFailure(content) {
    Notify("Error, no se creó la gestión", 'bottom-right', '5000', 'danger', 'fa-edit', true);
}