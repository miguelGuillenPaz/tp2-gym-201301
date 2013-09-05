/*=========================== FUNCIONES ================================*/

function obtenerDias(fechaInicio, fechaFin) {
    var date1 = new Date(fechaInicio);
    var date2 = new Date(fechaFin);
    var dias = Math.floor((date2.getTime() - date1.getTime()) / (1000 * 60 * 60 * 24));
    return dias;
}

function formtoEntity(form) {
    var obj = {};
    
    $(form).find('input[type=hidden], input[type=text], select').each(function(){
        var field = $(this).attr('name');
        eval("obj." + field + " = '" + $(this).val() + "'");
    });
    
    return obj;
}

function autocomplete(cadena, digitos){
    var nuevo = "";
    if(cadena.length()<digitos) {
        var resto = digitos - cadena.length();
        for(var i=0; i<resto; i++) { nuevo += "0"; }
        nuevo += cadena;
    } else {
        nuevo = cadena;
    }
    return nuevo;
}

$(document).ready(function () {
    
    $(".animate-normal").each(function () {
        var etiqueta = this;
        setTimeout(function(){
            $(etiqueta).animate({
                opacity: 0.0, marginTop: 0
            }, 2200 ).fadeOut(800);
        }, 5000);
    });
    
    $(".animate-effect").each(function () {
        var etiqueta = this;
        setTimeout(function(){
            $(etiqueta).animate({
                opacity: 0.0, marginTop: 0
            }, 2200 ).hide("slow");
        }, 5000);
    });
    
    /*=========================== VALIDACIONES =============================*/
    
    $('input.number').numeric({ negative: false }, function() { alert("No negative values"); this.value = ""; this.focus(); });
    $('input.digits').numeric({ decimal: false, negative: false }, function() { alert("Positive integers only"); this.value = ""; this.focus(); });
    
    /*============================ CONTROLES ================================*/
    
    $("input.numeric").each(function () {
        var inp = this;
        var decimals = 0;
        if ($(inp).attr('decimals') != undefined) decimals = parseFloat($(inp).attr('decimales'));
        
        var format = $(inp).attr('format');
        $(inp).kendoNumericTextBox({
            format: format,
            decimals: decimals
        });
    });
    
    $("select.dropDownList").kendoDropDownList();
    
    $("input.datepicker").each(function () {
        var inp = this;
        $(inp).mask("99/99/9999", {placeholder: " "});
        var dateformat = $(inp).attr("data-dateformat") || 'dd/MM/yyyy';
        $(inp).kendoDatePicker({
            format: dateformat
        });
    });

    $(document).on('click', 'div.select',function(e){
        var div_select = this;
        var div_drop = $(this).parent().find('div.dropdown');
        $("html").bind('click', function(e){
            $("div.dropdown").addClass('model');
            $(div_drop).addClass("model");
            $("html").unbind('click');
        });
        
        $("div.dropdown").addClass('model');
        if($(div_drop).hasClass("model")) {
            $(div_drop).toggleClass("model");
        } else {
            $(div_drop).addClass("model");
        }
    });
    
    $("div.dropdown").click(function(e){
        e.stopPropagation();
    });

    $("div.dropdown input").click(function(e){        
        //var radio = this;
        //var content = $(this).parents("div.dropdown").eq(0).prev(".select").find("span");
        //var title = $(this).next().html();
        //$(content).html(title);
    });

    $("input.timepicker").each(function () {
        var inp = this;
        $.mask.definitions['t']='[AP]';
        $.mask.definitions['x']='[012345]';

        $(inp).mask("99:x9 tM", {placeholder: " "});
        //$(inp).kendoTimePicker();
    });
    
    $(".check-nice").each(function () {
        var etiqueta = this;
        $(etiqueta).prettyCheckboxes({display: 'list'});
    });
    
});