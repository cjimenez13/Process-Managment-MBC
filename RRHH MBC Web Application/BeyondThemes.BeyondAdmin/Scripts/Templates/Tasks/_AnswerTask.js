function openAnswerModal(isForm,id_task) {
    console.log('aswering');
    if (isForm === "True") {
        $('#modal_answerTask').modal('show')
    } else {
        $.confirm({
            icon: 'fa fa-warning',
            keyboardEnabled: true,
            title: 'Tarea1',
            content: "¿Desea completar la tarea?",
            confirmButton: "Confirmar",
            cancelButton: "Cancelar",
            confirm: function () {
                console.log('asd')
                $.ajax({
                    url: "/Tasks/_ConfirrmTask/?id_task=" + id_task,
                    type: "POST",
                    dataType: "html",
                    traditional: true,
                    contentType: false,
                    success: function (content) {
                        Notify("La tarea ha sido respondida con éxito", 'bottom-right', '5000', 'success', 'fa-edit', true);
                        if (content == "True") {
                            window.location.reload(true);
                        } else {
                            showTaskDetails(content)
                        }
                    },
                    error: function () {
                        Notify("Error, no se puede responder la tarea", 'bottom-right', '5000', 'danger', 'fa-edit', true);
                    }
                });
            },
            cancel: function () {
            }
        });
    }
}

function TaskFormAddedSucces(content) {
    Notify("La tarea ha sido respondida con éxito", 'bottom-right', '5000', 'success', 'fa-edit', true);
    window.location.reload(true);
}
function TaskFormAddedFailure(content) {
    Notify("Error, no se puede responder la tarea", 'bottom-right', '5000', 'danger', 'fa-edit', true);
}