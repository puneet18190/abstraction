class CreateFeedbackToMoneys < ActiveRecord::Migration[5.1]
  def change
    create_table :feedback_to_moneys do |t|

      t.timestamps
    end
  end
end
