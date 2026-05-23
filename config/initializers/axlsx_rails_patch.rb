# axlsx_rails 0.5.x is incompatible with Rails 7 because ActionView changed
# the template handler call signature from call(template) to call(template, source).
#
# This patch does NOT rely on AxlsxRails::TemplateHandler being defined.
# Instead it re-registers the :axlsx handler directly on ActionView::Template
# with a Rails 7-compatible call(template, source) signature.
#
# config.to_prepare runs after ALL Railties/engines have initialized, so our
# registration overwrites whatever axlsx_rails registered with the old signature.
Rails.application.config.to_prepare do
  rails7_axlsx_handler = Class.new do
    def call(template, source = nil)
      source ||= template.source
      "wb = xlsx_package = Axlsx::Package.new\n" \
      "wb.use_autowidth = false\n" \
      "#{source}\n" \
      "xlsx_package.to_stream.read"
    end
  end.new

  ActionView::Template.register_template_handler(:axlsx, rails7_axlsx_handler)
end
