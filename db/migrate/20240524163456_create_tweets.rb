class CreateTweets < ActiveRecord::Migration[6.1]
  def change
    create_table :tweets do |t|
      t.text :body
      t.text :menu
      t.text :diet
      t.string :image

      t.timestamps
    end
  end
end
