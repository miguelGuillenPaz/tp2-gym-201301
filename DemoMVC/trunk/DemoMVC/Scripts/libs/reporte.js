function settingLine(contenedor, title, yTitle){
    
    var options = {
	chart: {
               renderTo:contenedor
	    },
	    xAxis: {
            categories: []
        },
        yAxis: {
            allowDecimals: false,
            lineWidth: 1,
            title: {
               text: yTitle
            }
        },
        plotOptions: {
        	line: {
	            dataLabels: {
	               enabled: true
	            },
	            enableMouseTracking: false
	         }
        },
        series:[],
        title: {
            text: title
	    }
        };
    return options;
}

function settingColumn(contenedor, titulo, subtitle, yLeyenda, UM){
    var options = {        
        chart: {
                renderTo: contenedor,
                type: 'column'
        },
        title: {
                text: titulo
        },
        subtitle: {
                text: subtitle
        },
        xAxis: {
                categories: [
                    /*'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'*/
                ]
        },
        yAxis: {
                min: 0,
                title: {
                        text: yLeyenda + ' (' + UM + ')'  
                }
        },
        legend: {
                layout: 'vertical',
                backgroundColor: '#FFFFFF', 
                align: 'right',
                x: -100, y: 20,
                verticalAlign: 'top',
                floating: true,
                shadow: true
        },
        tooltip: {
                formatter: function() {
                    //return ''+ this.x +': '+ UM + ' ' + this.y;
                    return ''+ this.x +': ' + this.y;
                }
        },
        plotOptions: {
                column: {
                        pointPadding: 0.2,
                        borderWidth: 0
                }
        },
        series: []
    };
    return options;
}

function settingPieChart(contenedor, titulo) {
    var options = {
        chart: {
                renderTo: contenedor,
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false
        },
        title: {
                text: titulo
        },
        tooltip: {
                formatter: function() {
                    return '<b>'+ this.point.name +'</b>: '+ Math.round(this.percentage*100)/100 +' %';
                }
        }, 
        plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                            enabled: true,
                            color: '#000000',
                            connectorColor: '#000000',
                            formatter: function() {
                                return '<b>'+ this.point.name +'</b>: '+ Math.round(this.percentage*100)/100 +' %';
                            }
                    }
                }
        },
        series: [{
                type: 'pie',
                name: 'Browser share',
                data: []
        }]
    };
    return options;
}