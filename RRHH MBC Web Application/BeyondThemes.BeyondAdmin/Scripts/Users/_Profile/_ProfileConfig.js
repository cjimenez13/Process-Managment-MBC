function PasswordChangedSuccess(data) {
    Notify('La contraseña ha sido cambiada con éxito', 'bottom-right', '5000', 'success', 'fa-edit', true);
}
function PasswordChangeFailure(data) {
    Notify('Error, no se puede cambiar la contraseña', 'bottom-right', '5000', 'danger', 'fa-edit', true);
}
function ConfigInfoSuccess(data) {
    Notify('La ha información se ha guardado con éxito', 'bottom-right', '5000', 'success', 'fa-edit', true);
}
function ConfigInfoFailure(data) {
    Notify('Error, no se puede editar la información', 'bottom-right', '5000', 'danger', 'fa-edit', true);
}
function UserFileAddedSuccess(data) {
    Notify('La ha información se ha guardado con éxito', 'bottom-right', '5000', 'success', 'fa-edit', true);
}
function UserFileAddedFailure(data) {
    Notify('Error, no se puede editar la información', 'bottom-right', '5000', 'danger', 'fa-edit', true);
}

function DisableUserSuccess(data) {
    Notify('El usuario se ha deshabilitado con éxito', 'bottom-right', '5000', 'success', 'fa-edit', true);
}
function DisableUserFailure(data) {
    Notify('Error, no se puede deshabilitar el usuario ', 'bottom-right', '5000', 'danger', 'fa-edit', true);
}
function onSuccessAddRole(data) {
    Notify('El rol se ha añadido con éxito', 'bottom-right', '5000', 'success', 'fa-edit', true);
    var rolesTab = $('#roles-tab');
    rolesTab.empty();
    rolesTab.html(data);
}
function onFailureAddRole(data) {
    Notify('Error, no se puede añadir el rol', 'bottom-right', '5000', 'danger', 'fa-edit', true);
}
function deleteUserRole(user_id, id_role, name, self) {
    var toolbarLink = $(self);
    var widget = toolbarLink.parents(".widget").eq(0).parent();
    var disposeinterval = 300;
    $.ajax({
        url: "/Users/_DeleteUserRole/?user_id=" + user_id + "&id_role=" + id_role,
        type: "DELETE",
        dataType: "html",
        traditional: true,
        contentType: false,
        success: function (data) {
            Notify("El rol '" + name + "' ha sido borrado", 'bottom-right', '5000', 'success', 'fa-edit', true);
            widget.hide(disposeinterval, function () {
                widget.remove();
            });
        },
        error: function () {
            Notify("Error, no se puede borrar el rol '" + name + "'", 'bottom-right', '5000', 'danger', 'fa-edit', true);
        }
    });
}
function uploadPhoto(userName) {
    if (window.FormData !== undefined) {
        var fileUpload = $("#userPhotoUpload").get(0);
        var files = fileUpload.files;
        var fileData = new FormData();
        for (var i = 0; i < files.length; i++) {
            fileData.append(files[i].name, files[i]);
        }
        $.ajax({
            url: '/Users/UploadPhoto?user=' + userName,
            type: "POST",
            contentType: false,
            processData: false,
            data: fileData,
            success: function (result) {
                Notify("El archivo se cargo con éxito", 'bottom-right', '5000', 'success', 'fa-edit', true);
                location.reload(true)
            },
            error: function (err) {
                Notify(result.statusText, 'bottom-right', '5000', 'danger', 'fa-edit', true);
            }
        });
    } else {
        Notify("Error, explorador no soportado", 'bottom-right', '5000', 'danger', 'fa-edit', true);
    }
};
$(document).ready(function () {
    $('#province_id').change(function () {
        var id = $("#province_id").val();
        $.ajax({
            url: '/Users/getCantones',
            type: 'get',
            data: { "pProvinceID": id },
            success: function (json, textStatus) {
                $("#canton_id").empty();
                json = json || {};
                for (var i = 0; i < json.length; i++) {
                    $("#canton_id").append('<option value="' + json[i].id + '">' + json[i].name + '</option>');
                }
                $("#canton_id").prop("disabled", false);
            }
        });
    });
});