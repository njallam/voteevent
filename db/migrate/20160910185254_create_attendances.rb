class CreateAttendances < ActiveRecord::Migration[5.0]
  def change
    create_table :attendances do |t|
      t.references :event, foreign_key: true
      t.references :person, foreign_key: true
      t.boolean :voted, default: false

      t.timestamps
    end
  end
end
