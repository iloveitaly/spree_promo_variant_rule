# A rule to limit a promotion based on products in the order.
# Can require all or any of the products to be present.
# Valid products either come from assigned product group or are assingned directly to the rule.
module Spree
  class Promotion
    module Rules
      class Variant < PromotionRule
        has_and_belongs_to_many :variants, :class_name => '::Spree::Variant', :join_table => 'spree_variants_promotion_rules', :foreign_key => 'promotion_rule_id'

        MATCH_POLICIES = %w(any 1 2 3 4 5 6 7 8 9 10 all)
        preference :match_policy, :string, :default => MATCH_POLICIES.first

        def eligible?(order, options = {})
          return true if variants.empty?

          match_count = order.variants.select { |v| variants.include? v }.size

          case preferred_match_policy
          when 'all'
            return match_count == variants.size
          when 'any'
            return match_count > 0
          end

          match_count == preferred_match_policy.to_i
        end

        # TODO still need to wire up the picker
        # for the AJAX picker

        # def variant_ids_string
        #   variant_ids.join(',')
        # end

        # def variant_ids_string=(s)
        #   self.variant_ids = s.to_s.split(',').map(&:strip)
        # end

      end
    end
  end
end