class CreateRevisions < ActiveRecord::Migration
  def change
    create_table :revisions do |t|
      t.integer :project_id

      t.timestamps
    end
    add_index :revisions, [:project_id, :created_at]
  end
end
