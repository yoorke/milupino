<%@ Page Title="" Language="C#" MasterPageFile="~/administrator/adminPanel.Master" AutoEventWireup="true" CodeBehind="orders-graph.aspx.cs" Inherits="eshopv2.administrator.orders_graph" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Grafikon prodaje</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-2">
                <div role="form" class="form-horizontal">
                    <div class="form-group">
                        <label for="dtpDateFrom" class="control-label col-sm-2">Od:</label>
                        <div class="col-sm-10">
                            <input type="text" id="dtpDateFrom" name="dtpDateFrom" class="form-control" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-2">
                <div role="form" class="form-horizontal">
                    <div class="form-group">
                        <label for="dtpTo" class="control-label col-sm-2">Do:</label>
                        <div class="col-sm-10">
                            <input type="text" id="dtpDateTo" class="form-control" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-2">
                <button id="btnShowOrders" type="button" onclick="ShowOrdersCharts()" class="btn btn-primary">Prikaži</button>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <ul class="nav nav-tabs" id="tabs" data-tabs="tabs">
                    <li class="active"><a href="#tbpOrders" data-toggle="tab">Porudžbine</a></li>
                    <li><a href="#tbpCategories" data-toggle="tab">Kategorije</a></li>
                </ul>
            
                <div id="tab-content" class="tab-content">
                    <div class="tab-pane active" id="tbpOrders">
                        <div class="row">
                            <div class="col-lg-2 col-lg-offset-1">
                                <label class="radio-inline"><input type="radio" name="rptPeriod" checked="checked" id="chkDay" />Dnevno</label>
                                <label class="radio-inline"><input type="radio" name="rptPeriod" id="chkMonth" />Mesečno</label>
                            </div>
                        </div>
                        <div class="row margin-top-2">
                            <div class="col-lg-6">
                                <div class="graph">
                                    <div class="wrapper">
                                        <div class="pleaseWait" id="chartNumberOfOrdersPleaseWait" style="display:none"><span>Molim, sačekajte</span></div>
                                        <div id="chartNumberOfOrders">
        
                                        </div>
                                        <div class="chartLabel">
                                            <span>Broj porudžbina</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="graph">
                                    <div class="wrapper">
                                        <div class="pleaseWait" id="chartValuesPleaseWait" style="display:none"><span>Molim, sačekajte</span></div>
                                        <div id="chartValues">
            
                                        </div>
                                        <div class="chartLabel">
                                            <span>Vrednost porudžbina</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-6">
                                <div class="graph">
                                    <div class="wrapper">
                                        <div class="pleaseWait" id="chartNumberOfOrdersPleaseWait2" style="display:none"><span>Molim, sačekajte</span></div>
                                        <canvas id="chartNumberOfOrders2" style="width:100%;height:100%"></canvas>
                                        <div id="chartNumberOfOrdersCanvas">

                                        </div>
                                        <div class="chartLabel">
                                            <span>Broj porudžbina</span>
                                        </div>
                                        <div id="chartNumberOfOrdersLegend2"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div><!--tboOrders-->
                    <div class="tab-pane" id="tbpCategories">
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="graph">
                                    <div class="wrapper">
                                        <div class="pleaseWait" id="chartCategoryPercentagePleaseWait" style="display:none"><span>Molim, sačekajte</span></div>
                                        <canvas id="chartCategoryPercentage" style="width:100%; height:100%" data-unit="%"></canvas>
                                        <div class="chartLabel">
                                            <span>Broj porudžbina po kategorijama</span>
                                        </div>
                                        <div id="chartCategoryPercentageLegend"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="graph">
                                    <div class="wrapper">
                                        <div class="pleaseWait" id="chartCategoryValuePleaseWait" style="display:none"><span>Molim, sačekajte</span></div>
                                        <canvas id="chartCategoryValue" style="width:100%;height:100%" data-unit="din"></canvas>
                                        <div class="chartLabel">
                                            <span>Vrednost porudžbina po kategorijama</span>
                                        </div>
                                        <div id="chartCategoryValueLegend"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div><!--tbpCategories-->
                </div><!--tab-content-->
            </div><!--col-->
        </div><!--row-->
    </div>

    
