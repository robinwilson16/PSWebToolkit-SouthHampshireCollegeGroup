﻿$(function () {
    //apply date control to date fields
    //CCCPS-75350 - updating date picker to display until current year + 2
    $("input[ID*='Date']").datepicker({ dateFormat: "dd/mm/yy", changeMonth: true, changeYear: true, yearRange: "-60:+10", updateViewDate: true, defaultViewDate: { year: '2000', defaultViewDate: { year: '2000' }, viewMode: "years", defaultDate: "-18y-m-d",} })
    $("input[ID*='VisaExpiryDate']").datepicker({ dateFormat: "dd/mm/yy", changeMonth: true, changeYear: true, yearRange: "-3:+10" })
    $("input[ID*='SchoolAttendedFrom']").datepicker({ dateFormat: "dd/mm/yy", changeMonth: true, changeYear: true, yearRange: "-100:+0" });
    $("input[ID*='SchoolAttendedTo']").datepicker({ dateFormat: "dd/mm/yy", changeMonth: true, changeYear: true, yearRange: "-100:+2" });

    //Change width of form control span for checkboxes
    $("input[type='checkbox']").parent(".form-control").attr('style', 'width:40px');

    //highlight error fields
    $(".form-group span .error").parent().find('.textfield').css("border", "1px red solid");

    $('img[src="_images/basketsmall.png"]').click(function () { window.location.href = 'webenrolment.aspx?page=~/webcontrols/checkout.ascx' });
});

//toastr notification code
function DisplayToast(m, t, p) {
    toastr.options.positionClass = p;
    toastr.options.timeout = '3000';
    switch (t) {
        case "Success":
            toastr.success(m);
            break;
        case "Error":
            toastr.error(m);
            break;
        case "Info":
            toastr.info(m);
            break;
        case "Warning":
            toastr.warning(m);
            break;
    }
}