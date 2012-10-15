class AddWrongemailToGuardian < ActiveRecord::Migration
  def change
    add_column :guardians, :wrongemail_at, :datetime, :default => nil
  end
end
