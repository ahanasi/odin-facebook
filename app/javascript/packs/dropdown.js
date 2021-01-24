// Preloader JS
jQuery(window).on('load', function () {
    $('.preloader').fadeOut();
});

$(".dropdown .button").click(function () {
    var dropdown = $(this).parents('.dropdown');
    dropdown.toggleClass('is-active');
    dropdown.focusout(function () {
        $(this).removeClass('is-active');
    });
});