require 'test_helper'

class ReminderMailerTest < ActionMailer::TestCase
  test "daily_reminder" do
    mail = ReminderMailer.daily_reminder
    assert_equal "Daily reminder", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
