function GroupAddedSuccess(content) {
    Notify("El grupo ha sido agregado", 'bottom-right', '5000', 'success', 'fa-edit', true);
    $('#groupsTab').html(content);
    pagerGroup.pagingControlsContainer = '#pagingControlsGroups'; //string of paging controls
    pagerGroup.pagingContainerPath = '#groupList'; //string of the main container path
    groupContainers = $(pagerGroup.pagingContainerPath).children(); //All containers
    pagerGroup.paragraphsPerPage = 12; // set amount elements per page
    pagerGroup.pagingContainer = $(pagerGroup.pagingContainerPath); // set of main container
    pagerGroup.paragraphs = pagerGroup.pagingContainer.children() // set of required containers to search
    pagerGroup.showPage(1);
    $("[data-toggle='tooltip']").tooltip();
}
function GroupAddedFailure(content) {
    Notify("Error, no se puede agregar el grupo", 'bottom-right', '5000', 'danger', 'fa-edit', true);
}