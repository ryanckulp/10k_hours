class AdminMailer < ApplicationMailer
  def error(subject, context = nil)
    @context = context
    mail(to: DEFAULT_VALUES['ADMIN_EMAIL'], subject: subject)
  end
end
