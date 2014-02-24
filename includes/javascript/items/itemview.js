function ItemView( strControllerURL, jContext  ){
	this.ControllerURL = ( strControllerURL ? strControllerURL : '/index.cfm');
	this.Context = ( jContext ? jContext : $(document));
	$.extend(this, window.objControllerClass);
	this.Init();
};

ItemView.prototype.objPostProperties = function( objPostProperties ){
	this.PostProperties = objPostProperties;
};

ItemView.prototype.Init = function(){
	var objSelf = this;
	//$.ajaxSetup({ cache: false });
	this.SetBusy( true );

	objSelf.Context.on('click', '.noaction',
		function( objEvent ) {
			objEvent.preventDefault();
			return( false );
		}
	);

	objSelf.Context.find('.gw2currency').each(
		function() {
			var $this = $(this);
			var formatted = objSelf.formatCurrency( $this.data('amount') )
			$this.html( formatted );
		}
	);
	//html( objSelf.formatCurrency( $(this).data('amount') ) )
	
	this.SetBusy( false );
};

ItemView.prototype.setItem_ID = function(ID){
	var objSelf = this;
	objSelf.item_id = ID;
};
ItemView.prototype.getItem_ID = function(){
	var objSelf = this;
	return objSelf.item_id;
};


ItemView.prototype.setupCharts = function() {
	var objSelf = this;

	var extractChartData = function(data, yindex) {
		var output = [];
		$.each(data, function(i,v){
			output.push([v[0],v[yindex]]);
		});
    	return output;
	};

var drawChart = function(jq_selector, extra_settings) {
    Highcharts.setOptions({
        global: {useUTC: false},
        lang: {
            rangeSelectorZoom: ''
        }
    });

    var settings = {
    chart: {
        renderTo: jq_selector[0]
    },
    colors: [
       '#4572A7', 
       '#AA4643', 
       '#89A54E', 
       '#80699B', 
       '#3D96AE', 
       '#DB843D', 
       '#92A8CD', 
       '#A47D7C', 
       '#B5CA92'
    ],
    plotOptions: {
        line: {
            animation: false,
            lineWidth: 1.5,
            tooltip: {
                dateTimeLabelFormats: {
                    second: '%l:%M:%S %P',
                    minute: '%l:%M %P',
                    hour: '%l:%M %P',
                }
            }
        }
    },
    xAxis: {
        type: 'datetime',
        ordinal: false,
        dateTimeLabelFormats: {
            second: '%l:%M:%S %P',
            minute: '%l:%M %P',
            hour: '%l:%M %P'
        }
    },
    yAxis: {
        endOnTick: false,
        startOnTick: false,
        tickPixelInterval: 40,
        labels: {
            useHTML: true,
            formatter: function() {
                var gw2 = this.chart.series[0].options.currency == 'gw2';
                var output = gw2 ? objSelf.formatCurrency(this.value) : this.chart.axes[0].labelFormatter.call(this);
                return output;
            }
        }
    },
    rangeSelector: {
        buttons: [
        {type: 'day', count: 1, text: 'D'},
        {type: 'week', count: 1, text: 'W'},
        {type: 'month', count: 1, text: 'M'},
        {type: 'all', text: 'All' }
        ],
        selected: 1,
        inputEnabled: false
    },
    tooltip: {
        useHTML: true,
        formatter: function() {
            var p = this.points[0];
            var output = [moment(p.x).format('llll'), '<table class="table-condensed">'];
			//var output = ['<table class="table-condensed">'];
            $.each(this.points, function(i,point) {
                var series = point.series;
                var gw2 = series.options.currency == 'gw2';
                var dollar = series.options.currency == 'dollar';
                var align = gw2 ? '' : 'text-align:right;';
                var y;
                
                if(dollar) {
                    y = Highcharts.numberFormat(point.y.toFixed(2), 2);
                } else {
                    var yraw = point.y.toFixed(0);
                    y = gw2 ? objSelf.formatCurrency(yraw) : Highcharts.numberFormat(yraw, 0);
                }

                output.push('<tr><td style="color:'+series.color+'">'+series.name+'</td> <td style="'+align+'"><b>'+y+'</b></td></tr>');
            });
            output.push('</table>');
            return output.join('');
        }        
    }
    };
    
    if(extra_settings !== undefined) {
        $.extend(true, settings, extra_settings);
    }    
    
    var result = new Highcharts.StockChart(settings);
    return result;
};



var SIGNED = false;
var LANGUAGE = 'en';
var ITEM_LANGUAGE = 'en';
moment.lang(LANGUAGE == 'zh' ? 'zh-cn' : LANGUAGE);


var g_tooltip_timer;
var g_extreme_timer;
var price_chart;
var volume_chart;

$.getJSON('/marketdata/getPriceTrends/', { item_id: objSelf.getItem_ID() } ,function(data) {
	var date = extractChartData(data, 0);
    var sell = extractChartData(data, 1);
    var buy  = extractChartData(data, 2);
    var supply = extractChartData(data, 3);
    var demand = extractChartData(data, 4);

    price_chart = drawChart($('#price_chart'), {
		rangeSelector: {
			selected: 4
		},
        series: [
            {name: "Sell", data: sell, currency: 'gw2'},
            {name: "Buy", data: buy, currency: 'gw2'}
        ],
        plotOptions: {
            line:{
                point: {
                    events: {
                        mouseOver: function(e) {
                            if(!volume_chart) return;
                            var i = this.series.points.indexOf(this);
                            clearTimeout(g_tooltip_timer);
                            g_tooltip_timer = setTimeout(function() {
                                volume_chart.tooltip.refresh([volume_chart.series[0].points[i],
                                                              volume_chart.series[1].points[i]]);
                            }, 50);
                        }
                    }
                }
            }
        },
        xAxis: {
            events: {
                setExtremes: function(e) {
                    clearTimeout(g_extreme_timer);
                    g_extreme_timer = setTimeout(function(){
                        if(!volume_chart || !volume_chart.xAxis[0].setExtremes) return;
                        var extremes = volume_chart.xAxis[0].getExtremes();
                        if(extremes.min != e.min || extremes.max != e.max) {
                            volume_chart.xAxis[0].setExtremes(e.min, e.max);
                        }
                    }, 50);
                }
            }
        }
    });

    volume_chart = drawChart($('#volume_chart'), {
		rangeSelector: {
			selected: 4
		},
        series: [
            {name: "Supply", data: supply},
            {name: "Demand", data: demand}
        ],     
        plotOptions: {
            line:{
                point: {
                    events: {
                        mouseOver: function(e) {
                            if(!price_chart) return;
                            var i = this.series.points.indexOf(this);
                            clearTimeout(g_tooltip_timer);
                            g_tooltip_timer = setTimeout(function() {
                                price_chart.tooltip.refresh([price_chart.series[0].points[i],
                                                             price_chart.series[1].points[i]]);
                            }, 50);
                        }
                    }
                }
            }
        },        
        xAxis: {
            events: {
                setExtremes: function(e) {
                    clearTimeout(g_extreme_timer);
                    g_extreme_timer = setTimeout(function(){
                        if(!price_chart || !price_chart.xAxis[0].setExtremes) return;
                        var extremes = price_chart.xAxis[0].getExtremes();
                        if(extremes.min != e.min || extremes.max != e.max) { 
                            price_chart.xAxis[0].setExtremes(e.min, e.max);
                        }
                    }, 50);
                }
            }
        }        
    }   
    );
});



	return;
};
