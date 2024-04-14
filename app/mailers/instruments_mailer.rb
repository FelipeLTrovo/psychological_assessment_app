class InstrumentsMailer < ApplicationMailer
  default from: 'no-reply@fetoreditora.com.br'

  def apply_instrument_email(recipient:, url:)
    @url = url
    mail(
      to: recipient,
      subject: 'Please solve the instrument',
    )
  end
end
