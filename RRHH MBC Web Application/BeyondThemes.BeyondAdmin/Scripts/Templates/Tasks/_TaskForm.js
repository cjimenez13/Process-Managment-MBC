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
function AnswerAddedSucces(data) {
    Notify("El formulario ha sido respondido con éxito", 'bottom-right', '5000', 'success', 'fa-edit', true);
}
function AnswerAddedFailure() {
    Notify("Error, no se respondio el formulario", 'bottom-right', '5000', 'danger', 'fa-edit', true);
}

//-- Question edited
function QuestionEditedSuccess(data) {
    Notify("La pregunta se ha guardado con éxito", 'bottom-right', '5000', 'success', 'fa-edit', true);
}
function QuestionEditedFailure() {
    Notify("Error, no se guardo la pregunta", 'bottom-right', '5000', 'danger', 'fa-edit', true);
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

//-- form edited
function TaskFormEditedSuccess(taskFormDTO) {
    Notify("El formulario se ha editado con éxito", 'bottom-right', '5000', 'success', 'fa-edit', true);
    $('#formDescription').text("Descripción: "+taskFormDTO.description)
}
function TaskFormEditedFailure(error) {
    Notify(error.statusText, 'bottom-right', '5000', 'danger', 'fa-edit', true);
}
function onQuestionTypeChanged(self) {
    var questionType = self.value;
    console.log(questionType);
    console.log("hola")
    if (questionType == "3") {
        $(self).parent().find('select:last-child').show();
    } else {
        $(self).parent().find('select:last-child').hide();
    }
}

// form users
function FormUserAddedSuccess(content) {
    if (content.usersAdded == 1) {
        Notify("Se ha agregado " + content.usersAdded + " usuario con éxito", 'bottom-right', '8000', 'success', 'fa-edit', true);
    }
    else if (content.usersAdded > 1) {
        Notify("Se han agregado " + content.usersAdded + " usuarios con éxito", 'bottom-right', '8000', 'success', 'fa-edit', true);
    }
    if (content.usersError == 1) {
        Notify(content.usersError + " de los usuarios ya se encuentra como participante", 'bottom-right', '8000', 'warning', 'fa-edit', true);
    }
    else if (content.usersError.length > 1) {
        Notify(content.usersError + " de los usuarios ya se encuentran como participante", 'bottom-right', '8000', 'warning', 'fa-edit', true);
    }
    $("#formUsersList").html(content.viewHtml)
}
function FormUserAddedFailure(content) {
    Notify(content.statusText, 'bottom-right', '5000', 'danger', 'fa-edit', true);
}
// delete form user 
function deleteFormUser(user_id, taskForm_id, name, element) {
    $.ajax({
        url: "/Tasks/_DeleteFormUser/?user_id=" + user_id + "&taskForm_id=" + taskForm_id,
        type: "DELETE",
        dataType: "html",
        traditional: true,
        contentType: false,
        success: function (data) {
            Notify("El usuario '" + name + "' ha sido removido", 'bottom-right', '5000', 'success', 'fa-edit', true);
            $(element).closest(".databox").parent().hide(300, function () {
                this.remove()
            });
        },
        error: function () {
            Notify("Error, no se puede remover el usuario '" + name + "'", 'bottom-right', '5000', 'danger', 'fa-edit', true);
        }
    });
}