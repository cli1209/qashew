ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  address:              'smtp.gmail.com',
  port:                 587,
  domain:               'qashew.herokuapp.com',
  user_name:            ENV["qashew.forum"],
  password:             ENV["hihihihi"],
  authentication:       'plain',
  enable_starttls_auto: true 
}