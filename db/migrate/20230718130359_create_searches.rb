class CreateSearches < ActiveRecord::Migration[7.0]
  def change
    create_table :searches do |t|
      t.string :term
      t.jsonb :content
      t.references :user
      t.timestamps
    end
  end
end
