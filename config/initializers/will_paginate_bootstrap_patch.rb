# Patch para will_paginate-bootstrap 1.0.2 con will_paginate 3.2+
# La firma de prepare cambió de (collection, options, template) a (collection, options)

ActiveSupport.on_load(:action_view) do
  require 'will_paginate/action_view'

  module BootstrapPagination
    class Rails < WillPaginate::ActionView::LinkRenderer
      def prepare(collection, options)
        super
      end

      protected

      def html_container(html)
        tag(:nav, tag(:ul, html, class: ul_class), aria: { label: 'Page navigation' })
      end

      def ul_class
        ['pagination', container_attributes[:class]].compact.join(' ')
      end

      def page_number(page)
        if page == current_page
          tag(:li, tag(:a, page, href: '#'), class: 'active')
        else
          tag(:li, link(page, page, rel: rel_value(page)))
        end
      end

      def previous_or_next_page(page, text, classname)
        if page
          tag(:li, link(text, page), class: classname)
        else
          tag(:li, tag(:a, text, href: '#'), class: "#{classname} disabled")
        end
      end

      def gap
        tag(:li, tag(:a, '&hellip;'.html_safe, href: '#'), class: 'disabled')
      end

      def tag(name, value, attributes = {})
        string_attributes = attributes.inject('') do |memo, (k, v)|
          if v.is_a?(Hash)
            v.each { |vk, vv| memo += %( #{k}-#{vk}="#{vv}") }
          else
            memo += %( #{k}="#{v}")
          end
          memo
        end
        "<#{name}#{string_attributes}>#{value}</#{name}>".html_safe
      end
    end
  end
end
