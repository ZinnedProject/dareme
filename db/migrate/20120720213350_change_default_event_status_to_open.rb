class ChangeDefaultEventStatusToOpen < ActiveRecord::Migration
  def change
  	change_column :events, :status, :string, :default => "Open"
  end

end
