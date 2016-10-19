var isTaskListHidden = false
var timeDateTextEdit = "";
var timeHourTextEdit = "";

//-- task udated
function TaskUpdatedSuccess(content) {
    Notify("La tarea ha sido editada con éxito", 'bottom-right', '5000', 'success', 'fa-edit', true);
    $('#taskDetailsWidget').html(content)
} 
function TaskUpdatedFailure(content) {
    Notify("Error, no se puede editar la tarea", 'bottom-right', '5000', 'danger', 'fa-edit', true);
}
function expandTasks(element) {
    isTaskListHidden = !isTaskListHidden
    if (isTaskListHidden) {
        $('#taskListDivAll').hide(300, function () {
            $('#taskDetailsAll').toggleClass('col-md-8 col-md-12', 300);
            $(element).find('.fa').removeClass('fa-expand')
            $(element).find('.fa').addClass('fa-compress')
        });
    }
    else {
        $('#taskDetailsAll').toggleClass('col-md-8 col-md-12', 300, function () {
            $('#taskListDivAll').show(300)
            $(element).find('.fa').removeClass('fa-compress')
            $(element).find('.fa').addClass('fa-expand')
        });
    }
}

function timeChangedEdit(sel) {
    var daysAmount = $('#daysAmountEditDiv');
    var hourAmount = $('#hourAmountEditDiv');
    var timeDate = $('#timeDateEditDiv');

    if (sel.value === "time") {
        daysAmount.show();
        hourAmount.show();
        timeDate.hide();
        var actualTimeDate = timeDate.find('#finishDateE').val();
        var actualTimeHour = timeDate.find('#finishTimeE').val()
        if (actualTimeDate.lenght !== 10) {
            timeDate.find('#finishDateE').val(timeDateTextEdit);
        }
        if (actualTimeHour.lenght !== 8) {
            timeDate.find('#finishTimeE').val(timeHourTextEdit)
        }
    } else if (sel.value === "date") {
        timeDate.show();
        daysAmount.hide();
        hourAmount.hide();
        var actualTimeDate = timeDate.find('#finishDateE').val();
        if (timeDateTextEdit == "") {
            timeDateTextEdit = timeDate.find('#finishDateE').val();
            timeHourTextEdit = timeDate.find('#finishTimeE').val();
        }
    }
}