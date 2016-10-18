// to change the content on cantones select 
$(document).ready(function () {
    $('#selectPronvices').change(function () {
        var id = $("#selectPronvices").val();
        $.ajax({
            url: '@Url.Action("getCantones", "Users")',
            type: 'get',
            data: { "pProvinceID": id },
            success: function (json, textStatus) {
                $("#selectCantones").empty();
                json = json || {};
                for (var i = 0; i < json.length; i++) {
                    $("#selectCantones").append('<option value="' + json[i].id + '">' + json[i].name + '</option>');
                }
                $("#selectCantones").prop("disabled", false);
            }
        });
    });
});

function UserAddedSuccess(content) {
    Notify('El usuario se ha registrado con exito', 'bottom-right', '5000', 'success', 'fa-edit', true);
    $('#usersTab').html(content);
}
function UserAddedFailure(content) {
    Notify('Error, no se puede registrar el usuario', 'bottom-right', '5000', 'danger', 'fa-edit', true);
}