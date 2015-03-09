// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
//= require highcharts

$(function() {
    chartGoalBurndown();
});

function chartGoalBurndown() {
    var options = $.extend(true, {}, defaultGoalChartOptions);
    options.title.text = 'Goal';
    options.xAxis.title.text = 'Date';
    options.yAxis.title.text = 'Distance (mi)';
    options.series.push({
        name: "Ideal",
        color: "Blue",
        pointStart: gon.goal_start_date,
        pointInterval: gon.goal_date_interval,
        data: gon.goal_ideal_distance
    });
    options.series.push({
        name: "Actual",
        color: "Red",
        pointStart: gon.goal_start_date,
        pointInterval: gon.goal_date_interval,
        data: gon.goal_actual_distance
    });
    $('#goalChart').highcharts(options);
}

var defaultGoalChartOptions = {
    chart: {
        panning:  true,
        panKey:   "shift",
        zoomType: "xy"
    },
    legend: {
        enabled: false
    },
    title: {
        text: 'Chart Title'
    },
    xAxis: {
        title: {
            text: 'X Title'
        },
        type: 'datetime',
        tickLength: 2,
        tickmarkPlacement: 'on',
        gridLineWidth: .5
    },
    yAxis: {
        title: {
            text: 'Y Title'
        },
        gridLineWidth: .5,
        minorGridLineWidth: .5,
        minorTickInterval: 'auto'
    },
    series: [{
    }],
    plotOptions: {
        series: {
            dataLabels: {
                enabled: false
            }
        },
        line: {
            marker: {
                enabled: false
            }
        }
    },
    tooltip: {
        enabled: true
    },
    credits: [{
        enabled: false
    }]
};