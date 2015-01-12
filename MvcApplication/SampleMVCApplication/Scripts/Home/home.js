$(document).ready(function () {
    $('.btn-primary').click(function () {
        $('.alert-danger').hide();
        $('.alert-success').show();
    });
    $('.btn-default').click(function () {
        $('.alert-success').hide();
        $('.alert-danger').show();
    });

});