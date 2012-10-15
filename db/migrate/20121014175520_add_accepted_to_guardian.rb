class AddAcceptedToGuardian < ActiveRecord::Migration
  def change
    add_column :guardians, :accepted, :boolean, :default => false
  end
end
