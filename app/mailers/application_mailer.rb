class ApplicationMailer < ActionMailer::Base
  default from: '管理人だよ<from@gmail.com>',
  bcc: 'from-bcc@gmail.com',
  reply_to: 'from-replyto@gmail.com'
  layout 'mailer'
end
