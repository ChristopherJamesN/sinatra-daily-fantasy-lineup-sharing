class CreateLineups < ActiveRecord::Migration
  def change
    create_table :lineups do |t|
    t.string :name
    t.array :players_array
    t.integer :user_id
    end
  end
end
