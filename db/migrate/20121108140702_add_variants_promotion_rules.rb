class AddVariantsPromotionRules < ActiveRecord::Migration
  def up
    create_table :variants_promotion_rules do |t|
      t.integer :variant_id, :promotion_rule_id
    end
    
    add_index :variants_promotion_rules, :variant_id
    add_index :variants_promotion_rules, :promotion_rule_id
  end

  def down
    drop_table :variants_promotion_rules
  end
end