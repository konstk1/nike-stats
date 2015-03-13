// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.turbolinks
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .

$(function() {
    $('#sync_btn').on('click', function () {
        console.log("Animating...");
        $('#sync_icon').animate({rotation: "+=360"}, {step: function(angle, fx) {
            console.log(angle);
            $(this).css({
                "-moz-transform":"rotate("+angle+"deg)",
                "-webkit-transform":"rotate("+angle+"deg)",
                "-ms-transform":"rotate("+angle+"deg)",
                "-o-transform":"rotate("+angle+"deg)"
            });
        }, complete: function() {
          console.log("Rotation complete.");
        }, duration: 1000});


        $.ajax({
            url: '/sync',
            success: function (data) {
                console.log(data);
            }
        });
    });
});

//function rotate(object, degrees) {
//    object.animate
//}

