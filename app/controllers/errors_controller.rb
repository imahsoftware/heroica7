class ErrorsController < ApplicationController
  layout "errors"

  skip_before_action :authenticate_user!
  skip_before_action :validatesession

  def not_found
    return head :not_found if favicon_request?

    notify_slack(404)
    render_error(:not_found, :not_found)
  end

  def internal_server_error
    notify_slack(500)
    render_error(:internal_server_error, :internal_server_error)
  end

  def blank_page
    notify_slack(402)
    render status: 402
  end

  private

  def favicon_request?
    request.path.match?(%r{\A/favicon\.(ico|png)\z}i)
  end

  def render_error(template, status)
    respond_to do |format|
      format.html { render template, status: status }
      format.any  { head status }
    end
  end

  def notify_slack(status)
    return if favicon_request?

    exception = request.env["action_dispatch.exception"]
    return unless exception

    message = exception.message.to_s
    source_extract = exception.source_extract&.join("\n")
    backtrace = exception.backtrace&.first(10)&.join("\n")
    SlackNotifyJob.perform_in(5, message, source_extract, backtrace, current_user, status)
  rescue StandardError => e
    Rails.logger.warn("[ErrorsController] Slack notify skipped: #{e.message}")
  end
end
