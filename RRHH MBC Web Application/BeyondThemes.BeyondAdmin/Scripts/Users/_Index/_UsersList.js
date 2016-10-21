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
        this.paragraphs.slice((page - 1) * this.paragraphsPerPage,
            ((page - 1) * this.paragraphsPerPage) + this.paragraphsPerPage).each(function () {
                html += '<div>' + $(this).html() + '</div>';
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
var usersContainers;
$(document).ready(function () {
    pager.pagingControlsContainer = '#pagingControlsUsers'; //string of paging controls
    pager.pagingContainerPath = '#userList'; //string of the main container path
    usersContainers = $(pager.pagingContainerPath).children(); //All containers
    pager.paragraphsPerPage = 15; // set amount elements per page
    pager.pagingContainer = $(pager.pagingContainerPath); // set of main container
    pager.paragraphs = pager.pagingContainer.children() // set of required containers to search
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

// filter the list of users 
function filterUsers(element) {

    delay(function () {
        var value = $(element).val().toLowerCase();
        usersContainers.each(function () {
            if ($(this).text().toLowerCase().indexOf(value) !== -1) {
                $(this).show(300);
                $(this).addClass('visible')
            }
            else {
                $(this).removeClass('visible')
                $(this).hide(300)
            }
        });
        pager.paragraphs = $(usersContainers).filter('.visible') 
        pager.showPage(1)
        $("[data-toggle='tooltip']").tooltip();
    }, 300);
}
