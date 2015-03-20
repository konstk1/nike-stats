// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
//= require highcharts

$(function() {
    if ($(".nike_goals.index").length) {
        $("tr[data-link]").on("click", function() {
            window.location = this.dataset.link;
        });
    }
    else if ($(".nike_goals.show").length) {
        chartGoalBurndown(false);
    }
});

function chartGoalBurndown(zoom) {
    var options = $.extend(true, {}, defaultGoalChartOptions);
    options.title.text = 'Goal';
    options.xAxis.title.text = 'Date';
    options.yAxis.title.text = 'Distance (mi)';
    options.series.push({
        name: "Plan",
        color: "#FFEB00",
        pointStart: gon.goal_start_date,
        pointInterval: gon.goal_date_interval,
        data: gon.goal_plan_distance
    });
    options.series.push({
        name: "Actual",
        color: "#1BFF6C",
        pointStart: gon.goal_start_date,
        pointInterval: gon.goal_date_interval,
        data: gon.goal_actual_distance
    });
    chart = $('#goalChart').highcharts(options).highcharts();

    if (zoom) {
        // if zoom is enabled, limit xAxis maximum to 2 weeks past start date
        lastDate = gon.goal_start_date + gon.goal_date_interval * (gon.goal_actual_distance.length + 14);
        chart.xAxis[0].setExtremes(gon.goal_start_date, lastDate);
        chart.showResetZoom();
    }

}

var defaultGoalChartOptions = {
    chart: {
        type: 'spline',
        panning:  true,
        panKey:   "shift",
        zoomType: "x"
    },
    legend: {
        enabled: true,
        borderWidth: 1,
        backgroundColor: '#FFFFFF',
        layout: 'vertical',
        align: 'left',
        verticalAlign: 'top',
        floating: true,
        itemMarginTop: 3,
        itemMarginBottom: 3,
        x: 80,
        y: 50
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
        floor: 0,
        gridLineWidth: .5,
        //minorGridLineWidth: .4,
        //minorTickInterval: 5
    },
    series: [],
    plotOptions: {
        series: {
            dataLabels: {
                enabled: false
            },
            marker: {
                enabled: false,
                symbol: 'circle',
                radius: 1
            },
            states: {
                hover: {
                    halo: false,
                    lineWidthPlus: 0
                }
            }
        }
    },
    tooltip: {
        enabled: true,
        crosshairs: [true, true],
        shared: true,
        valueDecimals: 1,
        valueSuffix: ' mi'
    },
    credits: [{
        enabled: false
    }]
};