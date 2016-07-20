function AddToWishList()
{
    var productID = parseInt($('#ctl00_ContentPlaceHolder1_lblProductID').val());
    
    $.ajax({
        type: "POST",
        url: "/WebMethods.aspx/AddToWishList",
        data: JSON.stringify({"productID": productID}),
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        success: function(msg){
            //alert("Proizvod dodat u listu zelja");
            $('#wishListMessageBox').show();
        },
        error: function(jqXHR, textStatus, errorThrown){
            alert(jqXHR.responseText);
        }
    });
}

function AddToCompare(lblProducID)
{
    var productID = parseInt($('#' + lblProducID).val());
    
    $.ajax({
        type: "POST",
        url: "/WebMethods.aspx/AddToCompare",
        data: JSON.stringify({"productID": productID}),
        contentType: "application/json;charset=utf-8",
        dataType:"json",
        success: function(msg){
            $('#messageBoxCompareText')[0].innerHTML = 'Proizvoda: ' + JSON.parse(msg.d);
            $('#messageBoxCompare').show();
        },
        error: function(jqXHR, textStatus, errorThrown){
            alert(jqXHR.responseText);
        }
    })
}

function WishListMessageBoxOk_Click()
{
    $('#wishListMessageBox').hide();
}

function btnCompare_Click(lblProductID)
{
    //$('#messageBoxCompare').show();
    AddToCompare(lblProductID);
}

function messageBoxCompareBtnClose_Click()
{
    $('#messageBoxCompare').hide();
}

function messageBoxCompareBtnCompare_Click()
{
    GetCompareProductList(true);
    //var win = window.open(url, '_blank');
    //win.focus();
}

function GetCompareProductList(blank)
{
    $.ajax({
        type: "POST",
        url: "WebMethods.aspx/GetCompareProductList",
        data: "",
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        success: function(msg){
            GetComparePageUrl(JSON.parse(msg.d), blank);
        },
        error: function(jqXHR, textStatus, errorThrown){
            alert(jqXHR.responseText);
        }
    })
}

function lnkCompare_Click()
{
    var url = GetComparePageUrl();
    var win = window.open(url, '_blank');
    win.focus();
}

function GetComparePageUrl(productList, blank)
{
    var url = '/compare.aspx?productList=';
    $.each(productList, function(i, item){
        url += productList[i] + '-';
    })
    if(blank)
    var win = window.open(url.substring(0, url.length-1), '_blank');
    else
    var win = window.open(url.substring(0, url.length-1), '_self');
}

function btnProductCompareRemove_Click(productID)
{
    //alert(this);
    $.ajax({
        type: "POST",
        url: "WebMethods.aspx/DeleteFromProductCompare",
        data: JSON.stringify({"productID": $('#' + productID).val()}),
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        success: function(msg){
            GetCompareProductList(false);
        }
    })
}