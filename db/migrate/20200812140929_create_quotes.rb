class CreateQuotes < ActiveRecord::Migration[6.0]
  def change
    create_table :quotes do |t|
      t.string "tag"
      t.text "quote"
      t.string "author"
      t.string "about"
      t.text "tags"

      t.timestamps
    end
  end
end
