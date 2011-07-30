
# Configure email settings
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = YAML::load_file(File.join("#{RAILS_ROOT}", "config", "smtp_settings.yml"))

{
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => 'knittingpixel.com',
  :user_name            => 'lavell@knittingpixel.com',
  :password             => 'h8DfalAS3',
  :authentication       => 'plain'
}