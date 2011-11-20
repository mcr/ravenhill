class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :firstname
      t.string :lastname
      t.string :grade
      t.integer :teacher_id
      t.integer :display
      t.boolean :updated

      t.timestamps
    end
  end
end
