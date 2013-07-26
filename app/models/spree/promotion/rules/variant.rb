# A rule to limit a promotion based on products in the order.
# Can require all or any of the products to be present.
# Valid products either come from assigned product group or are assingned directly to the rule.
module Spree
  class Promotion
    module Rules
      class Variant < PromotionRule
        has_and_belongs_to_many :variants, :class_name => '::Spree::Variant', :join_table => 'spree_variants_promotion_rules', :foreign_key => 'promotion_rule_id'
        validate :only_one_promotion_per_variant

        MATCH_POLICIES = %w(any all)
        preference :match_policy, :string, default: MATCH_POLICIES.first

        def eligible_variants
          variants
        end

        def eligible?(order, options = {})
          return true if eligible_variants.empty?
          if preferred_match_policy == 'all'
            eligible_variants.all? {|v| order.variants.include?(v) }
          else
            order.variants.any? {|v| eligible_variants.include?(v) }
          end
        end

        def variant_ids_string
          variant_ids.join(',')
        end

        def variant_ids_string=(s)
          self.variant_ids = s.to_s.split(',').map(&:strip)
        end

        private

          def only_one_promotion_per_variant
            if Spree::Promotion::Rules::Variant.all.map(&:variants).flatten.uniq!
              errors[:base] << "You can't create two promotions for the same variant"
            end
          end
      end
    end
  end
end