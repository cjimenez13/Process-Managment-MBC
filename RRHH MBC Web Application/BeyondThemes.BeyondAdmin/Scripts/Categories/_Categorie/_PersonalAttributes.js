//-- Personal Attribute
//-- Added
function PersonalAttributeAddedSuccess(content) {
    Notify("El atributo ha sido agregado con éxito", 'bottom-right', '5000', 'success', 'fa-edit', true);
    var table = $('#table-PersonalAttributes > tbody');
    table.children().not(':last').remove()
    table.prepend(content);
}
function PersonalAttributeAddedFailure(content) {
    Notify(content.statusText, 'bottom-right', '5000', 'danger', 'fa-edit', true);
}
//-- Edited
function PersonalAttributeEditSuccess(content) {
    Notify("El atributo ha sido editado con éxito", 'bottom-right', '5000', 'success', 'fa-edit', true);
}
function PersonalAttributeEditFailure(content) {
    Notify(content.statusText, 'bottom-right', '5000', 'danger', 'fa-edit', true);
}
//-- Deleted ajax
function deletePersonalAttribute(id_attribute, name, element) {
    $.ajax({
        url: "/Categories/_DeletePersonalAttribute/?id_attribute=" + id_attribute,
        type: "DELETE",
        dataType: "html",
        traditional: true,
        contentType: false,
        success: function (data) {
            Notify("El atributo '" + name + "' ha sido removido", 'bottom-right', '5000', 'success', 'fa-edit', true);
            $(element).closest("tr").hide(300, function () {
                widget.remove();
            });
        },
        error: function () {
            Notify("Error, no se puede remover el atributo '" + name + "'", 'bottom-right', '5000', 'danger', 'fa-edit', true);
        }
    });
}