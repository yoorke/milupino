$(document).ready(function () {
    $('#dtpDateFrom').datetimepicker({
        format: 'd.m.Y',
        timepicker: false,
        defaultDate: new Date()
    });

    $('#dtpDateTo').datetimepicker({
        format: 'd.m.Y',
        timepicker: false,
        defaultDate: new Date()
    });

    var date = new Date();
    date.setDate(1);
    date.setMonth(date.getMonth() - 12);
    $('#dtpDateFrom').val($.datepicker.formatDate('dd.mm.yy', date));

    $('#dtpDateTo').val($.datepicker.formatDate('dd.mm.yy', new Date()));

    $('#chkDay, #chkMonth').change(ShowOrdersCharts);

    ShowOrdersCharts();

    $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
        var target = $(e.target).attr('href');
        //alert(target);
        if (target.toString() == '#tbpOrders')
            ShowOrdersCharts();
        else if (target.toString() == '#tbpCategories')
            ShowCategoriesCharts();
    })
})

var categoryPercentageChart;
var categoryValueChart;

function ShowOrdersCharts()
{
    if ($('#chkDay').prop('checked')) {
        GetNumberOfOrdersByDay(ChangeDateFormat($('#dtpDateFrom').val().toString()), ChangeDateFormat($('#dtpDateTo').val().toString()));
        GetValuesByDay(ChangeDateFormat($('#dtpDateFrom').val().toString()), ChangeDateFormat($('#dtpDateTo').val().toString()));
        
    }
    else {
        GetNumberOfOrdersByMonth(ChangeDateFormat($('#dtpDateFrom').val().toString()), ChangeDateFormat($('#dtpDateTo').val().toString()));
        GetValuesByMonth(ChangeDateFormat($('#dtpDateFrom').val().toString()), ChangeDateFormat($('#dtpDateTo').val().toString()));
        //GetCategoryPercentage(ChangeDateFormat($('#dtpDateFrom').val().toString()), ChangeDateFormat($('#dtpDateTo').val().toString()));
        //GetCategoryValue(ChangeDateFormat($('#dtpDateFrom').val().toString()), ChangeDateFormat($('#dtpDateTo').val().toString()));
    }

}

function ShowCategoriesCharts() {
    GetCategoryPercentage(ChangeDateFormat($('#dtpDateFrom').val().toString()), ChangeDateFormat($('#dtpDateTo').val().toString()));
    GetCategoryValue(ChangeDateFormat($('#dtpDateFrom').val().toString()), ChangeDateFormat($('#dtpDateTo').val().toString()));
}


function GetNumberOfOrdersByDay(dateFrom, dateTo) {
    var data;
    $('#chartNumberOfOrdersPleaseWait').show();
    $.ajax({
        type: "POST",
        url: "../WebMethods.aspx/GetNumberOfOrdersByDay",
        data: JSON.stringify({ "dateFrom": dateFrom, "dateTo": dateTo }),
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        success: function (msg) {
            //alert(JSON.parse(msg.d));
            $('#chartNumberOfOrders').empty();
            data = JSON.parse((msg.d));

            Morris.Line({
                element: 'chartNumberOfOrders',
                data: data,
                parseTime: true,
                xkey: 'date',
                ykeys: ['count'],
                labels: ['Broj porudžbina'],
                resize: true,
                smooth: false
            });

            //var orders = [];
            //for (i = 0; i < data.length; i++) {
                //var item = {
                    //x: new Date(data[i].date),
                    //y: data[i].count
                //}
                //orders.push(item);
            //}
            //var options = {
                //title: {
                    //text: "Broj porudžbina"
                //},
                //animationEnabled: true,
                //axisX:{
                    //valueFormatString: 'DD/MMM',
                    //interval: 1,
                    //intervalType: "month"
                //},
                //zoomEnabled: true,
                //data: [{
                        //type: 'line',
                        //dataPoints: [
                            //{ x: new Date(2015, 01, 01), y: 450 },
                            //{ x: new Date(2015, 12, 31), y: 414 },
                    //]
                        //dataPoints: orders
                    //}]
            //}

            //$('#chartNumberOfOrdersCanvas').CanvasJSChart(options);

            //$('#chartNumberOfOrdersCanvas').height($('.canvasjs-chart-canvas').height());
            var ctx = $('#chartNumberOfOrders2').get(0).getContext('2d');
            //var legend = { labels: ['1'] };
            //data.push('labels', legend);
            var dataChart = [];
            for (i = 0; i < data.length; i++) {
                
                dataChart.push(data[i].count);
            }
            var labels = [];
            for (i = 0; i < data.length; i++) {
                if (i % 10 === 0)
                    labels.push($.datepicker.formatDate('dd mm yy', new Date(data[i].date)));
                else
                    labels.push('');
            }

            var data = {
                labels: labels,
                datasets: [{
                    label: '34242',
                    fillColor: 'rgba(220,220,220,0.2)',
                    stroleColor: 'rgba(220,220,220,1)',
                    pointColor: 'rgba(220,220,220,1)',
                    pointStrokeColor: 'rgba(220,220,220,1)',
                    pointHighlightFill: 'rgba(220,220,220,1)',
                    pointHighlightStroke: 'rgba(220,220,220,1)',
                    data:dataChart
                }]
            }
            var myChart = new Chart(ctx).Line(data, { showTooltips: true, tooltipYPadding: 10, tooltipXOffset:100, pointHitDetectionRadius: 1});
            $('#chartNumberOfOrdersPleaseWait').hide();
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert(jqXHR.responseText);
        }
        //async: false
    })
    //return data;
}

