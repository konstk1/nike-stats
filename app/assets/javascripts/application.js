// This is a manifest file that will be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugins vendor/assets/javascripts directory can be referenced here using a relative path.
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

var alert_timeout_ms = 5000;

$(function() {
    $('#sync_btn').on('click', function () {
        $('#sync_icon').animate({rotation: "+=360"}, {step: function(angle) {
            rotate($(this), angle);
        }, complete: function() { }, duration: 1000});

        $.ajax({
            url: '/sync',
            success: function (data) {
                if (data.num_new_runs == 0) {
                    show_alert("info", "No new runs.", alert_timeout_ms);
                } else if (data.num_new_runs < 0) {
                    show_alert("danger", "Failed to sync!", alert_timeout_ms);
                } else {
                    show_alert("success", "Synced "+data.num_new_runs+" new runs!", alert_timeout_ms);
                    if (data.num_new_runs > 0){
                        location.reload();
                    }
                }
            }
        });
    });
});

function show_alert(type, message, timeout) {
    $('#top-alert').html('<div class="alert alert-'+type+'" role="alert">'+message+'</div>');
    setTimeout(function() {
        $('.alert').remove();
    }, timeout);
}
function rotate($object, angle) {
    $object.css({
        "-moz-transform":"rotate("+angle+"deg)",
        "-webkit-transform":"rotate("+angle+"deg)",
        "-ms-transform":"rotate("+angle+"deg)",
        "-o-transform":"rotate("+angle+"deg)"
    });
}

