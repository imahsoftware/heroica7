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

  xml.Worksheet 'ss:Name' => 'Relacion' do
    xml.Table do
      xml.Row 'ss:StyleID' => 'header' do
        xml.Cell { xml.Data 'FECHA INSCRIPCION',       'ss:Type' => 'String' }
        xml.Cell { xml.Data 'IDENTIFICACION',          'ss:Type' => 'String' }
        xml.Cell { xml.Data 'NOMBRE',                  'ss:Type' => 'String' }
        xml.Cell { xml.Data 'APELLIDOS',               'ss:Type' => 'String' }
        xml.Cell { xml.Data 'CATEGORIA',               'ss:Type' => 'String' }
        xml.Cell { xml.Data 'FECHA REGISTRO CLASES',   'ss:Type' => 'String' }
        xml.Cell { xml.Data 'PRACTICAS',               'ss:Type' => 'String' }
        xml.Cell { xml.Data 'TEORICAS',                'ss:Type' => 'String' }
        xml.Cell { xml.Data 'TALLER',                  'ss:Type' => 'String' }
        xml.Cell { xml.Data 'TOTAL',                   'ss:Type' => 'String' }
        xml.Cell { xml.Data 'PLACA',                   'ss:Type' => 'String' }
        xml.Cell { xml.Data 'INSTRUCTOR',              'ss:Type' => 'String' }
      end
      for pth in @personastramiteshoras
        xml.Row do
          xml.Cell { xml.Data pth.fch.to_s,            'ss:Type' => 'String' }
          xml.Cell { xml.Data pth.identificacion.to_i, 'ss:Type' => 'Number' }
          xml.Cell { xml.Data pth.nombre.to_s,         'ss:Type' => 'String' }
          xml.Cell { xml.Data pth.apellido.to_s,       'ss:Type' => 'String' }
          xml.Cell { xml.Data pth.cat.to_s,            'ss:Type' => 'String' }
          xml.Cell { xml.Data pth.fecha.to_s,          'ss:Type' => 'String' }
          xml.Cell { xml.Data pth.practicas.to_i,      'ss:Type' => 'Number' }
          xml.Cell { xml.Data pth.teoricas.to_i,       'ss:Type' => 'Number' }
          xml.Cell { xml.Data pth.taller.to_i,         'ss:Type' => 'Number' }
          xml.Cell { xml.Data pth.total.to_i,          'ss:Type' => 'Number' }
          placa = pth.placa_id ? (Placa.find(pth.placa_id) rescue nil) : nil
          xml.Cell { xml.Data placa ? placa.descripcion.to_s : '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data placa ? placa.instructor&.nombre.to_s : '', 'ss:Type' => 'String' }
        end
      end
    end
  end

  xml.Worksheet 'ss:Name' => 'Consolidado' do
    xml.Table do
      xml.Row 'ss:StyleID' => 'header' do
        xml.Cell { xml.Data 'FECHA INSCRIPCION',                'ss:Type' => 'String' }
        xml.Cell { xml.Data 'IDENTIFICACION',                   'ss:Type' => 'String' }
        xml.Cell { xml.Data 'NOMBRE',                           'ss:Type' => 'String' }
        xml.Cell { xml.Data 'APELLIDOS',                        'ss:Type' => 'String' }
        xml.Cell { xml.Data 'CATEGORIA',                        'ss:Type' => 'String' }
        xml.Cell { xml.Data 'TOTAL PRACTICAS',                  'ss:Type' => 'String' }
        xml.Cell { xml.Data 'TOTAL TEORICAS',                   'ss:Type' => 'String' }
        xml.Cell { xml.Data 'TOTAL TALLER',                     'ss:Type' => 'String' }
        xml.Cell { xml.Data 'PRACTICAS - CLASES FALTANTES',     'ss:Type' => 'String' }
        xml.Cell { xml.Data 'TEORICAS - CLASES FALTANTES',      'ss:Type' => 'String' }
        xml.Cell { xml.Data 'TALLER - CLASES FALTANTES',        'ss:Type' => 'String' }
      end
      for objeto in @objetos
        categoria = Categoria.find(objeto.categoria_id) rescue nil
        cant1 = categoria ? categoria.practicas.to_i - objeto.pra.to_i : 0
        cant2 = categoria ? categoria.teoricas.to_i  - objeto.teo.to_i : 0
        cant3 = categoria ? categoria.taller.to_i    - objeto.tal.to_i : 0
        xml.Row do
          xml.Cell { xml.Data objeto.fch.to_s,          'ss:Type' => 'String' }
          xml.Cell { xml.Data objeto.identificacion.to_i,'ss:Type' => 'Number' }
          xml.Cell { xml.Data objeto.nombre.to_s,        'ss:Type' => 'String' }
          xml.Cell { xml.Data objeto.apellido.to_s,      'ss:Type' => 'String' }
          xml.Cell { xml.Data objeto.cat.to_s,           'ss:Type' => 'String' }
          xml.Cell { xml.Data objeto.pra.to_i,           'ss:Type' => 'Number' }
          xml.Cell { xml.Data objeto.teo.to_i,           'ss:Type' => 'Number' }
          xml.Cell { xml.Data objeto.tal.to_i,           'ss:Type' => 'Number' }
          xml.Cell { xml.Data cant1,                     'ss:Type' => 'Number' }
          xml.Cell { xml.Data cant2,                     'ss:Type' => 'Number' }
          xml.Cell { xml.Data cant3,                     'ss:Type' => 'Number' }
        end
      end
    end
  end
end
