// script to filter the list of users 
function filterUsers(element) {
    var value = $(element).val().toLowerCase();
    $("#userList").children().each(function () {
        if ($(this).text().toLowerCase().indexOf(value) !== -1) {
            $(this).show(300);
        }
        else {
            $(this).hide(300)
        }
    });
}