class ReminderMailer < ActionMailer::Base
  default :from => "lavell@knittingpixel.com"
  default :to => "pwever@knittingpixel.com"
  
  # Trigger with cron. For example:
  # 00 07 * * * cd /WebApps/Todo; /var/lib/gems/1.8/bin/rails runner "ReminderMailer.deliver_daily"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.reminder_mailer.daily_reminder.subject
  #
  def daily
    @todos = Todo.where(:done => false).select {|todo| todo.due_today? }
    
    mail
  end
end
