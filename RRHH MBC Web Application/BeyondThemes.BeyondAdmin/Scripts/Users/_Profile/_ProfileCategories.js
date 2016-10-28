function editAttributeRow(id_attribute, self) {
    $('#btnEditUserAttribute' + id_attribute).hide()
    $('#valueLabel' + id_attribute).hide()
    $('#btnSaveUserAttribute' + id_attribute).show()
    $('#editValueInput' + id_attribute).show()
}
function UserAttributeEditFailure(content) {
    Notify(content.statusText, 'bottom-right', '5000', 'danger', 'fa-edit', true);
} 1
function UserAttributeEditSuccess(content) {
    id_attribute = content.attribute_id
    value = content.value
    Notify('El atributo ha sido editado con éxito', 'bottom-right', '5000', 'success', 'fa-edit', true);
    $('#btnEditUserAttribute' + id_attribute).show()
    $('#valueLabel' + id_attribute).text(value)
    $('#valueLabel' + id_attribute).show()
    $('#btnSaveUserAttribute' + id_attribute).hide()
    $('#editValueInput' + id_attribute).hide()
}