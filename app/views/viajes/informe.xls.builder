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

  xml.Worksheet 'ss:Name' => 'Helicopter Tour' do
    xml.Table do
      xml.Row 'ss:StyleID' => 'header' do
        xml.Cell { xml.Data 'Fecha', 'ss:Type' => 'String' }
        xml.Cell { xml.Data 'Identificacion', 'ss:Type' => 'String' }
        xml.Cell { xml.Data 'Nombre', 'ss:Type' => 'String' }
        xml.Cell { xml.Data 'Apellido', 'ss:Type' => 'String' }
        xml.Cell { xml.Data 'Tour', 'ss:Type' => 'String' }
        xml.Cell { xml.Data 'Consecutivo Nro', 'ss:Type' => 'String' }
        xml.Cell { xml.Data 'Estado', 'ss:Type' => 'String' }
        xml.Cell { xml.Data 'Valor', 'ss:Type' => 'String' }
      end
      @viajesrecibos.each do |viajesrecibo|
        xml.Row do
          xml.Cell { xml.Data viajesrecibo.created_at.strftime('%Y-%m-%d %H:%M:%S'), 'ss:Type' => 'String' }
          xml.Cell { xml.Data viajesrecibo.viaje.identificacion, 'ss:Type' => 'String' }
          xml.Cell { xml.Data viajesrecibo.viaje.nombre, 'ss:Type' => 'String' }
          xml.Cell { xml.Data viajesrecibo.viaje.apellido, 'ss:Type' => 'String' }
          xml.Cell { xml.Data viajesrecibo.viaje.tiposviaje.descripcion, 'ss:Type' => 'String' }
          xml.Cell { xml.Data viajesrecibo.nro_recibo, 'ss:Type' => 'Number' }
          if viajesrecibo.estado.to_s == '1'
            xml.Cell { xml.Data 'Anulada', 'ss:Type' => 'String' }
          else
            xml.Cell { xml.Data 'Cancelada', 'ss:Type' => 'String' }
          end
          xml.Cell { xml.Data viajesrecibo.valor, 'ss:Type' => 'Number' }
        end
      end
    end
  end
end
