class CreatePolicies < ActiveRecord::Migration[7.0]
  def change
    create_table :policies do |t|
      t.monetize :premium
      t.monetize :cover

      t.string :identifier, null: false, index: true, comment: 'External ID for reference'

      t.references :policy_type, foreign_key: { to_table: :policy_types }

      t.integer :status, default: 0, null: false

      t.date :effective_date
      t.date :expiry_date, index: true

      # Soft deletes field
      t.datetime :discarded_at, index: true, comment: 'Used for soft deletes'

      t.timestamps
    end
  end
end
