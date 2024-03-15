class ContactMailer < ApplicationMailer
  def contact_email(contact)
    @contact = contact
    mail(to: ENV['GMAIL_USERNAME'], subject: 'お問い合わせがありました')
  end
end
