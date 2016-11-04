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
        $("[data-toggle='tooltip']").tooltip();
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
    //pager.pagingControlsContainer = '#pagingControls';
    //pager.pagingContainerPath = '#table-processes tbody'
    //processContainer = $(pager.pagingContainerPath).children();
    //pager.paragraphsPerPage = 25; // set amount elements per page
    //pager.pagingContainer = $(pager.pagingContainerPath); // set of main container
    //pager.paragraphs = $('tr', pager.pagingContainer); // set of required containers
    //pager.showPage(1);
    //$("[data-toggle='tooltip']").tooltip();

    var processListHtml = ""
    $.ajax({
        url: "/Processes/_ProcessList/", type: "GET", dataType: "html",
        success: function (data) {
            processListHtml = data;
            //$('#table-processes tbody').html(data)
            pager.pagingControlsContainer = '#pagingControls';
            pager.pagingContainerPath = '#table-processes tbody'
            pager.pagingContainer = $(pager.pagingContainerPath); // set of main container
            console.log(pager.pagingContainer)
            processContainer = $(data);
            pager.paragraphs = $(data); // set of required containers
            pager.paragraphsPerPage = 25; // set amount elements per page
            pager.showPage(1);
            $("[data-toggle='tooltip']").tooltip();
        },
    });
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
            console.log(row.find('td:nth-child(1)').text())
            if (row.find('td:nth-child(1)').text().toLowerCase().includes(value) || row.find('td:nth-child(3)').text().toLowerCase().includes(value)) {
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
function refreshProcesses() {
    var id_categorie = $('#selectCategories').val()
    var id_template = $('#selectTemplates').val()
    var id_taskState = $('#selectProcessStates').val()
    var processListHtml = ""
    $.ajax({
        url: "/Processes/_ProcessList/?id_categorie=" + id_categorie + "&id_template=" + id_template + "&id_taskState=" + id_taskState, type: "GET", dataType: "html",
        success: function (data) {
            processListHtml = data;
            pager.pagingControlsContainer = '#pagingControls';
            pager.pagingContainerPath = '#table-processes tbody'
            pager.pagingContainer = $(pager.pagingContainerPath); // set of main container
            console.log(pager.pagingContainer)
            processContainer = $(data);
            pager.paragraphs = $(data); // set of required containers
            pager.paragraphsPerPage = 25; // set amount elements per page
            pager.showPage(1);
            $("[data-toggle='tooltip']").tooltip();
        },
    });
}

$(document).ready(function () {
    $('#selectCategories').change(function () {
        var id = $(this).val();
        $.ajax({
            url: '/Processes/getTemplates',
            type: 'get',
            data: { "categorie_id": id },
            success: function (json, textStatus) {
                $("#selectTemplates").empty();
                json = json || {};
                console.log(json)
                $("#selectTemplates").append('<option value="' + "-1" + '">' + "Todos"+'</option>');
                for (var i = 0; i < json.length; i++) {
                    $("#selectTemplates").append('<option value="' + json[i].id_processManagment + '">' + json[i].name + '</option>');
                }
                refreshProcesses();
            }
        });
    });
    $('#selectTemplates').change(function () {
        refreshProcesses();
    });
    $('#selectProcessStates').change(function () {
        console.log('hola')
        refreshProcesses();
    });
});
