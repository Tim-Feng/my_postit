class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.boolean :vote
      t.integer :user_id
      t.references :voteable, polymorphic: true
      # t.string :votable_type
      # t.integer :voteable_id
    end
  end
end
