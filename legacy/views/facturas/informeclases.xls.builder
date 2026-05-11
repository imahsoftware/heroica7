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
  
  xml.Worksheet 'ss:Name' => 'Relacion' do
    xml.Table do
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'FECHA INSCRIPCION', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'IDENTIFICACION', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'NOMBRE', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'APELLIDOS', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'CATEGORIA', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'FECHA REGISTRO CLASES', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'PRACTICAS', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'TEORICAS', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'TALLER', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'TOTAL', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'PLACA', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'INSTRUCTOR', 'ss:Type' => 'String' }
      end
      for personastramiteshora in @personastramiteshoras
          xml.Row do
            xml.Cell { xml.Data personastramiteshora.fch, 'ss:Type' => 'String' }
            xml.Cell { xml.Data personastramiteshora.identificacion,  'ss:Type' => 'Number' }
            xml.Cell { xml.Data personastramiteshora.nombre,  'ss:Type' => 'String' }
            xml.Cell { xml.Data personastramiteshora.apellido,  'ss:Type' => 'String' }
            xml.Cell { xml.Data personastramiteshora.cat,  'ss:Type' => 'String' }
            xml.Cell { xml.Data personastramiteshora.fecha,  'ss:Type' => 'String' }
            xml.Cell { xml.Data personastramiteshora.practicas,  'ss:Type' => 'Number' }
            xml.Cell { xml.Data personastramiteshora.teoricas,  'ss:Type' => 'Number' }
            xml.Cell { xml.Data personastramiteshora.taller,  'ss:Type' => 'Number' }
            xml.Cell { xml.Data personastramiteshora.total, 'ss:Type' => 'Number' }
            if personastramiteshora.placa_id
              @placa = Placa.find(personastramiteshora.placa_id)
              xml.Cell { xml.Data @placa.descripcion,  'ss:Type' => 'String' }
              if @placa.instructor_id
                xml.Cell { xml.Data @placa.instructor.nombre,  'ss:Type' => 'String' }
              else
                xml.Cell { xml.Data '',  'ss:Type' => 'String' }
              end
            else
              xml.Cell { xml.Data '',  'ss:Type' => 'String' }
              xml.Cell { xml.Data '',  'ss:Type' => 'String' }
            end
          end
      end
    end
  end

  xml.Worksheet 'ss:Name' => 'Consolidado' do
    xml.Table do
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'FECHA INSCRIPCION', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'IDENTIFICACION', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'NOMBRE', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'APELLIDOS', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'CATEGORIA', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'TOTAL PRACTICAS', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'TOTAL TEORICAS', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'TOTAL TALLER', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'PRACTICAS - CLASES FALTANTES', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'TEORICAS - CLASES FALTANTES', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'TALLER - CLASES FALTANTES', 'ss:Type' => 'String' }
      end
      for objeto in @objetos
        cant1 = 0
        cant2 = 0
        cant3 = 0
        xml.Row do
            xml.Cell { xml.Data objeto.fch, 'ss:Type' => 'String' }
            xml.Cell { xml.Data objeto.identificacion,  'ss:Type' => 'Number' }
            xml.Cell { xml.Data objeto.nombre,  'ss:Type' => 'String' }
            xml.Cell { xml.Data objeto.apellido,  'ss:Type' => 'String' }
            xml.Cell { xml.Data objeto.cat,  'ss:Type' => 'String' }
            xml.Cell { xml.Data objeto.pra,  'ss:Type' => 'Number' }
            xml.Cell { xml.Data objeto.teo,  'ss:Type' => 'Number' }
            xml.Cell { xml.Data objeto.tal,  'ss:Type' => 'Number' }
            @categoria = Categoria.find(objeto.categoria_id)
            cant1 = @categoria.practicas.to_i - objeto.pra.to_i
            cant2 = @categoria.teoricas.to_i - objeto.teo.to_i
            cant3 = @categoria.taller.to_i - objeto.tal.to_i
            xml.Cell { xml.Data cant1, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data cant2, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data cant3, 'ss:Type' => 'Number' }
        end
      end
    end
  end
end




