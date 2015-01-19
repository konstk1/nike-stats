// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
//= require highcharts

$(function() {
	chartRunsByDistance();
	chartRunsByDayOfWeek();
	chartAvgDistanceByDayOfWeek();
});

function chartRunsByDistance() {
	var options = $.extend(true, {}, defaultColumnChartOptions);
	options.title.text = 'Runs by Distance';
	options.xAxis.title.text = 'Distance (mi)';
	options.yAxis.title.text = 'Num Runs';
	options.xAxis.categories = $('#chartRunsByDistance').data('x');
	options.series[0].data = $('#chartRunsByDistance').data('y');
	$('#chartRunsByDistance').highcharts(options);
}

function chartRunsByDayOfWeek() {
	var options = $.extend(true, {}, defaultColumnChartOptions);
	options.title.text = 'Runs by Day of Week';
	options.xAxis.title.text = 'Day of Week';
	options.yAxis.title.text = 'Num Runs';
	options.xAxis.categories = $('#chartRunsByDayOfWeek').data('x');
	options.series[0].data = $('#chartRunsByDayOfWeek').data('y');
	$('#chartRunsByDayOfWeek').highcharts(options);
}

function chartAvgDistanceByDayOfWeek() {
	var options = $.extend(true, {}, defaultColumnChartOptions);
	options.title.text = 'Avg Distance by Day of Week';
	options.xAxis.title.text = 'Day of Week';
	options.yAxis.title.text = 'Avg Distance (mi)';
	options.xAxis.categories = $('#chartAvgDistanceByDayOfWeek').data('x');
	options.series[0].data = $('#chartAvgDistanceByDayOfWeek').data('y');
	options.plotOptions.series.dataLabels.format = '{y:.1f}'
	$('#chartAvgDistanceByDayOfWeek').highcharts(options);
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