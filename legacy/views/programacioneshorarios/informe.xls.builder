xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
xml.Workbook({
  'xmlns'      => "urn:schemas-microsoft-com:office:spreadsheet",
  'xmlns:o'    => "urn:schemas-microsoft-com:office:office",
  'xmlns:x'    => "urn:schemas-microsoft-com:office:excel",
  'xmlns:html' => "http://www.w3.org/TR/REC-html40",
  'xmlns:ss'   => "urn:schemas-microsoft-com:office:spreadsheet"
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
          xml.Alignment 'ss:Vertical' => 'Bottom',
          'ss:Horizontal' => 'Center'
          xml.Font 'ss:FontName' => 'Arial','ss:Bold'=>'1'
          xml.Interior 'ss:Color'=>'#99CCFF', 'ss:Pattern'=>'Solid'
     end
     xml.Style 'ss:ID' => 's22' do
       xml.NumberFormat 'ss:Format' => 'General Date'
     end
  end


  xml.Worksheet 'ss:Name' => 'Clases' do
    xml.Table do
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'NRO CLASES', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'IDENTIFICACION', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'NOMBRE', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'HORARIO', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'PLACA', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'INSTRUCTOR', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'FECHA CLASE', 'ss:Type' => 'String' }
      end
      #@bancolombiastmprecaudos = Bancolombiastmprecaudos.find(:all)
      i = 0
      for personasclase in @personasclases
        i = i + 1
          xml.Row do
              xml.Cell { xml.Data i, 'ss:Type' => 'String' }
              xml.Cell { xml.Data personasclase.persona.identificacion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data personasclase.persona.nombres, 'ss:Type' => 'String' }
              xml.Cell { xml.Data personasclase.tiposhorario.descripcion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data personasclase.placa.descripcion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data personasclase.instructor.nombre, 'ss:Type' => 'String' }
              xml.Cell { xml.Data personasclase.fecha_clase, 'ss:Type' => 'String' }
          end
      end
    end
  end

  xml.Worksheet 'ss:Name' => 'Consolidado' do
    xml.Table do
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'IDENTIFICACION', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'NOMBRE', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'NRO CLASES', 'ss:Type' => 'String' }
      end
      nombre = ""
      ident = ""
      for objeto in @objetos
        if objeto.instructor_id
          ident = Instructor.find(objeto.instructor_id).identificacion rescue nil
          nombre = Instructor.find(objeto.instructor_id).nombre rescue nil
        end
        xml.Row do
            xml.Cell { xml.Data ident, 'ss:Type' => 'String' }
            xml.Cell { xml.Data nombre, 'ss:Type' => 'String' }
            xml.Cell { xml.Data objeto.cantidad, 'ss:Type' => 'String' }
        end
      end
    end
  end
end




