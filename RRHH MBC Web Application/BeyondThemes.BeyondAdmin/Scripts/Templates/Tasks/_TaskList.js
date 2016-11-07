﻿//-- loading animation 

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
            $("#taskForm").sortable({
                items: "> tr:not(:has(:has(>.no-handle-form)))",
                //items: "> li:not(:has(>.no-handle))",
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
                var count = 0;
                $(this).remove()
                $("#taskList").children().each(function () {
                    var id = this.id
                    var name = $(this).find('#stageName' + id).text();
                    var newPos = count;
                    $.ajax({
                        url: "/Tasks/_EditTaskPosition/?id_task=" + id + '&taskPosition=' + newPos,
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
                })
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
function updateTasksPosition(ui) {
    var newpos
    var count = 0;
    var lastTask_id
    ui.item.parent().children().each(function () {
        var id = this.id
        var name = $(this).find('#stageName' + id).text();
        newPos = count;
        $.ajax({
            url: "/Tasks/_EditTaskPosition/?id_task=" + id + '&taskPosition=' + newPos,
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
        lastTask_id = id;
    });
    $.ajax({
        url: "/Tasks/_RefreshTaskTimes/?id_task=" + lastTask_id,
        type: "PUT",
        dataType: "html",
        traditional: true,
        contentType: false,
    });
}
// update position when sorting
$(".todo-list").sortable({
    items: "> li:not(:has(>.no-handle))",
    placeholder: "sort-highlight",
    handle: ".handle",
    forcePlaceholderSize: true,
    zIndex: 999999,
    update: function (event, ui) {
        updateTasksPosition(ui)
    }
});
