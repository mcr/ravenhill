class ConfirmationMailer < ActionMailer::Base
  default from: "#{$RavenhillAdminName} <#{$RavenhillAdminEmail}>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.confirmation_mailer.confirm.subject
  #
  def confirm(guardian)
    @guardian = guardian

    mail to: @guardian.email
  end

  def accepted(guardian)
    @guardian = guardian

    mail to: @guardian.email
  end

  def declined(guardian)
    @guardian = guardian

    mail to: @guardian.email
  end

  def wrongemail(guardian)
    @guardian = guardian

    mail to: @guardian.email
  end
end
