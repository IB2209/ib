class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.contact_email(@contact).deliver_now
      flash[:success] = 'お問い合わせありがとうございます。'
      redirect_to contact_thank_you_path  # リダイレクト先を設定
    else
      render 'new'
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:company, :name, :phone, :email, :content)
  end
end
