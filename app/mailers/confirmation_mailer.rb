class ConfirmationMailer < ActionMailer::Base
  default from: "#{$RavenhillAdminName} <#{$RavenhillAdminEmail}>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.confirmation_mailer.confirm.subject
  #
  def confirm(guardian)
    @guardian = guardian

    mail to: @guardian.email,
      subject: "Churchill Alternative School: Student Directory"
  end

  def accepted(guardian)
    @guardian = guardian

    mail to: @guardian.email,
      subject: "Churchill Alternative School: Student Directory Accepted"
  end

  def declined(guardian)
    @guardian = guardian

    mail to: @guardian.email,
      subject: "Churchill Alternative School: Student Directory Declined"
  end

  def wrongemail(guardian)
    @guardian = guardian

    mail to: @guardian.email,
      subject: "Churchill Alternative School: Student Directory Wrong Email"
  end
end
