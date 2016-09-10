class AddRevealedToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :revealed, :boolean, default: false
  end
end
