class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :comment
      t.string :author
      t.integer :user_id
      t.integer :revision_id

      t.timestamps
    end
    add_index :feedbacks, [:revision_id, :created_at]
  end
end
