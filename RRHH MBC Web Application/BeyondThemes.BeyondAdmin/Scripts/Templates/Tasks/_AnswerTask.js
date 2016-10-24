function openAnswerModal(isForm) {
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
                //$.ajax({
                //    url: "/Users/_DeleteGroupUser/?group_id=" + group_id + "&user_id=" + user_id,
                //    type: "DELETE",
                //    dataType: "html",
                //    traditional: true,
                //    contentType: false,
                //    success: function (data) {
                //        Notify("El usuario '" + name + "' ha sido removido", 'bottom-right', '5000', 'success', 'fa-edit', true);
                //        $(element).closest(".databox").parent().hide(300, function () {
                //            this.remove();
                //            var participants = $('#txtShowingUsers').text().split(' ')[1];
                //            $('#txtShowingUsers').text("Mostrando " + (participants - 1) + " miembros")
                //        });
                //    },
                //    error: function () {
                //        Notify("Error, no se puede remover el usuario '" + name + "'", 'bottom-right', '5000', 'danger', 'fa-edit', true);
                //    }
                //});
            },
            cancel: function () {
            }
        });
    }
}