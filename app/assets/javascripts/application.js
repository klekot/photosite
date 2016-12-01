// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require fancybox
//= require bootstrap-sprockets
//= require_tree .

$(document).ready(function() {
    $("a.fancybox").fancybox({
        'transitionIn'  :   'elastic',
        'transitionOut' :   'elastic',
        'speedIn'       :   600,
        'speedOut'      :   200,
        'overlayShow'   :   true,
        'margin'        :   50,
        'showCloseButton' : true,
        'showNavArrows' :  true,
        'cyclic'        :  false,
        'hideOnContentClick': true,
        'modal'         :  false
});

    $('.reorder_link').on('click',function(){
        $("div.reorder-photos-list").sortable({ tolerance: 'pointer' });
        $('.reorder_link').html('Сохранить расположение фото');
        $('.reorder_link').attr("id","save_reorder");
        $('#reorder-helper').slideDown('slow');
        $('.image_link').attr("href","javascript:void(0);");
        $('.image_link').css("cursor","move");
        $("#save_reorder").click(function( e ){
            if( !$("#save_reorder i").length )
            {
                $(this).html('').prepend('<img src="refresh-animated.gif"/>');
                $("div.reorder-photos-list").sortable('destroy');
                $("#reorder-helper").html( "Сохраняем порядок фотографий, не обновлять страницу." ).removeClass('light_box').addClass('notice notice_error');
                var h = [];
                $("div.reorder-photos-list span").each(function() {  h.push($(this).attr('id').substr(9));  });
                $.ajax({
                    type: "POST",
                    url: "order_update",
                    data: {ids: " " + h + ""},
                    success: function(html)
                    {
                        window.location.reload();
                    }
                });
                return false;
            }
            e.preventDefault();
        });
    });
});