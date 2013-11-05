require "spec_helper"

describe NotifyMailer do

  it '发送一封邮件' do
    line = "谭磊, wppurking@gmail.com"
    mail = NotifyMailer.interview(line).deliver
    expect(mail.body).to include('谭磊', 'mailto:wppurking@gmail.com')
    expect(mail.subject).to eq('邀请参加长沙蓝拓电子商务有限公司笔试题')
    expect(mail.to).to include('wppurking@gmail.com')
  end

end
