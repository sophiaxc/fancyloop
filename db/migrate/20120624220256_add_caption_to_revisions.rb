class AddCaptionToRevisions < ActiveRecord::Migration
  def change
    add_column :revisions, :caption, :string
  end
end
