# frozen_string_literal: true

# ActionMailer of ApplicationMailer class
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
