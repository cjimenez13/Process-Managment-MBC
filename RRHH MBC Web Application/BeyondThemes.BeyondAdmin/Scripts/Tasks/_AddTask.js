$('#myWizard').wizard();
$('#myWizard').on('actionclicked.fu.wizard', function (evt, data) {
    var lastIndex = $('.badge').last().text()
    if (lastIndex == data.step) {
        return;
    }
    evt.preventDefault()
    canContinue = false
    if (data.step == 1) {
        form = $('*[data-step="' + data.step + '"]').find('form');
        var is_valid_form = form.valid();
        canContinue = is_valid_form
        if (is_valid_form) {
            var form = $('.step-content').find('form')
            var token = "__RequestVerificationToken=" + $('input[name="__RequestVerificationToken"]').val() + "&";
            var lengthFormData = form.serialize().length
            formData = token + form.serialize().substring(token.length, lengthFormData)
            $.ajax({
                headers: {
                    'X-HTTP-Method-Override': 'POST'
                },
                url: "/Tasks/_AddTask",
                method: "POST",
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                data: formData + "&X-Requested-With=XMLHttpRequest&X-HTTP-Method-Override=PUT",
                success: function (data) {
                    //Notify("El atributo '" + name + "' ha sido removido", 'bottom-right', '5000', 'success', 'fa-edit', true);
                },
                error: function () {
                    //Notify("Error, no se puede remover el atributo '" + name + "'", 'bottom-right', '5000', 'danger', 'fa-edit', true);
                }
            });
        }
    }
    else if (data.step == 2) {
        canContinue = true;
    }
    else if (data.step == 3) {
        canContinue = true;
    }
    else if (data.step == 4) {
        canContinue = true;

    }
    if (canContinue == true) {
        var toStep;
        if (data.direction === "next") {
            toStep = data.step + 1
        } else {
            toStep = data.step - 1
        }
        $('#myWizard').wizard('selectedItem', {
            step: toStep
        });
    }
});
$('#myWizard').on('finished.fu.wizard', function (evt) {
    console.log("finished")
});

//-- task added
function TaskAddedSuccess(content) {
    Notify("La tarea ha sido agregada con éxito", 'bottom-right', '5000', 'success', 'fa-edit', true);
    $('#TaskListDiv').html(content)
    $(".todo-list").sortable({
        placeholder: "sort-highlight",
        handle: ".handle",
        forcePlaceholderSize: true,
        zIndex: 999999
    });
}
function TaskAddedFailure(content) {
    Notify("Error, no se puede agregar la tarea", 'bottom-right', '5000', 'danger', 'fa-edit', true);
}

var timeDateText = "";
var timeHourText = "";
function timeChanged(sel) {
    var timeAmount = $('#timeAmountDiv');
    var timeDate = $('#timeDateDiv');
    if (sel.value === "days" | sel.value==="hours") {
        timeAmount.show();
        timeDate.hide();
        var actualTimeDate = timeDate.find('#timeDatePicker').val();
        var actualTimeHour = timeDate.find('#timeHour').val()
        if (actualTimeDate.lenght !== 10) {
            timeDate.find('#timeDatePicker').val(timeDateText);
        }
        if (actualTimeHour.lenght !== 8) {
            console.log(timeHourText)
            timeDate.find('#timeHour').val(timeHourText)
        }
    } else if (sel.value === "date") {
        timeDate.show();
        var actualTimeDate = timeDate.find('#timeDatePicker').val();
        if (timeDateText == "") {
            timeDateText = timeDate.find('#timeDatePicker').val();
            timeHourText = timeDate.find('#timeHour').val();
        }
        timeAmount.hide();
    }
}
function getTaskTypes(callback) {
    $.ajax({
        url: "/Tasks/_GetTaskTypes/", type: "GET", dataType: "html",
        success: function (data) {
            if (callback) callback(data);
        },
    });
}
function getFormPageStep(callback) {
    $.ajax({
        url: "/Tasks/_AddForm/", type: "GET", dataType: "html",
        success: function (data) {
            if (callback) callback(data);
        },
    });
}
var taskTypes
taskTypes = getTaskTypes()
function taskTypeChanged(sel) {
    refreshSteps(sel.value);
}
function refreshSteps(taskType_id) {
    $('#id_stage').val()
    $('#myWizard').wizard('removeSteps', 2, 3);
    var lastIndex;
    $.each(taskTypes, function (iTaskType, taskType) {
        if (taskType.id_taskType == taskType_id) {
            if (taskType.needConfirm == "True") {
                addResponsablesStep();
            }
            if (taskType.formNeeded == "True") {
                addFormStep();
            }
        }
    });
    addAditionalsStep();
}
function addAditionalsStep() {
    lastIndex = $('.badge').last().text() + 1
    $('#myWizard').wizard('addSteps', lastIndex, [
    {
        badge: lastIndex,
        label: 'Adicionales',
        pane: '<div>Content</div>'
    }
    ]);
}
function addFormStep(){
    lastIndex = $('.badge').last().text();
    getFormPageStep(function (view) {
        console.log(view)
        $('#myWizard').wizard('addSteps', lastIndex, [
       {
           badge: lastIndex,
           label: 'Formulario',
           pane: view
       }
        ]);
    })
   
}
function addResponsablesStep() {
    lastIndex = $('.badge').last().text() + 1
    $('#myWizard').wizard('addSteps', lastIndex, [
        {
            badge: lastIndex,
            label: 'Responsables',
            pane: '<div>Content</div>'
        }
    ]);
}

$(document).ready(function () {
    getTaskTypes(function (result) {
        taskTypes = JSON.parse(result);
        refreshSteps(0)
    })
});

$('.date-picker').datepicker();
$('.spinbox').spinbox();
