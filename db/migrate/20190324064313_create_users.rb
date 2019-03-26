class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :id_token
      t.string :name
      t.string :occupation
      t.string :age
      t.string :gender
      t.string :refresh_token
      t.timestamps
    end
  end
end
