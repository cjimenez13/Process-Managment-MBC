$('#myWizard').wizard();
$('#myWizard').on('actionclicked.fu.wizard', function (evt, data) {
    evt.preventDefault()
    canContinue = false
    if (data.step == 1) {
        form = $('*[data-step="' + data.step + '"]').find('form');
        //var validate_options.ignore = ':input:hidden';

        var is_valid_form = form.valid();
        canContinue = is_valid_form
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
$('#myWizard').on('finished.fu.wizard', function (evt, data) {
    $('step-content').find('form')
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

function timeChanged(sel) {
    var timeAmount = $('#timeAmount');
    var timeDate = $('#timeDate');
    if (sel.value === "days" | sel.value==="hours") {
        timeAmount.show();
        timeAmount.data('val', true)

        timeDate.hide();
        timeDate.find('input').data('val', false)

    } else if (sel.value === "date") {
        timeDate.show();
        timeDate.find('input').data('val',true)
        timeAmount.hide();
        timeAmount.data('val', false)
    }
    ValidatorUpdateDisplay(validatorObject);
}
$('.date-picker').datepicker();
$('.spinbox').spinbox();
