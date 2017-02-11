class PiaMailer < ApplicationMailer
  default from: "support@ownyourdata.eu"
  def pia_created(user, url, pwd)
    @url = url
    @user = "data"
    @pwd = pwd
    mail(to: user, subject: '[OwnYourData] Zugangsdaten für deinen Datentresor')
  end

end
