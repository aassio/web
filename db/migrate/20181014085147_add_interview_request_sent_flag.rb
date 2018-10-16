class AddInterviewRequestSentFlag < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :sent_interview_request, :boolean, default: false
  end
end
