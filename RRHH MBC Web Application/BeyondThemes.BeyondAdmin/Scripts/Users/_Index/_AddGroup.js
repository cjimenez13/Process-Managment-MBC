function GroupAddedSuccess(content) {
    Notify("El grupo ha sido agregado", 'bottom-right', '5000', 'success', 'fa-edit', true);
    $('#groupsTab').html(content);
    groupContainers = $('#groupList').children();
    pager.paragraphsPerPage = 9; // set amount elements per page
    pager.pagingContainer = $('#groupList'); // set of main container
    pager.paragraphs = $('.groupWidget', pager.pagingContainer); // set of required containers
    pager.pagingControlsContainer = '#pagingControls';
    pager.pagingContainerPath = '#groupList';
    pager.showPage(1);
    $("[data-toggle='tooltip']").tooltip();
}
function GroupAddedFailure(content) {
    Notify("Error, no se puede agregar el grupo", 'bottom-right', '5000', 'danger', 'fa-edit', true);
}