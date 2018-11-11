ActiveAdmin.register User do


  scope :all
  scope :for_level_2
  scope :for_level_3
  scope :for_level_4
  scope :for_level_5

  scope :level_1
  scope :level_2
  scope :level_3
  scope :level_4
  scope :level_5

  permit_params :first_name, :last_name, :email, :mobile_phone_country_code, :mobile_phone

  form title: '' do |f|
    inputs 'Details' do
      input :first_name
      input :last_name
      input :email
      input :mobile_phone_country_code
      input :mobile_phone
    end
    actions
  end


  show do
    attributes_table do
      row :id
      row :first_name
      row :last_name
      row :email
      row :current_sign_in_ip
      row :last_sign_in_ip
      row :current_sign_in_at
      row :last_sign_in_at
      row :confirmed_at
      row :confirmation_sent_at
      row :failed_attempts
      row :created_at
      row :updated_at
      row :balance
      row :verification_level
      row :mobile_phone_country_code
      row :mobile_phone
      row :mobile_phone_confirmed_at
      row :passport_front_page do |user|
        if user.passport_front_page.attached?
          link_to 'Open', user.passport_front_page, target: '_blank'
        else
          ''
        end
      end
      row :passport_back_page do |user|
        if user.passport_back_page.attached?
          link_to 'Open', user.passport_front_page, target: '_blank'
        else
          ''
        end
      end
      row :passport_selfie do |user|
        if user.passport_selfie.attached?
          link_to 'Open', user.passport_selfie, target: '_blank'
        else
          ''
        end
      end
      row :utility_bill do |user|
        if user.utility_bill.attached?
          link_to 'Open', user.utility_bill, target: '_blank'
        else
          ''
        end
      end
      row :sent_interview_request
    end

    panel 'Transactions' do
      table_for user.transactions.order(id: :desc) do
        column :id
        column :amount
        column :comment
        column :created_at
        column :updated_at
      end
    end


  end

  action_item 'set_level_2', only: :show do
    if user.ready_for_level?(2)
      link_to 'Set level 2', set_level_2_admin_user_path(user)
    end
  end

  member_action :set_level_2 do
    user = User.find params[:id]
    if user.ready_for_level?(2)
      user.verification_events.create! admin_user_id: current_admin_user.id, what_happened: "Admin #{current_admin_user.email} set KYC level 2 in admin panel"
      user.update! verification_level: 2
      AccountMailer.promoted(user, 2).deliver_now
    end
    redirect_to admin_user_path(user), notice: 'User promoted to level 2'
  end

  action_item 'set_level_3', only: :show do
    if user.ready_for_level?(3)
      link_to 'Set level 3', set_level_3_admin_user_path(user)
    end
  end

  member_action :set_level_3 do
    user = User.find params[:id]
    if user.ready_for_level?(3)
      user.verification_events.create! admin_user_id: current_admin_user.id, what_happened: "Admin #{current_admin_user.email} set KYC level 3 in admin panel"
      user.update! verification_level: 3
      AccountMailer.promoted(user, 3).deliver_now
    end
    redirect_to admin_user_path(user), notice: 'User promoted to level 3'
  end

  action_item 'set_level_4', only: :show do
    if user.ready_for_level?(4)
      link_to 'Set level 4', set_level_4_admin_user_path(user)
    end
  end

  member_action :set_level_4 do
    user = User.find params[:id]
    if user.ready_for_level?(4)
      user.verification_events.create! admin_user_id: current_admin_user.id, what_happened: "Admin #{current_admin_user.email} set KYC level 4 in admin panel"
      user.update! verification_level: 4
      AccountMailer.promoted(user, 4).deliver_now
    end
    redirect_to admin_user_path(user), notice: 'User promoted to level 4'
  end


  action_item 'set_level_5', only: :show do
    if user.ready_for_level?(5)
      link_to 'Set level 5', set_level_5_admin_user_path(user)
    end
  end

  member_action :set_level_5 do
    user = User.find params[:id]
    if user.ready_for_level?(5)
      user.verification_events.create! admin_user_id: current_admin_user.id, what_happened: "Admin #{current_admin_user.email} set KYC level 5 in admin panel"
      user.update! verification_level: 5
      AccountMailer.promoted(user, 5).deliver_now
    end
    redirect_to admin_user_path(user), notice: 'User promoted to level 5'
  end



end
