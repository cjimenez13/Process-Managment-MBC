var InitiateCategorieDataTable = function () {
    return {
        init: function () {
            //Datatable Initiating
            var oTable = $('#categoriedatatable').dataTable({
                "aLengthMenu": [
                    [15, 30, 50, -1],
                    [15, 30, 50, "All"]
                ],
                "sDom": "Tflt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",
                "iDisplayLength": 15,
                "oTableTools": {
                    "aButtons": [
                    ],
                    "sSwfPath": "assets/swf/copy_csv_xls_pdf.swf",

                },
                "language": {
                    "search": "",
                    "sLengthMenu": "_MENU_",
                    "info": "Mostrando _START_ a _END_ de _TOTAL_ categorias",
                    "emptyTable": "",
                    "infoEmpty": "",
                    "sZeroRecords": "",
                    "infoFiltered": "",
                    "oPaginate": {
                        "sPrevious": "Anterior",
                        "sNext": "Siguiente"
                    }

                },
                "aoColumns": [
                    null,
                    null,
                    null,
                    null,
                    { "bSortable": false }
                ],
                "aaSorting": []
            });

            //Check All Functionality
            $('#simpledatatable thead th input[type=checkbox]').change(function () {
                var set = $("#simpledatatable tbody tr input[type=checkbox]");
                var checked = $(this).is(":checked");
                $(set).each(function () {
                    if (checked) {
                        $(this).prop("checked", true);
                        $(this).parents('tr').addClass("active");
                    } else {
                        $(this).prop("checked", false);
                        $(this).parents('tr').removeClass("active");
                    }
                });

            });
            $('#simpledatatable tbody tr input[type=checkbox]').change(function () {
                $(this).parents('tr').toggleClass("active");
            });
            $(document).ready(function () {
                $('#categoriedatatable_filter input').width("10em")
                $('#categoriedatatable_filter input').attr("placeholder", "Buscar...");;
                $('#categoriedatatable_filter input').removeClass("input-sm");
                $('#categoriedatatable_filter input').addClass("input");
            });
        }
    };

}();
