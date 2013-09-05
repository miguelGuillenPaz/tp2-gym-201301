$(function () {
    
    dialog = function (obj) {
        var title = '';
        title = $(obj).attr("title");
        if (title == undefined) title = '';
        
        var modal = $(obj).attr("modal") || 'true';
        modal = (modal == 'true') ? true : false;
        
        var resizable = $(obj).attr("resizable") || 'false';
        resizable = (resizable == 'true') ? true : false;
        
        var width = 'auto';
        if ($(obj).attr("width") != undefined) width = $(obj).attr("width");
        $(obj).kendoWindow({
            visible: false,
            modal: modal,
            draggable: true,
            minHeight: '50px',
            title: title,
            width: width,
            height:'auto',
            resizable: resizable,
            open: function () {
                $(obj).data("kendoWindow").center();
                if ($(obj).hasClass("notitle")) $(obj).parent().find(".k-window-titlebar").hide();

                $(obj).find(".firstelement").focus();
                $(obj).trigger("open");
            },
            close: function () {
                if ($(obj).find("form").length > 0) {
                    $(".formError").remove();
                }
                $(obj).trigger("close");
            }
        });
    };

    dialogBox = function (obj) {
        var title = '';
        title = $(obj).attr("title");
        if (title == undefined) title = '';
        var resizable = $(obj).attr("resizable") || 'false';
        resizable = (resizable == 'true') ? true : false;
        var width = 'auto';
        if ($(obj).attr("width") != undefined) width = $(obj).attr("width");
        $(obj).kendoWindow({
            visible: false,
            modal: 'modal',
            draggable: true,
            minHeight: '50px',
            title: title,
            width: width,
            height:'auto',
            resizable: resizable,
            buttons: {
                "OK": function () {
                    $(obj).dialog("close");
                    //if ( typeof(fafter) == 'function' ) fafter(true);
                }
            },
            open: function () {
                $(obj).data("kendoWindow").center();
                if ($(obj).hasClass("notitle")) $(obj).parent().find(".k-window-titlebar").hide();

                $(obj).find(".firstelement").focus();
                $(obj).trigger("open");
            },
            close: function () {$(obj).trigger("close");}
        });
    };

    msgBox = function (text, title, fafter) {
        $("div.msgbox").each(function () {
            $(this).remove();
        });

        var div = document.createElement('div');
        $(div).addClass("msgbox dialog");
        $(div).css("padding", "20px");        
        $(div).css("text-align", "justify");
        $(div).css("text-indent", "0px");

        $(div).html(text);
        $("body").append(div);
        $(div).dialog({
            autoOpen: true,
            modal: true,
            title: title,
            position: 'center',
            overlay: {
                opacity: 1,
                background: 'black'
            },
            buttons: {
                "OK": function () {
                    $(this).dialog("close");
                    if (typeof (fafter) == 'function') fafter(true);
                }
            },
            close: function (event, ui) {
                $(this).remove();
                if (typeof (fafter) == 'function') fafter(false);
            },
            open: function (event, ui) {                
                $(div).parent().find('.ui-dialog-buttonpane').find('button').addClass('btn');
                $(div).parent().find(".ui-dialog-titlebar").find('button').attr('class', 'ui-button ui-widget ui-state-default ui-corner-all ui-button-icon-only ui-dialog-titlebar-close');
                $(div).parent().find(".ui-dialog-titlebar").find('button').html(
                    '<span class="ui-button-icon-primary ui-icon ui-icon-closethick"></span>' +
                    '<span class="ui-button-text">close</span>'
                );
                if (title == undefined || title == '') {
                    $(div).parent().find(".ui-dialog-titlebar").hide();
                }
                $(div).parent().find("button.btn").focus();
            }
        });
    };

    confirmBox = function (text, title, fn) {
        if (typeof (fn) != 'function') fn = function (r) { };
        $("div.confirmBox").remove();
        var div = document.createElement('div');
        $(div).addClass("confirmBox dialog");
        $(div).css("padding", "15px");
        $(div).css("padding-left", "20px");
        $(div).css("padding-top", "20px");
        $(div).css("text-align", "justify");
        $(div).css("text-indent", "0px");
        $(div).html(text);
        $("body").append(div);
        $(div).dialog({
            autoOpen: true,
            modal: true,
            title: title,
            overlay: {
                opacity: 1,
                background: 'black'
            },
            buttons: {
                "SI": function () {
                    $(this).remove();
                    fn(true);
                },
                "NO": function () {
                    $(this).remove();
                    fn(false);
                }
            },
            close: function (event, ui) {
                fn(null);
                $(this).remove();
            },
            open: function (event, ui) {
                $(div).parent().find('.ui-dialog-buttonpane').find('button').addClass('btn');
                $(div).parent().find(".ui-dialog-titlebar").find('button').attr('class', 'ui-button ui-widget ui-state-default ui-corner-all ui-button-icon-only ui-dialog-titlebar-close');
                $(div).parent().find(".ui-dialog-titlebar").find('button').html(
                    '<span class="ui-button-icon-primary ui-icon ui-icon-closethick"></span>' +
                    '<span class="ui-button-text">close</span>'
                );
                if (title == undefined || title == '') {
                    $(div).parent().find(".ui-dialog-titlebar").hide();
                }
                $(div).parent().find("button.btn").focus();
            }

        });
    };

    $("div.dialogBox").each(function () {
        dialogBox(this);
    });

    $("div.dialog").each(function () {        
        dialog(this);
    });
});