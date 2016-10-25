function onCategoriesSelectChanged() {
    var id = $("#categorie_id").val();
    $.ajax({
        url: '/Processes/getTemplates?categorie_id='+id,
        type: 'get',
        success: function (json, textStatus) {
            $("#template_id").empty();
            json = json || {};
            for (var i = 0; i < json.length; i++) {
                $("#template_id").append('<option value="' + json[i].id_processManagment + '">' + json[i].name + '</option>');
            }
            $("#template_id").prop("disabled", false);
        }
    });
}
function ProcessAddedSuccess(content) {
    Notify("La gestión ha sido creada con éxito", 'bottom-right', '5000', 'success', 'fa-edit', true);
    $('#table-processes tbody').html(content)
    $("[data-toggle='tooltip']").tooltip();
}
function ProcessAddedFailure(content) {
    Notify("Error, no se creó la gestión", 'bottom-right', '5000', 'danger', 'fa-edit', true);
}



var Imtech = {};
Imtech.Pager = function () {
    this.currentPage = 1;
    this.numPages = function () {
        var numPages = 0;
        if (this.paragraphs != null && this.paragraphsPerPage != null) {
            numPages = Math.ceil(this.paragraphs.length / this.paragraphsPerPage);
        }
        return numPages;
    };
    this.showPage = function (page) {
        this.currentPage = page;
        var html = '';
        var count = 0
        this.paragraphs.slice((page - 1) * this.paragraphsPerPage,
            ((page - 1) * this.paragraphsPerPage) + this.paragraphsPerPage).each(function () {
                html += '<tr>' + $(this).html() + '</tr>';
                count += 1;
            });
        $(this.pagingContainerPath).html(html);
        renderControls(this.pagingControlsContainer, this.currentPage, this.numPages());
    }
    var renderControls = function (container, currentPage, numPages) {
        nextPage = currentPage + 1;
        previousPage = currentPage - 1;
        var pagingControls = '<ul class="pagination">';
        if (currentPage == 1) {
            pagingControls += '<li class="disabled"><a href="#">«</a></li>';
        } else {
            pagingControls += '<li><a href="#" onclick="pager.showPage(' + previousPage + '); return false;" >«</a></li>';
        }
        // show only +- 3 pages
        var startPage = 1;
        if (currentPage - 3 > startPage) {
            startPage = currentPage - 3;
        }
        var finishPage = numPages;
        if (finishPage - 3 > currentPage) {
            finishPage = currentPage + 3
        }
        for (var i = startPage; i <= finishPage; i++) {
            if (i != currentPage) {
                pagingControls += '<li><a href="#" onclick="pager.showPage(' + i + '); return false;">' + i + '</a></li>';
            } else {
                pagingControls += '<li class="active"><a href="#">' + i + ' <span class="sr-only">(current)</span></a></li>';
            }
        }
        if (currentPage == numPages) {
            pagingControls += '<li class = disabled><a href="#">»</a></li></ul>';
        } else {
            pagingControls += '<li><a href="#" onclick="pager.showPage(' + nextPage + '); return false;" >»</a></li></ul>';
        }
        $(container).html(pagingControls);
    }
}
var pager = new Imtech.Pager();
var processContainer;
$(document).ready(function () {
    processContainer = $('#table-processes tbody').children();
    pager.paragraphsPerPage = 9; // set amount elements per page
    pager.pagingContainer = $('#table-processes tbody'); // set of main container
    pager.paragraphs = $('tr', pager.pagingContainer); // set of required containers
    pager.pagingControlsContainer = '#pagingControls';
    pager.pagingContainerPath = '#table-processes tbody'
    pager.showPage(1);
    $("[data-toggle='tooltip']").tooltip();
});
var delay = (function () {
    var timer = 0;
    return function (callback, ms) {
        clearTimeout(timer);
        timer = setTimeout(callback, ms);
    };
})();
function filterProcess(pValue) {
    delay(function () {
        var value = pValue
        $(processContainer).each(function () {
            var row = $(this)
            if (row.text().toLowerCase().includes(value)) {
                row.addClass('visible')
                row.show();
            }
            else {
                row.removeClass('visible')
                row.hide()
            }
        });
        pager.paragraphs = $(processContainer).filter('.visible') // set of required containers
        pager.showPage(1)
        $("[data-toggle='tooltip']").tooltip();
    }, 300);
}