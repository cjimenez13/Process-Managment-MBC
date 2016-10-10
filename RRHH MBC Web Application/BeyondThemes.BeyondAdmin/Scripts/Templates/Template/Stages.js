﻿//-- stage added
function StageAddedSuccess(content) {
    Notify("La etapa ha sido agregada con éxito", 'bottom-right', '5000', 'success', 'fa-edit', true);
    $('#StagesListDiv').html(content)
    $(".todo-list").sortable({
        placeholder: "sort-highlight",
        handle: ".handle",
        forcePlaceholderSize: true,
        zIndex: 999999
    });
}
function StageAddedFailure(content) {
    Notify("Error, no se puede agregar la etapa", 'bottom-right', '5000', 'danger', 'fa-edit', true);
}
//-- stage name udated
function StageUpdatedSuccess(content) {
    Notify("La etapa ha sido editad con éxito", 'bottom-right', '5000', 'success', 'fa-edit', true);
    $('#stageName' + content.id_stage).text(content.name);
}
function StageUpdatedFailure(content) {
    Notify("Error, no se puede editar la etapa", 'bottom-right', '5000', 'danger', 'fa-edit', true);
}
//-- delete stage
function deleteStage(id_stage, name, element) {
    $.ajax({
        url: "/Templates/_DeleteStage/?id_stage=" + id_stage,
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
                url: "/Templates/_EditStage/?id_stage=" + id + '&stagePosition=' + newPos + '&name=' + name,
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