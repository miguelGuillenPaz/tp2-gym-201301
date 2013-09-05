// Global Var, it will access as cache
cache = new Array();
if ( typeof(translateString) == "undefined" ) translateString = {};
translateString.PLEASEWAIT = "Espere un momento ...";

function getData(params, fsuccess, ferror){ 
    /*var dlgWait = document.createElement("div");
    
    $(dlgWait).addClass("dialog")
              .append('<p style="width: 300px;">'+translateString.PLEASEWAIT+'</p>')
              .attr("id","dlgWait");
    $("div#dlgWait").remove();
    $(document).append(dlgWait);
    dialog(dlgWait);*/
    
    var url;
    var defaults = {
		url: params.url || null,
		data: params.data || {ajax:'ajax'},
		dataType: params.dataType || 'json', // text json
		type: params.type || 'post',
		beforeSend: function(xhr,set){
                    if ( params.cache != "true" ) return true;
                    url = murmurhash3_32_gc(set.url,0);
                    if ( cache[url] != undefined ){
                        defaults.success( cache[url] );
                        return false;
                    }else{
                        return true;
                    }	
		},
                dataFilter: function(data, type){
                    if ( type == 'json'){
                        var str = data;
                        str=str.replace(/\\'/g,'\'');
                        str=str.replace(/\\"/g,'"');    
                        str=str.replace(/\\0/g,'\0');
                      //  str=str.replace(/\\\\/g,'\\');
                        return str;
                    }
                    return data;

                },
		success: function(response){
                    if ( typeof(response) == 'string' && defaults.dataType == 'json' ){

                    }
                    
                    if (params.noWaitDialog == undefined || !params.noWaitDialog){                        
                        //$("div#dlgWait").data("kendoWindow").close();
                    }

                    if ( response.code == 'ERROR') {
                        if ( typeof(ferror) == 'function' ){
                                eval('ferror(response)');
                                return false;
                        }
                        var msg = $("div#"+response.message+".dialog"); 
                        if ( $(msg).length > 0 ) {
                            //$(msg).data("kendoWindow").open();
                        }
                    }else{ // Llamamos a la funcion correcta
                        if ( params.cache == "true" ) cache[url] = response;
                        if ( typeof(fsuccess) == 'function' ){
                                eval('fsuccess(response.response)');
                        }
                    }

                    if ( defaults.dataType == 'html' ){ 
                        if ( typeof(fsuccess) == 'function' ){
                            if ( params.cache == "true" )  cache[url] = response;
                            eval('fsuccess(response)');
                        }
                    }
		},
		error: function(jqXHR, textStatus, errorThrown){
                    debug("ERROR GEDATA AJAX",jqXHR, textStatus, errorThrown);
                    var r = jqXHR.responseText;
                    var o = eval('('+r+')');
                    eval('fsuccess(o.response)');
                    //$(dlgWait).data("kendoWindow").close();
		}
	};
	
	if (params.noWaitDialog == undefined || !params.noWaitDialog){
            //$(dlgWait).data("kendoWindow").open();
            //$(dlgWait).parent().find(".ui-dialog-titlebar").hide();
	}
	$.ajax(defaults);
}