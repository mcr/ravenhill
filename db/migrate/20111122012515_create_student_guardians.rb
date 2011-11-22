class CreateStudentGuardians < ActiveRecord::Migration
  def change
    create_table :student_guardians do |t|
      t.integer :student_id
      t.integer :guardian_id

      t.timestamps
    end
  end
end
