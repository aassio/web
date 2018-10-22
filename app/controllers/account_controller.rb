class AccountController < BackofficeDefaultController

  def index
    @order = current_user.orders.build purchase_price: current_user.max_purchase_in_eth
  end

  def kyc
  end

  def add_phone
    if current_user.update mobile_phone: params[:user][:mobile_phone], mobile_phone_country_code: params[:user][:mobile_phone_country_code]
      current_user.verification_smses.create phone: current_user.mobile_phone, mobile_phone_country_code: params[:user][:mobile_phone_country_code]
      redirect_to account_kyc_path, notice: 'New phone added. Please, verify your mobile phone'
    else
      redirect_to account_kyc_path, alert: 'Please, check your phone number. It has incorrect syntax'
    end
  end

  def delete_phone
    current_user.update mobile_phone: nil, mobile_phone_country_code: nil
    redirect_to account_kyc_path, notice: 'Phone removed. Please, add new mobile phone'
  end

  def check_code
    tryout = current_user.verification_sms_tryouts.new params[:verification_sms_tryout].permit(:code)
    if tryout.save!
      response = Authy::PhoneVerification.check verification_code: tryout.code, country_code: current_user.mobile_phone_country_code, phone_number: current_user.mobile_phone
      if response.ok?
        tryout.update result: true
        current_user.update mobile_phone_confirmed_at: Time.current
        redirect_to account_kyc_path, notice: 'Phone successfully confirmed'
      else
        redirect_to account_kyc_path, alert: 'Wrong SMS code'
      end
    else
      redirect_to account_kyc_path, alert: 'Please, enter 4-digits code'
    end
  end


  def upload_passport_front_page
    if params[:user].present? && params[:user][:passport_front_page].present? && current_user.verification_level == 2
      current_user.passport_front_page.attach params[:user][:passport_front_page]
      if current_user.passport_front_page.attached?
        current_user.update! has_passport_front_page: true
        redirect_to account_kyc_path, notice: 'File uploaded'
      else
        redirect_to account_kyc_path, alert: 'File was not uploaded'
      end
    else
      redirect_to account_kyc_path
    end
  end

  def upload_passport_back_page
    if params[:user].present? && params[:user][:passport_back_page].present? && current_user.verification_level == 2
      current_user.passport_back_page.attach params[:user][:passport_back_page]
      if current_user.passport_back_page.attached?
        current_user.update! has_passport_back_page: true
        redirect_to account_kyc_path, notice: 'File uploaded'
      else
        redirect_to account_kyc_path, alert: 'File was not uploaded'
      end
    else
      redirect_to account_kyc_path
    end
  end

  def upload_passport_selfie
    if params[:user].present? && params[:user][:passport_selfie].present? && current_user.verification_level == 2
      current_user.passport_selfie.attach params[:user][:passport_selfie]
      if current_user.passport_selfie.attached?
        current_user.update! has_passport_selfie: true
        redirect_to account_kyc_path, notice: 'File uploaded'
      else
        redirect_to account_kyc_path, alert: 'File was not uploaded'
      end
    else
      redirect_to account_kyc_path
    end
  end

  def upload_utility_bill
    if params[:user].present? && params[:user][:utility_bill].present? && current_user.verification_level == 3
      current_user.utility_bill.attach params[:user][:utility_bill]
      if current_user.utility_bill.attached?
        current_user.update! has_utility_bill: true
        redirect_to account_kyc_path, notice: 'File uploaded'
      else
        redirect_to account_kyc_path, alert: 'File was not uploaded'
      end
    else
      redirect_to account_kyc_path
    end
  end

  def request_interview
    if current_user.verification_level == 4
      current_user.update! sent_interview_request: true
      redirect_to account_kyc_path, notice: 'Request sent'
    else
      redirect_to account_kyc_path
    end
  end



end



