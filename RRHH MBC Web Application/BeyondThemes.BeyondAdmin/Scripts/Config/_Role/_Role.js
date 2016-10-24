function getPermissionElements(id_rolePermission) {
    var bodyTable = $("tbody:last");
    $.ajax({
        url: "/Config/_PermissionElements/?id_rolePermission=" + id_rolePermission,
        type: "GET",
        dataType: "html",
        traditional: true,
        contentType: false,
        success: function (data) {
            bodyTable.empty();
            bodyTable.html(data);
        },
        error: function () {
        }
    });
}
function elementChanged(role_permission_id, id_element, checkbox, name) {
    var isChecked = checkbox.checked;
    $.ajax({
        url: "/Config/_UpdateRoleElement/",
        type: "PUT",
        dataType: "html",
        data: "role_permission_id=" + role_permission_id + "&id_element=" + id_element + "&isEnabled=" + isChecked,
        success: function (data) {
            if (isChecked) {
                Notify("El elemento '" + name + "' se ha habilitado", 'bottom-right', '5000', 'success', 'fa-edit', true);
                $(checkbox).closest("tr").addClass('success');
            } else {
                Notify("El elemento '" + name + "' se ha deshabilitado", 'bottom-right', '5000', 'success', 'fa-edit', true);
                $(checkbox).closest("tr").removeClass('success');
            }
        },
        error: function () {
            Notify("Error, no se puede editar el elemento", 'bottom-right', '5000', 'danger', 'fa-edit', true);
        }
    });
}
function permissionChanged(id_role_permission, name, checkbox) {
    var isChecked = checkbox.checked;
    $.ajax({
        url: "/Config/_UpdateRolePermission/",
        type: "PUT",
        dataType: "html",
        data: "id_role_permission=" + id_role_permission + "&isEnabled=" + isChecked,
        success: function (data) {
            if (isChecked) {
                Notify("El permiso '" + name + "' se ha habilitado", 'bottom-right', '5000', 'success', 'fa-edit', true);
                $(checkbox).closest("tr").addClass('success');
            } else {
                Notify("El permiso '" + name + "' se ha deshabilitado", 'bottom-right', '5000', 'success', 'fa-edit', true);
                $(checkbox).closest("tr").removeClass('success');
            }
        },
        error: function () {
            Notify("Error, no se puede editar el permiso", 'bottom-right', '5000', 'danger', 'fa-edit', true);
        }
    });
}