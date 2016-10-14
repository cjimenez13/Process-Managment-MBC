$('#myWizard').wizard();
var id_task = ""
var timeDateText = "";
var timeHourText = "";
//-- When users click next

//-- ajax to get taskTypes
function getTaskTypes(callback) {
    $.ajax({
        url: "/Tasks/_GetTaskTypes/", type: "GET", dataType: "html",
        success: function (data) {
            if (callback) callback(data);
        },
    });
}
//--  
function getStepFormHtml(callback) {
    $.ajax({
        url: "/Tasks/_AddForm/?id_task=" + id_task, type: "GET", dataType: "html",
        success: function (data) {
            if (callback) callback(data);
        },
    });
}
function getStepResponsablesHtml(callback) {
    $.ajax({
        url: "/Tasks/_AddResponsables/?id_task=" + id_task, type: "GET", dataType: "html",
        success: function (data) {
            if (callback) callback(data);
        },
    });
}
function getStepAdditionalsHtml(callback) {
    $.ajax({
        url: "/Tasks/_AddAditionals/?id_task=" + id_task, type: "GET", dataType: "html",
        success: function (data) {
            if (callback) callback(data);
        },
    });
}
function getStepChangesHtml(callback) {
    $.ajax({
        url: "/Tasks/_AddTaskChanges/?id_task=" + id_task, type: "GET", dataType: "html",
        success: function (data) {
            if (callback) callback(data);
        },
    });
}

$('#myWizard').on('actionclicked.fu.wizard', function (evt, data) {
    var lastIndex = $('.badge').last().text()
    if (lastIndex == data.step) {
        return;
    }
    evt.preventDefault()
    canContinue = false
    console.log(data.step)
    if (data.direction === "next") {
        toStep = data.step + 1
        if (data.step == 1) {
            var form = $('*[data-step="' + data.step + '"]').find('form');
            var is_valid_form = form.valid();
            if (is_valid_form) {
                if (id_task != "") {

                } else {
                    addTask(1, function (isAdded) {
                        canContinue = true
                        if (isAdded = true) {
                            $('#myWizard').wizard('selectedItem', {
                                step: toStep
                            });
                        }
                    })
                }
            }
        }
        else{
            console.log("hola")
            var actualStepContent = $('.step-content').find('*[data-step="' + data.step + '"]').find('div')
            console.log(actualStepContent.text())
            if (actualStepContent.text() === "Formulario") {
                getStepFormHtml(function (view) {
                    console.log(view)
                    actualStepContent.html(view)
                })
            }
            canContinue = true;
            $('#myWizard').wizard('selectedItem', {
                step: toStep
            });
        }
    }
    else {
        toStep = data.step - 1
        $('#myWizard').wizard('selectedItem', {
            step: toStep
        });
    }

});

//-- ajax to add task
function addTask(step, callback) {
    var form = $('*[data-step="' + step + '"]').find('form');
    var token = "__RequestVerificationToken=" + $('input[name="__RequestVerificationToken"]').val() + "&";
    var lengthFormData = form.serialize().length
    var isTaskedAdded = false;
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
            $('#taskListDiv').html(data.viewHtml)
            id_task = data.id_task;
            $("#selected_taskType").prop("disabled", true);
            $(".todo-list").sortable({
                placeholder: "sort-highlight",
                handle: ".handle",
                forcePlaceholderSize: true,
                zIndex: 999999
            });
            isTaskedAdded = true;
            if (callback) callback(isTaskedAdded);
        },
        error: function () {
            isTaskedAdded = false;
            if (callback) callback(isTaskedAdded);
        }
    });
}

//-- reset data on wizard and back to step 1
function resetWizard() {
    id_task = "";
    $('#myWizard').wizard('selectedItem', {
        step: 1
    });
    $('.step-content').find('form')[0].reset()
    $("#selected_taskType").prop("disabled", false);


}

//-- when users clicks finished on wizard
$('#myWizard').on('finished.fu.wizard', function (evt) {
    $('#modal_addTask').modal('toggle');
    //resetWizard()
});
//-- when modal changed to hidden
$('#modal_addTask').on('hidden.bs.modal', function () {
    resetWizard()
})

//-- when type of time is changed
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

var taskTypes
taskTypes = getTaskTypes()
function taskTypeChanged(sel) {
    refreshSteps(sel.value);
}
function refreshSteps(taskType_id) {
    $('#id_stage').val()
    $('#myWizard').wizard('removeSteps', 2, 4);
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
    addChangesStep();
    addAditionalsStep();
}
function addAditionalsStep() {
    lastIndex = $('.badge').last().text() + 1
    $('#myWizard').wizard('addSteps', lastIndex, [
    {
        badge: lastIndex,
        label: 'Adicionales',
        pane: '<div>Adicionales</div>'
    }
    ]);
}
function addChangesStep() {
    lastIndex = $('.badge').last().text() + 1
    $('#myWizard').wizard('addSteps', lastIndex, [
    {
        badge: lastIndex,
        label: 'Cambios',
        pane: '<div>Cambios</div>'
    }
    ]);
}
function addFormStep(){
    lastIndex = $('.badge').last().text();
    //getStepFormHtml(function (view) {
    //    $('#myWizard').wizard('addSteps', lastIndex, [
    //   {
    //       badge: lastIndex,
    //       label: 'Formulario',
    //       pane: view
    //   }
    //    ]);
    //})
    $('#myWizard').wizard('addSteps', lastIndex, [
    {
        badge: lastIndex,
        label: 'Formulario',
        pane: '<div>Formulario</div>'
    }
    ]);
   
}
function addResponsablesStep() {
    lastIndex = $('.badge').last().text() + 1
    $('#myWizard').wizard('addSteps', lastIndex, [
        {
            badge: lastIndex,
            label: 'Responsables',
            pane: '<div>Responsables</div>'
        }
    ]);
}

$(document).ready(function () {
    getTaskTypes(function (result) {
        taskTypes = JSON.parse(result);
        refreshSteps(0)
    })
    var timeDate = $('#timeDateDiv');
    timeDateText = timeDate.find('#timeDatePicker').val();
    timeHourText = timeDate.find('#timeHour').val();
});

$('.date-picker').datepicker();
$('.spinbox').spinbox();
