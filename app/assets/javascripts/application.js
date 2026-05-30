//= require jquery
//= require bootstrap-sprockets
//= require jquery.remotipart
//= require jquery_ujs
//= require jquery-ui/widgets/datepicker
//= require jquery-ui/widgets/autocomplete
//= require autocomplete-rails
//= require autonumeric
//= require moment
//= require moment/es
//= require bootstrap-datetimepicker
//= require pickers
//= require highcharts
//= require simple_form_autocomplete
//= require highcharts/highcharts-more
//= require highcharts/highcharts-3d.js
//= require highcharts/modules/annotations
//= require highcharts/modules/data
//= require highcharts/modules/drilldown
//= require highcharts/modules/exporting
//= require highcharts/modules/funnel
//= require highcharts/modules/heatmap
//= require highcharts/modules/no-data-to-display
//= require highcharts/modules/offline-exporting
//= require Chart.min
//= require bootstrap-wysihtml5
//= require underscore
//= require gmaps/google
//= require dist/js/app.min
//= require plugins/select2/select2.full.min
//= require plugins/iCheck/icheck.min
//= require jquery.turbolinks
//= require font_awesome5
//= require_tree .

$(document).on("turbolinks:load", function() {
  $(".select2").select2();
  $('.datepicker').datepicker({
    dayNamesMin: [ "Dom", "Lun", "Mar", "Mie", "Jue", "Vie", "Sáb" ],
    monthNamesShort: [ "Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic" ],
    dateFormat: "yy-mm-dd",
    yearRange: '1950:2026',
    changeMonth: true,
    changeYear: true,
  });
  $('.wysihtml5').wysihtml5();
  $('[data-toggle="popover"]').popover();

  // Popup links (legacy :popup behavior)
  $(document).off('click.popupLink').on('click.popupLink', 'a[data-popup="true"]', function(e) {
    e.preventDefault();
    var $a = $(this);
    var url = $a.attr('href');
    if (!url) { return; }

    var name = ($a.data('popupName') || 'new_window');
    var w = parseInt($a.data('popupWidth') || 950, 10);
    var h = parseInt($a.data('popupHeight') || 700, 10);
    var scrollbars = ($a.data('popupScrollbars') || 'yes');

    var left = Math.max(0, (screen.width  - w) / 2);
    var top  = Math.max(0, (screen.height - h) / 2);
    // Note: modern browsers may ignore some features
    var features = 'width=' + w +
                   ',height=' + h +
                   ',left=' + left +
                   ',top=' + top +
                   ',scrollbars=' + scrollbars +
                   ',resizable=yes' +
                   ',toolbar=no,menubar=no,location=no,status=no';
    var win = window.open(url, name, features);
    if (win && win.focus) { win.focus(); }
  });

  // Botones Cancelar: ocultan el contenedor indicado en data-target
  $(document).on('click', '.cancel_button', function(e) {
    e.preventDefault();
    e.stopPropagation();
    var target = $(this).attr('data-target');
    if (target) {
      $(target).html('').removeClass('in').css({ height: '0px', overflow: 'hidden' });
    }
  });
});


$("a[data-popover-title]").each( function(e,elem) {
    var _this = this;
    $(this).popover({
        title: $(this).data('popover-title'),
        content: $(this).data('popover-content'),
        trigger: "manual",
        animation: false
    }).on("mouseenter", function () {
        $(_this).popover("show");
    }).parent().on("mouseleave", function() {
        $(_this).popover("hide");
    })
});

$(function() {
    $('.datepicker').datepicker({
        dayNamesMin: [ "Dom", "Lun", "Mar", "Mie", "Jue", "Vie", "Sáb" ],
        monthNamesShort: [ "Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic" ],
        dateFormat: "yy-mm-dd",
        yearRange: '1950:2026',
        changeMonth: true,
        changeYear: true,
    });

    $("#idforminit").submit(function() {
        $("#user_username").val();
        $("#user_password").val();
    });
});

function SINO(cual) {
    var elElemento=document.getElementById(cual);
    if(elElemento.style.display == 'block') {
        elElemento.style.display = 'none';
    } else {
        elElemento.style.display = 'block';
    }
}

function soloNumeros(e) {
    var key = window.Event ? e.which : e.keyCode
    return (key >= 48 && key <= 57)
}

function mostrar(selc) {
    if (selc.value=="per") {
        document.getElementById('persona').style.display='block'
        document.getElementById('nuevo').style.display='none'
    } else {
        document.getElementById('persona').style.display='none'
        document.getElementById('nuevo').style.display='block'
    }
}

