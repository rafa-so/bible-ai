class AddChurchMinisteryToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :church, :string
    add_column :users, :ministery, :string
  end
end
