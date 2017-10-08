class CreateLineups < ActiveRecord::Migration[4.2]
  def change
    create_table :lineups do |t|
    t.string :name
    t.string :quarterback
    t.string :runningback_one
    t.string :runningback_two
    t.string :widereceiver_one
    t.string :widereceiver_two
    t.string :widereceiver_three
    t.string :tightend
    t.string :flex
    t.string :defense
    t.integer :user_id
    end
  end
end
