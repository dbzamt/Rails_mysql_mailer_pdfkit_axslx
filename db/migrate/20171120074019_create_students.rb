class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students do |t|
      t.string :Name
      t.string :DOB
      t.string :email
      t.string :Phone_No
      t.string :course

      t.timestamps
    end


    # create_table :courses do |t|
    #   t.belongs_to :student,index:{ unique: true }, foreign_key: true

    #   t.integer :student_id
    #   t.string :course

    #   t.timestamps
    # end
  end
end
