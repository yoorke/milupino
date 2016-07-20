function GetProductsFromKimtec(){
    $('#ctl00_ContentPlaceHolder1_divPleaseWait').show();
    $.ajax({
        type: "POST",
        url: "/administrator/WebMethods.aspx/GetProductsFromKimtec",
        data:"",
        contentType:"application/json;charset=utf-8",
        dataType:"json",
        success: function(msg){
            //alert(JSON.parse(msg.d));
            $('#ctl00_ContentPlaceHolder1_divPleaseWait').hide();
            $('#messageBox').show();
            $('#messageBoxText')[0].innerHTML = JSON.parse(msg.d);
        },
        error: function(jqXHR, textStatus, errorThrown){
            alert(jqXHR.responseText);
        }
    });
}

function GetProductsSpecificationFromKimtec(){
    $('#ctl00_ContentPlaceHolder1_divPleaseWait').show();
    $.ajax({
        type: "POST",
        url: "/administrator/WebMethods.aspx/GetProductsSpecificationFromKimtec",
        data: "",
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        success: function(msg){
            $('#ctl00_ContentPlaceHolder1_divPleaseWait').hide();
            $('#messageBox').show();
            $('#messageBoxText')[0].innerHTML = JSON.parse(msg.d);
        },
        error: function(jqXHR, textStatus, errorThrown){
            alert(jqXHR.responseText);
            $('#ctl00_ContentPlaceHolder1_divPleaseWait').hide();
        }
    });
}

function GetCategoriesFromKimtec(){
    $('#ctl00_ContentPlaceHolder1_divPleaseWait').show();
    $.ajax({
        type: "POST",
        url: "/administrator/WebMethods.aspx/GetCategoriesFromKimtec",
        data: "",
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        success: function(msg){
            $('#ctl00_ContentPlaceHolder1_divPleaseWait').hide();
            $('#messageBox').show();
            $('#messageBoxText')[0].innerHTML = JSON.parse(msg.d);
        },
        error: function(jqXHR, textStatus, errorThrown){
            alert(jqXHR.responseText);
            $('#ctl00_ContentPlaceHolder1_divPleaseWait').hide();
        }
    });
}

function btnMessageBoxClose_Click(){
    $('#messageBox').hide();
}