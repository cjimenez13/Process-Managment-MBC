var ImtechGroup = {};
ImtechGroup.Pager = function () {
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
                html += '<div>' + $(this).html() + '</div>';
                count += 1;
                if (count % 3 == 0) {
                    html += '<div class=row></div>'
                }
            });
        $(this.pagingContainerPath).html(html);
        renderControls(this.pagingControlsContainer, this.currentPage, this.numPages());
        $("[data-toggle='tooltip']").tooltip();
        console.log('hola')
    }
    var renderControls = function (container, currentPage, numPages) {
        nextPage = currentPage + 1;
        previousPage = currentPage - 1;
        var pagingControls = '<ul class="pagination">';
        if (currentPage == 1) {
            pagingControls += '<li class="disabled"><a href="#">«</a></li>';
        } else {
            pagingControls += '<li><a href="#" onclick="pagerGroup.showPage(' + previousPage + '); return false;" >«</a></li>';
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
                pagingControls += '<li><a href="#" onclick="pagerGroup.showPage(' + i + '); return false;">' + i + '</a></li>';
            } else {
                pagingControls += '<li class="active"><a href="#">' + i + ' <span class="sr-only">(current)</span></a></li>';
            }
        }
        if (currentPage == numPages) {
            pagingControls += '<li class = disabled><a href="#">»</a></li></ul>';
        } else {
            pagingControls += '<li><a href="#" onclick="pagerGroup.showPage(' + nextPage + '); return false;" >»</a></li></ul>';
        }
        $(container).html(pagingControls);
    }
}
var pagerGroup = new ImtechGroup.Pager();
var groupContainers;
$(document).ready(function () {
    var groupListHtml = ""
    $.ajax({
        url: "/Users/_GroupList/", type: "GET", dataType: "html",
        success: function (data) {
            groupListHtml = data;
            $('#groupsTab').html(groupListHtml)
            pagerGroup.pagingControlsContainer = '#pagingControlsGroups'; //string of paging controls
            pagerGroup.pagingContainerPath = '#groupList'; //string of the main container path
            groupContainers = $(pagerGroup.pagingContainerPath).children(); //All containers
            pagerGroup.paragraphsPerPage = 12; // set amount elements per page
            pagerGroup.pagingContainer = $(pagerGroup.pagingContainerPath); // set of main container
            pagerGroup.paragraphs = pagerGroup.pagingContainer.children() // set of required containers to search
            pagerGroup.showPage(1);
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
function filterGroups(pValue) {
    delay(function () {
        var value = pValue
        $(".widget-caption", groupContainers).each(function () {
            var groupBox = $(this).closest(".groupBox")
            if ($(this).text().toLowerCase().indexOf(value.toLowerCase()) != -1) {
                groupBox.addClass('visible')
                groupBox.show();
            }
            else {
                groupBox.removeClass('visible')
                groupBox.hide()
            }
        });
        pagerGroup.paragraphs = $('.visible', groupContainers).parent() // set of required containers
        pagerGroup.showPage(1)
        $("[data-toggle='tooltip']").tooltip();
    }, 300);
}

function deleteGroup(group_id, name, self) {
    $.confirm({
        icon: 'fa fa-warning',
        keyboardEnabled: true,
        title: 'Precaución!',
        content: "El grupo '" + name + "' va a a ser eliminado, seguro que desea eliminarlo?",
        confirmButton: "Confirmar",
        cancelButton: "Cancelar",
        confirm: function () {
            $.ajax({
                url: "/Users/_DeleteGroup/?group_id=" + group_id,
                type: "DELETE",
                dataType: "html",
                traditional: true,
                contentType: false,
                success: function (data) {
                    Notify("El grupo '" + name + "' ha sido borrado", 'bottom-right', '5000', 'success', 'fa-edit', true);
                    var groupBox = $(self).closest('.groupBox')
                    groupBox.hide(0, function () {
                        groupBox.remove();
                        id_groupBox = groupBox.attr('id')
                        groupContainers.find('#' + id_groupBox).remove()
                        pagerGroup.paragraphs = $('.visible', groupContainers).parent()
                        pagerGroup.showPage(pagerGroup.currentPage)
                        $("[data-toggle='tooltip']").tooltip();
                    });
                },
                error: function () {
                    Notify("Error, no se puede borrar el grupo '" + name + "'", 'bottom-right', '5000', 'danger', 'fa-edit', true);
                }
            });
        },
        cancel: function () {
        }
    });



}