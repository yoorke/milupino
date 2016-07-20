$(document).ready(function(){
    $('#ctl00_ContentPlaceHolder1_txtEmail').focusout(CheckEmail);
    $('#ctl00_ContentPlaceHolder1_txtPassword').focusout(CheckPassword);
    $('#ctl00_ContentPlaceHolder1_txtConfirmPassword').focusout(CheckConfirmPassword);
})

function CheckEmail()
{
    var email = $('#ctl00_ContentPlaceHolder1_txtEmail').val();
    var exists;

    if (email != '') {
        $.ajax({
            type: "POST",
            url: "WebMethods.aspx/CheckEmail",
            data: JSON.stringify({ "email": email }),
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function (msg) {
                exists = JSON.parse(msg.d);
                if (exists == true){
                    $('#EmailStatus')[0].innerHTML = 'Email je već iskorišten za registraciju';
                    $('#divEmailStatus').show();
                }
                else if(exists == false && !isValidEmailAddress(email))
                {
                    $('#EmailStatus')[0].innerHTML = 'Email adresa nije u dobrom formatu';
                    $('#divEmailStatus').show();
                    
                }
                else
                {
                    $('#divEmailStatus').hide();
                }
                return exists;
            },
            error: function (jqXHR, textStatus, errorThrown) {

            }
        });
    }
}

function isValidEmailAddress(email) {
    var pattern = /^([a-z\d!#$%&'*+\-\/=?^_`{|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+(\.[a-z\d!#$%&'*+\-\/=?^_`{|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+)*|"((([ \t]*\r\n)?[ \t]+)?([\x01-\x08\x0b\x0c\x0e-\x1f\x7f\x21\x23-\x5b\x5d-\x7e\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|\\[\x01-\x09\x0b\x0c\x0d-\x7f\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))*(([ \t]*\r\n)?[ \t]+)?")@(([a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|[a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF][a-z\d\-._~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]*[a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])\.)+([a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|[a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF][a-z\d\-._~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]*[a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])\.?$/i;
    return pattern.test(email);
}

function CheckPassword() {
    var password = $('#ctl00_ContentPlaceHolder1_txtPassword').val();
    var confirmPassword = $('#ctl00_ContentPlaceHolder1_txtConfirmPassword').val();
    var isValid;

    if (password.length < 8 && password.length > 0) {
        $('#divPasswordStatus').show();
        $('#PasswordStatus')[0].innerHTML = 'Šifra mora da ima minimum 8 karaktera';
        isValid = false;
    }
    else {
        $('#divPasswordStatus').hide();
        isValid = true;
    }

    
    return isValid;
}

function CheckConfirmPassword() {
    var password = $('#ctl00_ContentPlaceHolder1_txtPassword').val();
    var confirmPassword = $('#ctl00_ContentPlaceHolder1_txtConfirmPassword').val();
    var isValid;

    if (password != confirmPassword) {
        $('#divConfirmPasswordStatus').show();
        $('#ConfirmPasswordStatus')[0].innerHTML = 'Šifra i ponovljena šifra nisu identične';
        isValid = false;
    }
    else {
        $('#divConfirmPasswordStatus').hide();
        isValid = true;
    }
    return isValid;
}

function Validate()
{
    var isValid = true;
    var exists;
    var email = $('#ctl00_ContentPlaceHolder1_txtEmail').val();

    isValid = ValidateDiv('ctl00_ContentPlaceHolder1_divRegistration');
    
    $.ajax({
        type:"POST",
        url: "WebMethods.aspx/CheckEmail",
        data: JSON.stringify({ "email": email }),
        contentType: "application/json;charset=utf-8",
        dataType: "json",
        async: false,
        success: function (msg) {
            exists = JSON.parse(msg.d);
            if (exists == true) {
                $('#EmailStatus')[0].innerHTML = 'Email je već iskorišten za registraciju';
                $('#divEmailStatus').show();
            }
            
        },
        error: function (jqXHR, textStatus, errorThrown) {

        }
    });

    

    isValid = isValid && !exists;
    isValid = isValid && CheckPassword();
    isValid = isValid && CheckConfirmPassword();

    return isValid;
}

function ValidateDiv(divName) {
    var status = true;
    var errorCss = { 'background-color': '#f5d3d3', 'border': '1px solid #ff0000' };
    var cleanCss = { 'background-color': '#ffffff', 'border': '1px solid #cccccc' };

    $('#' + divName + " :input").each(function () {
        if ($(this).is('input:text') || $(this).is('input:password')) {

            $(this).css(cleanCss);
            $(this).attr('title', '');

            var attr = $(this).attr('data-required');
            if (attr != undefined && attr == 'true') {
                var value = $(this).val();
                value = value.replace(',', '.');
                if ($(this).val() == '' || ($(this).attr('data-type') == 'numericUpDown' && !$.isNumeric(value)) || ($(this).attr('data-type') == 'numeric' && !$.isNumeric(value))) {
                    $(this).css(errorCss);
                    $(this).attr('title', 'Error');
                    status = status && false;
                }

            }
            var minValue = $(this).attr('data-minValue');
            if (minValue != undefined && minValue != 0) {
                if ($(this).val() < parseInt(minValue)) {
                    $(this).css(errorCss);
                    $(this).attr('title', 'Minimalna vrednost za ovo polje je: ' + minValue);
                    status = status && false;
                }
            }
        }
        else if ($(this).is('select')) {

            $(this).css(cleanCss);
            $(this).attr('title', '');

            var required = $(this).attr('data-required');
            if (required != undefined && required == 'true') {
                if ($(this).val() == -1) {
                    $(this).css(errorCss);
                    $(this).attr('title', 'Morate odabrati');
                    status = status && false;
                }
            }
        }
        else if ($(this).is('textarea')) {
            $(this).css(cleanCss);
            $(this).attr('title', '');

            var required = $(this).attr('data-required');
            if (required != undefined && required == 'true') {
                if ($(this).val() == '') {
                    $(this).css(errorCss);
                    status = status && false;
                }
            }
        }
    });

    return status;
}