class CreateProjectInfos < ActiveRecord::Migration
  def change
    create_table :project_infos do |t|
      t.string :client
      t.string :project_name
      t.boolean :open
      

      t.timestamps
    end
  end
end
