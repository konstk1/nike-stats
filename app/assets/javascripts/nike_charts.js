// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
//= require highcharts

$(function() {
	new Highcharts.Chart({
		chart: {
			renderTo: 'chartRunsByDistance',
			type: 'column'
		},
		title: {
			text: 'Runs by Distance'
		},
		xAxis: {
			categories: $('#chartRunsByDistance').data('x')
		},
		series: [{
			data: $('#chartRunsByDistance').data('y')
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
	});
});