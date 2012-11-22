class AddVariantsPromotionRules < ActiveRecord::Migration
  def up
    create_table :spree_variants_promotion_rules do |t|
      t.integer :variant_id, :promotion_rule_id
    end
    remove_column :spree_variants_promotion_rules, :id
    add_index :spree_variants_promotion_rules, :variant_id
    add_index :spree_variants_promotion_rules, :promotion_rule_id
  end

  def down
    drop_table :spree_variants_promotion_rules
  end
end