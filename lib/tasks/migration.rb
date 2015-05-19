class TagBearerCreateActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :key, required: true
      t.string :value
      t.string :owner_class
      t.integer :owner_id
      t.timestamps
    end

    add_index :tags, [:owner_class, :owner_id]
  end
end