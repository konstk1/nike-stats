//= require nike_goals
//= require progressbar

$(function() {
    if ($(".home.index").length) {
        chartGoalBurndown(true);
        drawProgressBars();
    }
});

function drawProgressBars() {
    var circle = new ProgressBar.Circle('#progress-circle', {
        color: '#1BFF6C',
        strokeWidth: 8,
        trailWidth: 8,
        //fill: '#eee',
        text: {
            value: '0%',
            color: '#777',
            autoStyle: true
        },
        duration: 1000,
        easing: 'easeOut',
        step: function(state, bar) {
            bar.setText((bar.value() * 100).toFixed(0) + "%");
        }
    });

    var progress = $('#progress-circle').data("progress")
    circle.animate(progress);
}