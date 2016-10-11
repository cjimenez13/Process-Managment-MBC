//jQu2ery UI sortable for the todo list
$("#taskForm").sortable({
    placeholder: "sort-highlight",
    handle: ".handle",
    forcePlaceholderSize: true,
    zIndex: 999999
});
// update position when sorting
$(".todo-list").sortable({
    placeholder: "sort-highlight",
    handle: ".handle",
    forcePlaceholderSize: true,
    zIndex: 999999,
    update: function (event, ui) {
        var newpos = ui.item.index();
        var count = 0;
        ui.item.parent().children().each(function () {
            var id = this.id
            var name = $(this).find('#stageName' + id).text();
            var newPos = count;
            $.ajax({
                url: "/Tasks/_EditTask/?id_task=" + id + '&taskPosition=' + newPos,
                type: "PUT",
                dataType: "html",
                traditional: true,
                contentType: false,
                success: function (data) {
                },
                error: function () {
                }
            });
            count += 1;
        });

    }
});