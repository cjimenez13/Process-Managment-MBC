InitiateCategorieDataTable.init();
function CategorieAddedSuccess(content) {
    Notify("La categoría ha sido creada con éxito", 'bottom-right', '5000', 'success', 'fa-edit', true);
    $("#CategoriesList").html(content)
    InitiateCategorieDataTable.init();
}
function CategorieAddedFailure(content) {
    Notify("Error, no se puede crear la categoría", 'bottom-right', '5000', 'danger', 'fa-edit', true);
}