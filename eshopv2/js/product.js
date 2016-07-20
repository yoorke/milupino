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
            if (msg.d == 'Not loggedin')
                window.location = '/prijava?returnUrl=' + window.location.pathname;
            else
            $('#wishListMessageBox').show();
        },
        error: function(jqXHR, textStatus, errorThrown){
            //alert(jqXHR.responseText);
            //if (JSON.parse(jqXHR.responseText).Message == 'Not loggedin')
                window.location = '/prijava?returnUrl=' + window.location.pathname;
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
        url: "/WebMethods.aspx/GetCompareProductList",
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
        url: "/WebMethods.aspx/DeleteFromProductCompare",
        data: JSON.stringify({"productID": $('#' + productID).val()}),
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        success: function(msg){
            GetCompareProductList(false);
        }
    })
}

function AddToCart(lblProductID) {
    var productID = parseInt($('#' + lblProductID).val());
    var priceString = $('#' + lblProductID.substring(0, lblProductID.indexOf('lblProductID')) + "lblWebPrice")[0].innerHTML;
    priceString = priceString.replace('.', '');
    priceString = priceString.replace(',', '.');
    priceString = priceString.indexOf(" din") > -1 ? priceString.substring(0, priceString.indexOf(" din")) : priceString;
    var price = parseFloat(priceString);

    $.ajax({
        type: "POST",
        url: "/WebMethods.aspx/AddToCart",
        data: JSON.stringify({ "productID": productID, "webPrice": price }),
        contentType: "application/json;charset=utf-8",
        datatype: "json",
        success: function (msg) {
            $('#cartMessageBox').show();
            var cart = JSON.parse(msg.d);
            $('#ctl00_lblProductCount')[0].innerHTML = cart[0];
            $('#ctl00_lblCartPrice')[0].innerHTML = cart[1];
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert(jqXHR.responseText);
        }
    })
}

function cartMessageBoxBtnClose_Click()
{
    $('#cartMessageBox').hide();
}

function cartMessageBoxBtnCart_Click()
{
    window.location = "/korpa";
}

function ShowHideButtons(divButtons, show) {
    if (show)
        $('#' + divButtons).show();
    else
        $('#' + divButtons).hide();
}