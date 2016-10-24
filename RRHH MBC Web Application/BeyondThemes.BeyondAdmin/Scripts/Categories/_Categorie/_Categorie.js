jQuery(function ($) {
    $('.dd').nestable();
    $('.dd-handle a').on('mousedown', function (e) {
        e.stopPropagation();
    });
    $(document).ready(function () {
        console.log($(".dd button:contains('Collapse')"))
    });
});

//-- Categorie
//-- Edited
function CategorieEditedSuccess(categorieDTO) {
    Notify("La categoría ha sido editada con éxito", 'bottom-right', '5000', 'success', 'fa-edit', true);
    $("#info-tab #CategorieTitle strong").text("Categoría " + categorieDTO.name)
    $("#info-tab #CategorieDescription").text(categorieDTO.description)
    if (categorieDTO.isEnabled === "True") {
        $("#info-tab #isEnabled").text("Habilitado").removeClass("label-danger").addClass("label-success")
    } else {
        $("#info-tab #isEnabled").text("Deshabilitado").removeClass("label-success").addClass("label-danger")
    }
}
function CategorieEditedFailure(content) {
    Notify("Error, no se puede editar la categoría", 'bottom-right', '5000', 'danger', 'fa-edit', true);
}
//-- Deleted
function CategorieDeletedSuccess(content) {
    Notify("La categoría ha sido eliminada con éxito", 'bottom-right', '5000', 'success', 'fa-edit', true);
    window.location.href = "/Categories";
}
function CategorieDeletedFailure(content) {
    Notify("Error, no se puede borrar la categoría", 'bottom-right', '5000', 'danger', 'fa-edit', true);
}