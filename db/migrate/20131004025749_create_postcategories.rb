class CreatePostcategories < ActiveRecord::Migration
  def change
    create_table :postcategories do |t|
      t.integer :post_id, :category_id

      t.timestamps
    end
  end
end
