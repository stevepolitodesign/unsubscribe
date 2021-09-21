# Preview all emails at http://localhost:3000/rails/mailers/security_mailer
class SecurityMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/security_mailer/notice
  def notice
    SecurityMailer.notice
  end

end
