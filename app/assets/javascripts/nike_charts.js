# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#= require highcharts

$(function() {
	new Highcharts.Chart({
		chart: {
			renderTo: "chartRunsByDistance"
		},
		series: [{
			data: [0,1,2,3] #<%= @distances %>
		}],
		credits: [{
			enabled: false
		}]
	});
});