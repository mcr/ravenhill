class AddLastconfirmedToGuardians < ActiveRecord::Migration
  def change
    add_column :guardians, :lastconfirmed, :integer
  end
end
