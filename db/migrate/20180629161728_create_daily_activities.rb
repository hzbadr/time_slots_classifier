class CreateDailyActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :daily_activities do |t|
      t.references :driver
      t.date :day
      t.time :start_at
      t.time :end_at
      t.string :activity_type

      t.timestamps
    end
  end
end
