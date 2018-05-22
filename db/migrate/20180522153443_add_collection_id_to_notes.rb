class AddCollectionIdToNotes < ActiveRecord::Migration[5.2]
  def change
    add_column :notes, :collection_id, :integer
  end
end
