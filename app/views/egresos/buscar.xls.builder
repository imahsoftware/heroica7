xml.instruct! :xml, version: '1.0', encoding: 'UTF-8'
xml.Workbook({
  'xmlns'      => 'urn:schemas-microsoft-com:office:spreadsheet',
  'xmlns:o'    => 'urn:schemas-microsoft-com:office:office',
  'xmlns:x'    => 'urn:schemas-microsoft-com:office:excel',
  'xmlns:html' => 'http://www.w3.org/TR/REC-html40',
  'xmlns:ss'   => 'urn:schemas-microsoft-com:office:spreadsheet'
}) do

  xml.Styles do
    xml.Style 'ss:ID' => 'Default', 'ss:Name' => 'Normal' do
      xml.Alignment 'ss:Vertical' => 'Bottom'
      xml.Borders
      xml.Font 'ss:FontName' => 'Verdana'
      xml.Interior
      xml.NumberFormat
      xml.Protection
    end
    xml.Style 'ss:ID' => 'header' do
      xml.Alignment 'ss:Vertical' => 'Bottom', 'ss:Horizontal' => 'Center'
      xml.Font 'ss:FontName' => 'Arial', 'ss:Bold' => '1'
      xml.Interior 'ss:Color' => '#99CCFF', 'ss:Pattern' => 'Solid'
    end
    xml.Style 'ss:ID' => 's22' do
      xml.NumberFormat 'ss:Format' => 'General Date'
    end
  end

  xml.Worksheet 'ss:Name' => 'Egresos' do
    xml.Table do
      xml.Row 'ss:StyleID' => 'header' do
        xml.Cell { xml.Data 'FECHA',                   'ss:Type' => 'String' }
        xml.Cell { xml.Data 'NRO EGRESO',              'ss:Type' => 'String' }
        xml.Cell { xml.Data 'TIPO DOCUMENTO',          'ss:Type' => 'String' }
        xml.Cell { xml.Data 'IDENTIFICACION',          'ss:Type' => 'String' }
        xml.Cell { xml.Data 'PRIMER NOMBRE',           'ss:Type' => 'String' }
        xml.Cell { xml.Data 'SEGUNDO NOMBRE',          'ss:Type' => 'String' }
        xml.Cell { xml.Data 'PRIMER APELLIDO',         'ss:Type' => 'String' }
        xml.Cell { xml.Data 'SEGUNDO APELLIDO',        'ss:Type' => 'String' }
        xml.Cell { xml.Data 'RAZON SOCIAL',            'ss:Type' => 'String' }
        xml.Cell { xml.Data 'DIRECCION',               'ss:Type' => 'String' }
        xml.Cell { xml.Data 'DEPARTAMENTO',            'ss:Type' => 'String' }
        xml.Cell { xml.Data 'MUNICIPIO',               'ss:Type' => 'String' }
        xml.Cell { xml.Data 'OBSERVACION / CONCEPTO',  'ss:Type' => 'String' }
        xml.Cell { xml.Data 'FORMA DE PAGO',           'ss:Type' => 'String' }
        xml.Cell { xml.Data 'VALOR BRUTO',             'ss:Type' => 'String' }
        xml.Cell { xml.Data 'VALOR IVA',               'ss:Type' => 'String' }
        xml.Cell { xml.Data 'VALOR',                   'ss:Type' => 'String' }
      end

      @egresos.each do |egreso|
        doc   = egreso.proveedor&.documento
        a     = egreso.proveedor&.identificacion
        a1    = egreso.proveedor&.primer_nombre
        a2    = egreso.proveedor&.segundo_nombre
        a3    = egreso.proveedor&.primer_apellido
        a4    = egreso.proveedor&.segundo_apellido
        b     = egreso.proveedor&.razon_social
        c     = egreso.proveedor&.direccion
        d     = egreso.proveedor&.departamento
        e     = egreso.proveedor&.ciudad

        xml.Row do
          xml.Cell { xml.Data egreso.fecha.to_s,       'ss:Type' => 'String' }
          xml.Cell { xml.Data egreso.nro_egreso.to_s,  'ss:Type' => 'String' }
          xml.Cell { xml.Data doc.to_s,                'ss:Type' => 'String' }
          xml.Cell { xml.Data a.to_s,                  'ss:Type' => 'String' }
          xml.Cell { xml.Data a1.to_s,                 'ss:Type' => 'String' }
          xml.Cell { xml.Data a2.to_s,                 'ss:Type' => 'String' }
          xml.Cell { xml.Data a3.to_s,                 'ss:Type' => 'String' }
          xml.Cell { xml.Data a4.to_s,                 'ss:Type' => 'String' }
          xml.Cell { xml.Data b.to_s,                  'ss:Type' => 'String' }
          xml.Cell { xml.Data c.to_s,                  'ss:Type' => 'String' }
          xml.Cell { xml.Data d.to_s,                  'ss:Type' => 'String' }
          xml.Cell { xml.Data e.to_s,                  'ss:Type' => 'String' }
          xml.Cell { xml.Data egreso.observacion.to_s, 'ss:Type' => 'String' }
          xml.Cell { xml.Data egreso.forma_pago.to_s,  'ss:Type' => 'String' }
          xml.Cell { xml.Data egreso.valor_bruto.to_s, 'ss:Type' => 'String' }
          xml.Cell { xml.Data egreso.valor_iva.to_s,   'ss:Type' => 'String' }
          xml.Cell { xml.Data egreso.valor.to_s,       'ss:Type' => 'String' }
        end
      end
    end
  end
end
