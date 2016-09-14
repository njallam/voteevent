class AddPasscodeToPeople < ActiveRecord::Migration[5.0]
  def change
    add_column :people, :passcode, :string
  end
end
