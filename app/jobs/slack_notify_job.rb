class SlackNotifyJob < ApplicationJob
  include SuckerPunch::Job

  def perform(error_message, source_extract, backtrace, user, tipo_error)
    error = "Error: #{tipo_error} - Internal Server Error"
    message = ""
    message << "*#{error}*\n"
    message << "*Date:* #{Time.now}\n"
    message << "*Error:* ```#{error_message}``` \n"
    message << "*Source:* ```#{source_extract}``` \n"
    message << "*Backtrace*: ```#{backtrace}``` \n"
    notifier = Slack::Notifier.new Rails.application.secrets.slack_url
    username = "Heroica7 - Username: #{user.username}"
    notifier.ping message, username: username, channel: '#errors-heroica7'
  end
end