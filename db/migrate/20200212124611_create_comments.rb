class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :content
      t.belongs_to :gossip
      t.references :author, index: true
      t.timestamps
    end
  end
end
