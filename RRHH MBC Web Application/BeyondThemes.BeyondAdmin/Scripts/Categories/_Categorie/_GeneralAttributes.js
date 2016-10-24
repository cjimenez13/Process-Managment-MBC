//-- General Attribute 
//-- Added
function GeneralAttributeAddedSuccess(content) {
    Notify("El atributo ha sido agregado con éxito", 'bottom-right', '5000', 'success', 'fa-edit', true);
    var table = $('#table-generalAttributes > tbody');
    table.children().not(':last').remove()
    table.prepend(content);
}
function GeneralAttributeAddedFailure(content) {
    Notify(content.statusText, 'bottom-right', '5000', 'danger', 'fa-edit', true);
}
//-- Edit
function GeneralAttributeEditSuccess(content) {
    Notify("El atributo ha sido editado con éxito", 'bottom-right', '5000', 'success', 'fa-edit', true);
}
function GeneralAttributeEditFailure(content) {
    Notify(content.statusText, 'bottom-right', '5000', 'danger', 'fa-edit', true);
}
//-- deleted ajax
function deleteGeneralAttribute(attribute_id, name, element) {
    $.ajax({
        url: "/Categories/_DeleteGeneralAttribute/?id_attribute=" + attribute_id,
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
// General attributes type change
function onGeneralAttrChange(self) {
    var selectedText = $(self).find("option:selected").text();
    var valueColumn = $(self).parent().next();
    if (selectedText === "Lista") {
        valueColumn.find("input").prop("disabled", true)
        valueColumn.find("input").val(null)
    } else {
        valueColumn.find("input").prop("disabled", false)
    }
}
//-- General Attribute List
//-- Added
function AttributeListAddedSuccess(content) {
    Notify("El atributo ha sido agregado con éxito", 'bottom-right', '5000', 'success', 'fa-edit', true);
    var table = $('#table-GeneralAttributesList > tbody');
    table.children().not(':last').remove()
    table.prepend(content);
    //$("#generalAttributes-tab").html(content);
}
function AttributeListAddedFailure(content) {
    Notify(content.statusText, 'bottom-right', '5000', 'danger', 'fa-edit', true);
}
//-- Edited
function GeneralAttributeListEditSuccess(content) {
    Notify("El atributo ha sido editado con éxito", 'bottom-right', '5000', 'success', 'fa-edit', true);
}
function GeneralAttributeListEditFailure(content) {
    Notify(content.statusText, 'bottom-right', '5000', 'danger', 'fa-edit', true);
}
//-- Deleted ajax
function deleteGeneralAttributeList(id_attributeValue, name, element) {
    $.ajax({
        url: "/Categories/_DeleteGeneralAttributeList/?id_attributeValue=" + id_attributeValue,
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