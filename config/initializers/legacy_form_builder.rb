# frozen_string_literal: true

# Restaura f.error_message_on de Rails 2 en todos los form_for
Rails.application.config.to_prepare do
  ActionView::Helpers::FormBuilder.class_eval do
    unless method_defined?(:error_message_on)
      def error_message_on(method, options = {})
        return ''.html_safe if @object.blank? || !@object.errors[method].any?

        @template.content_tag(:span, @object.errors[method].first, class: options[:css_class])
      end
    end
  end
end
