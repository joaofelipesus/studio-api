# frozen_string_literal: true

class StudentsMailer < ApplicationMailer
  def give_access
    @student = params[:student]
    @generated_password = params[:password]
    @user = @student.user
    @email = @user.email
    subject = 'Acesso a plataforma SmartStudio'
    mail to: @email, subject:
  end
end
