class NotifyMailer < ActionMailer::Base
  default from: "Wyatt <wppurking@gmail.com>"

  def interview(line)
    args = line.split(',')
    @name = args[0]
    @email = args[1].strip
    mail(to: @email, subject: "邀请 #{@name} 参加长沙蓝拓电子商务有限公司 Java 工程师笔试题")
  end

end
