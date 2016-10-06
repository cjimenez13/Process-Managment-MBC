(function ($) {
    'use strict';
    $.fn.todolist = function (options) {
        var settings = $.extend({
            onCheck: function (ele) {
                return ele;
            },
            onUncheck: function (ele) {
                return ele;
            }
        }, options);
        return this.each(function () {
            if (typeof $.fn.iCheck != 'undefined') {
                $('input', this).on('ifChecked', function () {
                    var ele = $(this).parents("li").first();
                    ele.toggleClass("done");
                    settings.onCheck.call(ele);
                });

                $('input', this).on('ifUnchecked', function () {
                    var ele = $(this).parents("li").first();
                    ele.toggleClass("done");
                    settings.onUncheck.call(ele);
                });
            } else {
                $('input', this).on('change', function () {
                    var ele = $(this).parents("li").first();
                    ele.toggleClass("done");
                    if ($('input', ele).is(":checked")) {
                        settings.onCheck.call(ele);
                    } else {
                        settings.onUncheck.call(ele);
                    }
                });
            }
        });
    };
}(jQuery));
/* The todo list plugin */
//jQu2ery UI sortable for the todo list
$(".todo-list").sortable({
    placeholder: "sort-highlight",
    handle: ".handle",
    forcePlaceholderSize: true,
    zIndex: 999999
});

//-- stage name udated
function TaskUpdatedSuccess(content) {
    Notify("La tarea ha sido editad con éxito", 'bottom-right', '5000', 'success', 'fa-edit', true);
    //$('#stageName' + content.id_stage).text(content.name);
}1
function TaskUpdatedFailure(content) {
    Notify("Error, no se puede editar la tarea", 'bottom-right', '5000', 'danger', 'fa-edit', true);
}

function deleteTask(id_task, name, element) {
    $.ajax({
        url: "/Tasks/_DeleteTask/?id_task=" + id_task,
        type: "DELETE",
        dataType: "html",
        traditional: true,
        contentType: false,
        success: function (data) {
            Notify("La etapa '" + name + "' ha sido removida", 'bottom-right', '5000', 'success', 'fa-edit', true);
            $(element).closest("li").hide(300, function () {

            });
        },
        error: function () {
            Notify("Error, no se puede remover la etapa '" + name + "'", 'bottom-right', '5000', 'danger', 'fa-edit', true);
        }
    });
}