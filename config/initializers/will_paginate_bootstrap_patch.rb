# will_paginate-bootstrap 1.0.2 usa un método interno llamado `tag` que
# colisiona con el helper `tag` de Rails 7 (que ahora es un TagBuilder).
# Este patch renombra el método interno para evitar el conflicto.

Rails.application.config.after_initialize do
  if defined?(BootstrapPagination::BootstrapRenderer)
    BootstrapPagination::BootstrapRenderer.module_eval do

      def to_html
        list_items = pagination.map do |item|
          case item
          when Integer
            page_number(item)
          else
            send(item)
          end
        end.join(@options[:link_separator])
        html_tag("ul", list_items, class: ul_class)
      end

      protected

      def page_number(page)
        link_options = @options[:link_options] || {}
        if page == current_page
          html_tag("li", html_tag("span", page), class: "active")
        else
          html_tag("li", link(page, page, link_options.merge(rel: rel_value(page))))
        end
      end

      def previous_or_next_page(page, text, classname)
        link_options = @options[:link_options] || {}
        if page
          html_tag("li", link(text, page, link_options), class: classname)
        else
          html_tag("li", html_tag("span", text), class: "%s disabled" % classname)
        end
      end

      def gap
        html_tag("li", html_tag("span", BootstrapPagination::BootstrapRenderer::ELLIPSIS), class: "disabled")
      end

      def html_tag(name, value, attributes = {})
        string_attributes = attributes.inject('') do |memo, (k, v)|
          memo + %( #{k}="#{v}")
        end
        "<#{name}#{string_attributes}>#{value}</#{name}>".html_safe
      end
    end
  end
end
