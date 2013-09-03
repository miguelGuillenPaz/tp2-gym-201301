<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

<script type="text/javascript">

    function completeArchivoCotizacion() {
        if ($(document).find("#ArchivoCotizacion").contents().find('pre')[0] == undefined) return false;

        $('#adjuntarArchivo').find('div.loading').hide();
        $('#adjuntarArchivo').find("input[name=submit]").show();

        var response = $.parseJSON($(document).find("#ArchivoCotizacion").contents().find('pre')[0].innerHTML);
        msgBox(response.mensaje, "Información del Sistema");
        if (!response.error) {
            $('#adjuntarArchivo').data("kendoWindow").close();

            $('#agregarCotizacion').find('a.archivoAdjunto').attr('href', response.path);
            $('#agregarCotizacion').find('a.archivoAdjunto').show();
        } else {
        
        }
    }

    $(document).ready(function () {

        //$('#adjuntarArchivo').find("#files").kendoUpload();

        $('#adjuntarArchivo').find("form").submit(function (event) {
            var filename = $('#adjuntarArchivo').find('#file').val();
            var extension = filename.split('.')[1];
            if (extension != 'pdf') {
                msgBox("Debe ingresar un archivo en formato pdf.", "Información del Sistema");
                return false;
            }

            $('#adjuntarArchivo').find('div.loading').show();
            $('#adjuntarArchivo').find("input[name=submit]").hide();

            $('#adjuntarArchivo').find('#file').val('');
            $('#adjuntarArchivo').find('div.loading').hide();
            $('#adjuntarArchivo').find("input[name=submit]").show();

            msgBox("El archivo fue adjuntado correctamente.", "Información del Sistema");

            $('#adjuntarArchivo').data("kendoWindow").close();
        });

    });

</script>

<div id="adjuntarArchivo" style="display:none;" class="dialog" title="Adjuntar Archivo">
    <div style="padding:6px;" class="">
        <div>
            <form method="post" action="<%: Url.Action("SubirArchivo", "Cotizacion") %>" enctype="multipart/form-data" target="ArchivoCotizacion">
                <div class="demo-section">
                    <input name="file" id="file" type="file" accept="application/pdf" />
                    <p style="margin-top:10px;">
                        <input type="submit" value="Subir Archivo" title="Subir documento pdf de la cotización" name="submit" />
                        <input type="hidden", name="codSolCotizacion" value="0" />
                        <input type="hidden" name="codCotizacion" value="0" />
                    </p>
                </div>
            </form>
            <iframe id="ArchivoCotizacion" src="" name="ArchivoCotizacion" onload="completeArchivoCotizacion()" style="display:none;"></iframe>
        </div>
        <div class="loading" align="center" style="display:none;">
            <div style="display:inline-block; vertical-align:middle;">Adjuntando archivo&nbsp;</div>
            <div style="display:inline-block; vertical-align:middle;"><img alt="" src="../../Img/loading.gif" /></div>
        </div>
    </div>
</div>