//jQu2ery UI sortable for the todo list
//$("#taskForm:not(:last-child)").sortable({
//    placeholder: "sort-highlight",
//    handle: ".handle-form",
//    forcePlaceholderSize: true,
//    zIndex: 999999
//});
// update position when sorting
//$(".todo-list").sortable({
//    placeholder: "sort-highlight",
//    handle: ".handle",
//    forcePlaceholderSize: true,
//    zIndex: 999999,
//    update: function (event, ui) {
//        var newpos = ui.item.index();
//        var count = 0;
//        ui.item.parent().children().each(function () {
//            var id = this.id
//            var name = $(this).find('#stageName' + id).text();
//            var newPos = count;
//            $.ajax({
//                url: "/Tasks/_EditTask/?id_task=" + id + '&taskPosition=' + newPos,
//                type: "PUT",
//                dataType: "html",
//                traditional: true,
//                contentType: false,
//                success: function (data) {
//                },
//                error: function () {
//                }
//            });
//            count += 1;
//        });

//    }
//});

//-- Question added
function TaskQuestionAddedSuccess(data) {
    Notify("La pregunta se ha añadido con éxito", 'bottom-right', '5000', 'success', 'fa-edit', true);
    var table = $('#table-questions > tbody');
    table.children().not(':last').remove()
    table.prepend(data);
}
function TaskQuestionAddedFailure() {
    Notify("Error, no se agregó la pregunta", 'bottom-right', '5000', 'danger', 'fa-edit', true);
}

//-- Question edited
function QuestionEditedSuccess(data) {
    Notify("La pregunta se ha editado con éxito", 'bottom-right', '5000', 'success', 'fa-edit', true);
}
function QuestionEditedFailure() {
    Notify("Error, no se edito la pregunta", 'bottom-right', '5000', 'danger', 'fa-edit', true);
}
//-- Question deleted
function deleteFormTask(id_formQuestion, element) {
    $.ajax({
        url: "/Tasks/_DeleteFormQuestion/?id_formQuestion=" + id_formQuestion,
        type: "DELETE",
        dataType: "html",
        traditional: true,
        contentType: false,
        success: function (data) {
            Notify("La pregunta ha sido removida", 'bottom-right', '5000', 'success', 'fa-edit', true);
            $(element).closest("tr").hide(300, function () {
                this.remove()
            });
        },
        error: function () {
            Notify("Error, no se puede remover la pregunta", 'bottom-right', '5000', 'danger', 'fa-edit', true);
        }
    });
}
function onQuestionTypeChanged(self) {
    var questionType = self.value;
    if (questionType == "3") {
        console.log()
        $(self).parent().find('select:last-child').show();
    } else {
        $(self).parent().find('select:last-child').hide();
    }
}