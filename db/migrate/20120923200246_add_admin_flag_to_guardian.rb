class AddAdminFlagToGuardian < ActiveRecord::Migration
  def change
    change_table :guardians do |g|
      g.boolean :admin, :default => false
    end
  end
end
