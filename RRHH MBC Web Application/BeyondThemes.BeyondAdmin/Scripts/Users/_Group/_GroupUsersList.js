function GroupUsersAddedSuccess(content) {
    if (content.usersAdded.length = 1) {
        Notify("Se ha agregado " + content.usersAdded.length + " usuario con éxito", 'bottom-right', '8000', 'success', 'fa-edit', true);
    }
    else {
        Notify("Se han agregado " + content.usersAdded.length + " usuarios con éxito", 'bottom-right', '8000', 'success', 'fa-edit', true);
    }
    if (content.usersError.length == 1) {
        Notify(content.usersError.length + " de los usuarios ya se encuentra en el grupo", 'bottom-right', '8000', 'warning', 'fa-edit', true);
    }
    else if (content.usersError.length > 1) {
        Notify(content.usersError.length + " de los usuarios ya se encuentran en el grupo", 'bottom-right', '8000', 'warning', 'fa-edit', true);
    }
    $("#groupUsersListDiv").html(content.viewHtml)
}
function GroupUsersAddedFailure(content) {
    Notify("Error, no se agregó ningun usuario", 'bottom-right', '5000', 'danger', 'fa-edit', true);
}

function filterGroupUsers(element) {
    var value = $(element).val().toLowerCase();
    var count = 0;
    $("#GroupUsersList").children().each(function () {
        if ($(this).text().toLowerCase().includes(value)) {
            $(this).show(300);
            count += 1;

        }
        else {
            $(this).hide(300)
        }
    });
    if (count == 1) {
        $('#txtShowingUsers').text("Mostrando " + count + " miembro")

    } else {
        $('#txtShowingUsers').text("Mostrando " + count + " miembros")
    }

}
function deleteGroupUser(user_id, group_id, name, element) {
    $.confirm({
        icon: 'fa fa-warning',
        keyboardEnabled: true,
        title: 'Precaución!',
        content: "El usuario '" + name + "' va a a ser removido, seguro que desea removerlo?",
        confirmButton: "Confirmar",
        cancelButton: "Cancelar",
        confirm: function () {
            $.ajax({
                url: "/Users/_DeleteGroupUser/?group_id=" + group_id + "&user_id=" + user_id,
                type: "DELETE",
                dataType: "html",
                traditional: true,
                contentType: false,
                success: function (data) {
                    Notify("El usuario '" + name + "' ha sido removido", 'bottom-right', '5000', 'success', 'fa-edit', true);
                    $(element).closest(".databox").parent().hide(300, function () {
                        this.remove();
                        var participants = $('#txtShowingUsers').text().split(' ')[1];
                        $('#txtShowingUsers').text("Mostrando " + (participants - 1) + " miembros")
                    });
                },
                error: function () {
                    Notify("Error, no se puede remover el usuario '" + name + "'", 'bottom-right', '5000', 'danger', 'fa-edit', true);
                }
            });
        },
        cancel: function () {
        }
    });
}