//-- loading animation 

var actualTask = "";
var $loading = $('#loadingDiv').hide();
var $taskDiv = $('#taskDetailsAll')
$(document)
  .ajaxStart(function () {
     
  })
  .ajaxStop(function () {
     
  });
//-- load specific task
function showTaskDetails(id_task) {
    $.ajax({
        url: "/Tasks/_TaskDetails/?id_task=" + id_task, type: "GET", dataType: "html",
        beforeSend: function () {
            $('#taskDetails').remove()
            $loading.show();
        },
        complete: function(){
            $loading.hide();
        },
        success: function (view) {
            actualTask = id_task;
            $taskDiv.html(view, 500)
            $taskDiv.hide()
            $taskDiv.fadeIn('slow')
            $('.select2').select2()
            $('.spinbox').spinbox();
            $('.date-picker').datepicker();
            console.log($('.date-picker'))
            $("#taskForm").sortable({
                items: "> tr:not(:last-child)",
                placeholder: "sort-highlight",
                handle: ".handle-form",
                forcePlaceholderSize: true,
                zIndex: 999999,
                update: function (event, ui) {
                    var newpos = ui.item.index();
                    var count = 0;
                    ui.item.parent().find("> tr:not(:last-child)").each(function () {
                        var id = this.id.substring(8, this.id.lenght);
                        var newPos = count;
                        $.ajax({
                            url: "/Tasks/_EditFormQuestion/?id_taskQuestion=" + id + '&questionPosition=' + newPos,
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
            $(":file").filestyle();
        },
        error: function () {
        }
    });
    
}


function deleteTask(id_task, name, element) {
    $.ajax({
        url: "/Tasks/_DeleteTask/?id_task=" + id_task,
        type: "DELETE",
        dataType: "html",
        traditional: true,
        contentType: false,
        success: function (data) {
            Notify("La tarea '" + name + "' ha sido removida", 'bottom-right', '5000', 'success', 'fa-edit', true);
            $(element).closest("li").hide(300, function () {
                $(this).remove()
            });
            if (id_task == actualTask) {
                $taskDiv.empty();
            }
        },
        error: function () {
            Notify("Error, no se puede remover la tarea '" + name + "'", 'bottom-right', '5000', 'danger', 'fa-edit', true);
        }
    });
}
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