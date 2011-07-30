class ReminderMailer < ActionMailer::Base
  default :from => "lavell@knittingpixel.com"
  default :to => "pwever@knittingpixel.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.reminder_mailer.daily_reminder.subject
  #
  def daily_reminder
    @todos = Todo.where(:done => false).select {|todo| todo.due_today? }
    
    mail
  end
end