</asp:Content>
<asp:Content ID="content3" ContentPlaceHolderID="ContentPlaceHolderFooter" runat="server">
    <script src="js/legend.js"></script>
    <script src="js/charts.js"></script>

    <%--<script>
        //$(document).ready(function () {

            

            //var data = GetNumberOfOrders(ChangeDateFormat($('#dtpDateFrom').val().toString()), ChangeDateFormat($('#dtpDateTo').val().toString()));
            //var values = GetValuesByMonth('2015-01-01', '2015-12-01');

            //Morris.Line({
            //    element: 'chartNumberOfOrders',
            //    data: data,
            //    parseTime: true,
            //    xkey: 'date',
            //    ykeys: ['count'],
            //    labels: ['count'],
            //    resize: true,
            //    smooth: false
            //});

            //Morris.Bar({
            //    element: 'chartValues',
            //    data: values,
            //    parseTime: false,
            //    xkey: 'date',
            //    ykeys: ['value'],
            //    labels: ['value'],
            //    resize: true
            //})
        //});

        //function ShowOrders() {
            //var data = GetNumberOfOrdersByDay(ChangeDateFormat($('#dtpDateFrom').val().toString()), ChangeDateFormat($('#dtpDateTo').val().toString()));
            //var values = GetValuesByMonth(ChangeDateFormat($('#dtpDateFrom').val().toString()), ChangeDateFormat($('#dtpDateTo').val().toString()));
            //var values = GetValuesByDay(ChangeDateFormat($('#dtpDateFrom').val().toString()), ChangeDateFormat($('#dtpDateTo').val().toString()));

            //$('#chartNumberOfOrders').empty();
            //$('#chartValues').empty();

            

            
        //}
        //$(document).ready(function () {
        //Morris.Area({
        //    element: 'chart',
        //    data: [{
        //        period: 'Januar',
        //        iphone: 2666,
        //        ipad: 3000,
        //        itouch:300
        //    },
        //    {
        //        period: 'Februar',
        //        iphone: 432,
        //        ipad: 4324,
        //        itouch: 2344
        //    },
        //    {
        //        period: 'Mart',
        //        iphone: 234,
        //        ipad: 333,
        //        itouch: 432
        //    },
        //    {
        //        period: 'April',
        //        iphone: 2343,
        //        ipad: 443,
        //        itouch: 2343
        //    },
        //    {
        //        period: 'Maj',
        //        iphone: 4323,
        //        ipad: 444,
        //        itouch: 432
        //    },
        //    {
        //        period: 'Jun',
        //        iphone: 3333,
        //        ipad: 234,
        //        itouch: 234
        //    },
        //    {
        //        period: 'Jul',
        //        iphone: 4323,
        //        ipad: 234,
        //        itouch: 234
        //    },
        //    {
        //        period: 'Avgust',
        //        iphone: 4323,
        //        ipad: 432,
        //        itouch: 3234
        //    },
        //    {
        //        period: 'Septembar',
        //        iphone: 342,
        //        ipad: 234,
        //        itouch: 432
        //    },
        //    {
        //        period: 'Oktobar',
        //        iphone: 345,
        //        ipad: 543,
        //        itouch: 456
        //    },
        //    {
        //        period: 'Novembar',
        //        iphone: 543,
        //        ipad: 345,
        //        itouch: 543
        //    },
        //    {
        //        period: 'Decembar',
        //        iphone: 466,
        //        ipad: 654,
        //        itouch: 345
        //    }],
        //    xkey: 'period',
        //    ykeys: ['iphone', 'ipad', 'itouch'],
        //    labels: ['iphone', 'ipad', 'itouch'],
        //    pointSize: 2,
        //    hideHover: 'auto',
        //    resize: true
        //});

        //Morris.Line({
        //element: 'chart',
        //data: [{
        //period: 'Januar',
        //iphone: 2666,
        //ipad: null,
        //itouch: 2647
        //}, {
        //period: 'Februar',
        //iphone: 2778,
        //ipad: 2294,
        //itouch: 2441
        //}, {
        //period: 'Mart',
        //iphone: 4912,
        //ipad: 1969,
        //itouch: 2501
        //}, {
        //period: 'April',
        //iphone: 3767,
        //ipad: 3597,
        //itouch: 5689
        //}, {
        //period: 'Maj',
        //iphone: 6810,
        //ipad: 1914,
        //itouch: 2293
        //}, {
        //period: 'Jun',
        //iphone: 5670,
        //ipad: 4293,
        //itouch: 1881
        //}, {
        //period: 'Jul',
        //iphone: 4820,
        //ipad: 3795,
        //itouch: 1588
        //}, {
        //period: 'Avgust',
        //iphone: 15073,
        //ipad: 5967,
        //itouch: 5175
        //}, {
        //period: 'Septembar',
        //iphone: 10687,
        //ipad: 4460,
        //itouch: 2028
        //}, {
        //period: 'Oktobar',
        //iphone: 8432,
        //ipad: 5713,
        //itouch: 1791
        //}, {
        //period: 'Novembar',
        //iphone: 3245,
        //ipad: 4354,
        //itouch: 3425
        //}, {
        //period: 'Decembar',
        //iphone: 5345,
        //ipad: 5434,
        //itouch: 5434
        //}
        //],
        //xkey: 'period',
        //ykeys: ['iphone', 'ipad', 'itouch'],
        //labels: ['iPhone', 'iPad', 'iPod Touch'],
        //pointSize: 2,
        //hideHover: 'auto',
        //resize: true,
        //parseTime: false
        //});
        //})
    //</script>--%>
</asp:Content>

