class AddTokenAuthentication < ActiveRecord::Migration
  def self.up
    change_table(:guardians) do |t|
      ## Token authenticatable
      t.string :authentication_token
    end

  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
