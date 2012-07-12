class ChangeSlugNames < ActiveRecord::Migration
  def up
		remove_index :profiles,:user_name
		remove_index :events,:custom_url
  	rename_column :profiles, :user_name, :slug
		rename_column :events, :custom_url, :slug
		add_index :profiles,:slug, unique:true
		add_index :events,:slug, unique:true
  end

  def down
		remove_index :profiles,:slug
		remove_index :events,:slug
  	rename_column :profiles, :slug,  :user_name
		rename_column :events, :slug, :custom_url
		add_index :profiles,:user_name
		add_index :events,:custom_url

  end
end


