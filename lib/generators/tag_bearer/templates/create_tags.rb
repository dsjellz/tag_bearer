class TagBearerCreateActiveRecord::Migration
  def change
    create_table(:tags) do |t|
      t.string :key, required: true
      t.string :value
      t.references :taggable, polymorphic: true, index: true
      t.timestamps null: false
    end
  end
end