function GetNumberOfOrdersByMonth(dateFrom, dateTo) {
    var data;
    $('#chartNumberOfOrdersPleaseWait').show();
    $.ajax({
        type: "POST",
        url: "../WebMethods.aspx/GetNumberOfOrdersByMonth",
        data: JSON.stringify({ "dateFrom": dateFrom, "dateTo": dateTo }),
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        success: function (msg) {
            $('#chartNumberOfOrders').empty();
            data = JSON.parse(msg.d);

            Morris.Line({
                element: 'chartNumberOfOrders',
                data: data,
                parseTime: true,
                xkey: 'date',
                ykeys: ['count'],
                labels: ['Broj porudžbina'],
                resize: true,
                smooth: true
            });
            $('#chartNumberOfOrdersPleaseWait').hide();
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert(jqXHR.responseText);
        }
    })
}

function GetValuesByMonth(dateFrom, dateTo) {
    var data;
    $('#chartValuesPleaseWait').show();
    $.ajax({
        type: "POST",
        url: "../WebMethods.aspx/GetValuesByMonth",
        data: JSON.stringify({ "dateFrom": dateFrom, "dateTo": dateTo }),
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        success: function (msg) {
            data = JSON.parse(msg.d);
            $('#chartValues').empty();

            Morris.Line({
                element: 'chartValues',
                data: data,
                parseTime: true,
                xkey: 'date',
                ykeys: ['value'],
                labels: ['Iznos'],
                resize: true
            });
            $('#chartValuesPleaseWait').hide();
        },
        error: function(jqXHR, textStatus, errorThrown){
            alert(jqXHR.responseText);
        }
        //async: false
    });
//return data;
}

function GetValuesByDay(dateFrom, dateTo) {
    var data;
    $('#chartValuesPleaseWait').show();
    $.ajax({
        type: "POST",
        url: "../WebMethods.aspx/GetValuesByDay",
        data: JSON.stringify({ "dateFrom": dateFrom, "dateTo": dateTo }),
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        success: function (msg) {
            data = JSON.parse(msg.d);
            $('#chartValues').empty();

            Morris.Line({
                element: 'chartValues',
                data: data,
                parseTime: true,
                xkey: 'date',
                ykeys: ['value'],
                labels: ['Iznos'],
                resize: true
            });
            $('#chartValuesPleaseWait').hide();
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert(jqXHR.responseText);
        }
        //async: false
    });
    //return data;
}

function GetCategoryPercentage(dateFrom, dateTo) {
    var data;
    $('#chartCategoryPercentagePleaseWait').show();
    $.ajax({
        type: "POST",
        url: "../WebMethods.aspx/GetCategoryPercentage",
        data: JSON.stringify({ "dateFrom": dateFrom, "dateTo": dateTo }),
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        success: function (msg) {
            data = JSON.parse(msg.d);
            InsertColor(data);
            $('#chartCategoryPercentage').empty();
            //$('#chartCategoryPercentage').destroy();

            var ctx = $('#chartCategoryPercentage').get(0).getContext('2d');
            if (categoryPercentageChart != null)
                categoryPercentageChart.destroy();
            categoryPercentageChart = new Chart(ctx).Pie(data, {responsive: true});
            legend(document.getElementById('chartCategoryPercentageLegend'), data, '%');
            $('#chartCategoryPercentagePleaseWait').hide();
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert(jqXHR.responseText);
        }
    })
}

function GetCategoryValue(dateFrom, dateTo) {
    var data;
    $('#chartCategoryValuePleaseWait').show();
    $.ajax({
        type: "POST",
        url: "../WebMethods.aspx/GetCategoryValue",
        data: JSON.stringify({ "dateFrom": dateFrom, "dateTo": dateTo }),
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        success: function (msg) {
            data = JSON.parse(msg.d);
            InsertColor(data);
            $('#chartCategoryValue').empty();

            var ctx = $('#chartCategoryValue').get(0).getContext('2d');
            if (categoryValueChart != null)
                categoryValueChart.destroy();
            categoryValueChart = new Chart(ctx).Pie(data, { responsive: true });
            legend(document.getElementById('chartCategoryValueLegend'), data, 'din');
            $('#chartCategoryValuePleaseWait').hide();
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert(jqXHR.responseText);
        }
    })
}

function InsertColor(data) {
    var colors = ['#4d4d4d', '#5da5da', '#faa43a', '#60bd68', '#f17cb0', '#b2912f', '#b276b2', '#decf3f', '#f15854'];
    var j = 0;
    for (var i = 0; i < data.length; i++) {
        data[i].color = colors[j];
        data[i].highlight = colors[j];
        j++;
        if (j == colors.length)
            j = 0;
    }
}