function countChar(val) {
    var len = val.value.length;
    if (len >= 4000) {
        val.value = val.value.substring(0, 4000);
    } else {
        $('#charNum').text(4000 - len);
    }
};


$(function() {
    return $('.select2Ciudad').select2({
        minimumInputLength: 3,
        maximumInputLength: 20,
        placeholder: "[ Seleccionar Ciudad... ]",
        ajax: {
            url: '/municipios/search.json',
            dataType: 'json',
            delay: 250,
            data: function(params) {
                return {
                    q: params.term,
                    page: params.page
                };
            },
            processResults: function(data) {
                return {
                    results: $.map(data, function(item) {
                        return {
                            text: item.name,
                            id: item.id
                        };
                    })
                };
            }
        }
    });
});


$(function() {
    return $('.select2Lugar').select2({
        minimumInputLength: 3,
        maximumInputLength: 20,
        placeholder: "[ Seleccionar Ciudad... ]",
        ajax: {
            url: '/lugares/search.json',
            dataType: 'json',
            delay: 250,
            data: function(params) {
                return {
                    q: params.term,
                    page: params.page
                };
            },
            processResults: function(data) {
                return {
                    results: $.map(data, function(item) {
                        return {
                            text: item.name,
                            id: item.name
                        };
                    })
                };
            }
        }
    });
});

$(function() {
    return $('.selec2Persona').select2({
        minimumInputLength: 3,
        maximumInputLength: 20,
        placeholder: "[ Buscar......]",
        ajax: {
            url: '/personas/searchall.json',
            dataType: 'json',
            delay: 250,
            data: function(params) {
                return {
                    q: params.term,
                    page: params.page
                };
            },
            processResults: function(data) {
                return {
                    results: $.map(data, function(item) {
                        return {
                            text: item.name,
                            id: item.id
                        };
                    })
                };
            }
        }
    });
});

$('#nombre').bind('railsAutocomplete.select', function (event, data) {
    $('#search-form').submit()
});

function generardatos(ident1,transaccion,ruta){
    //alert("Identificacion a generar ..."+ident1+" ---");
    //alert("Transaccion ..."+transaccion);
    //alert("Ruta ..."+ruta);
    var identificacion = ident1;
    if (transaccion == "firma") {
        try{
            var myobject;
            var rstFirma;
            myobject = new ActiveXObject("CRCSoftX.Facade");
            rstFirma = myobject.tomarFirma(ruta, identificacion, "jpg")
            if (rstFirma == true) {
                alert("Firma capturada con exito")
            }else{
                alert("Firma Cancelado - Invalido");
            }
        } catch(e) {
            alert(e.message);
        }
    }
    if (transaccion == "foto") {
        try{
            var myobject;
            var rstFoto;
            myobject = new ActiveXObject("CRCSoftX.Facade");
            rstFoto  = myobject.tomarFoto(ruta, identificacion, "jpg", "S")
            if (rstFoto == true) {
                alert("Foto capturada con exito")
                //Aqui el sistema deberia refresh para ver lo que capturo
            }else{
                alert("Foto Cancelado - Invalido");
            }
        } catch(e) {
            alert(e.message);
        }
    }
    if (transaccion == "huella") {
        try{
            var myobject;
            var rstHuella;
            myobject = new ActiveXObject("CRCSoftX.Facade");
            rstHuella  = myobject.enrolar(ruta, identificacion+"_I", identificacion+"_D", "jpg")
            if (rstHuella == true) {
                alert("Huella capturada con exito")
            }else{
                alert("Huella Cancelado - Invalido");
            }
        } catch(e) {
            alert(e.message);
        }
    }
}

$(document).ready(function() {
    $('#documento_input').on('keydown', function(event) {
        // Permitir: backspace, delete, tab, escape, enter, '.', '0'-'9'
        if ($.inArray(event.keyCode, [46, 8, 9, 27, 13, 110, 190, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57]) !== -1 ||
            // Permitir: Ctrl+A, Ctrl+C, Ctrl+V, Command+A
            (event.keyCode == 65 && (event.ctrlKey === true || event.metaKey === true)) ||
            (event.keyCode == 67 && (event.ctrlKey === true || event.metaKey === true)) ||
            (event.keyCode == 86 && (event.ctrlKey === true || event.metaKey === true)) ||
            (event.keyCode == 88 && (event.ctrlKey === true || event.metaKey === true)) ||
            (event.keyCode >= 35 && event.keyCode <= 40)) {
            // Dejar que suceda, no hacer nada especial
            return;
        } else {
            // Prevenir la pulsación de tecla por defecto
            event.preventDefault();
        }
    });
});