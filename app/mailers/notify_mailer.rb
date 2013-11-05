class NotifyMailer < ActionMailer::Base
  default from: "wppurking@gmail.com"

  def interview(line)
    args = line.split(',')
    @name = args[0]
    @email = args[1]
    mail(to: @email, subject: '邀请参加长沙蓝拓电子商务有限公司笔试题')
  end

end
