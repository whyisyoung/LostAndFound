$('document').ready(function() {

    // blue and white altertive for unclaimed items, green for claimed items.

    $('tr:even').addClass('info');

    $('tr > #item_status').each(function() {
        var $status = $(this).html();
        if ($status == 'claimed') {
            $(this).parents('tr').removeClass('info');
            $(this).parents('tr').addClass('success');
        }
        $(this).hide();
    });



    // for lost_item  click to show original image, fantastic!

    $("a#single_image").fancybox({
        'titleShow': false,
        'transitionIn': 'elastic',
        'transitionOut': 'elastic',
        'easingIn': 'easeOutBack',
        'easingOut': 'easeInBack'
    });


    // for navbar in item category

    var url = window.location;
    // Will only work if string in href matches with location
    $('ul.nav-pills a[href="' + url + '"]').parent().addClass('active');
    // Will also work for relative and absolute hrefs
    $('ul.nav-pills a').filter(function() {
        return this.href == url;
    }).parent().addClass('active');

});