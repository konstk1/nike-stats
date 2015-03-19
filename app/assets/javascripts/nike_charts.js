// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
//= require highcharts

$(function() {
    if ($(".nike_charts.index").length) {
        chartRunsByDistance($('#chartRunsByDistance'));
        chartRunsByDayOfWeek($('#chartRunsByDayOfWeek'));
        chartAvgDistanceByDayOfWeek($('#chartAvgDistanceByDayOfWeek'));
    }
});

function chartRunsByDistance($chartElement) {
	var options = $.extend(true, {}, defaultColumnChartOptions);
	options.title.text = 'Runs by Distance';
	options.xAxis.title.text = 'Distance (mi)';
	options.yAxis.title.text = 'Num Runs';
	options.xAxis.categories = $chartElement.data('x');
	options.series[0].data = $chartElement.data('y');
    $chartElement.highcharts(options);
}

function chartRunsByDayOfWeek($chartElement) {
	var options = $.extend(true, {}, defaultColumnChartOptions);
	options.title.text = 'Runs by Day of Week';
	options.xAxis.title.text = 'Day of Week';
	options.yAxis.title.text = 'Num Runs';
	options.xAxis.categories = $chartElement.data('x');
	options.series[0].data = $chartElement.data('y');
    $chartElement.highcharts(options);
}

function chartAvgDistanceByDayOfWeek($chartElement) {
	var options = $.extend(true, {}, defaultColumnChartOptions);
	options.title.text = 'Avg Distance by Day of Week';
	options.xAxis.title.text = 'Day of Week';
	options.yAxis.title.text = 'Avg Distance (mi)';
	options.xAxis.categories = $chartElement.data('x');
	options.series[0].data = $chartElement.data('y');
	options.plotOptions.series.dataLabels.format = '{y:.1f}';
    $chartElement.highcharts(options);
}

var defaultColumnChartOptions = {
	chart: {
		type: 'column'
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
			pointPadding: 0.01,
			groupPadding: 0.01,
			dataLabels: {
				enabled: true,
				defer: false,
				crop: false,
				overflow: 'none'
			}
		}
	},
	tooltip: {
		enabled: false
	},
	credits: [{
		enabled: false
	}]
};