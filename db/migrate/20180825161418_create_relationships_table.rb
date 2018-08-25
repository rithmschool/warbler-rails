class CreateRelationshipsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.references :followee
      t.references :follower
      t.index [:followee_id, :follower_id], unique: true
    end

    add_foreign_key :relationships, :users, column: :followee_id
    add_foreign_key :relationships, :users, column: :follower_id
  end
end
