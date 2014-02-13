class CreateTables < ActiveRecord::Migration
  def change
  	create_table :users do |t|
  		t.string :name
      t.string :password
      t.timestamps
  	end

    create_table :notes do |t|
      t.string :title
      t.string :content
      t.belongs_to :user
      t.timestamps
    end
  end
end
