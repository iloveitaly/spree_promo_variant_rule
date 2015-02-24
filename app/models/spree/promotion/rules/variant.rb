# A rule to limit a promotion based on variants in the order.
# Can require all or any of the variants to be present.
# Valid variants either come from assigned variant group or are assingned directly to the rule.
module Spree
  class Promotion
    module Rules
      class Variant < PromotionRule
        has_and_belongs_to_many :variants, class_name: '::Spree::Variant', join_table: 'spree_variants_promotion_rules', foreign_key: 'promotion_rule_id'

        MATCH_POLICIES = %w(any all none)
        preference :match_policy, :string, default: MATCH_POLICIES.first

        # scope/association that is used to test eligibility
        def eligible_variants
          variants
        end

        def applicable?(promotable)
          promotable.is_a?(Spree::Order)
        end

        def eligible?(order, options = {})
          return true if eligible_variants.empty?

          if preferred_match_policy == 'all'
            unless eligible_variants.all? {|p| order.variants.include?(p) }
              eligibility_errors.add(:base, eligibility_error_message(:missing_variant))
            end
          elsif preferred_match_policy == 'any'
            unless order.variants.any? {|p| eligible_variants.include?(p) }
              eligibility_errors.add(:base, eligibility_error_message(:no_applicable_variants))
            end
          else
            unless order.variants.none? {|p| eligible_variants.include?(p) }
              eligibility_errors.add(:base, eligibility_error_message(:has_excluded_variant))
            end
          end

          eligibility_errors.empty?
        end

        def actionable?(line_item)
          case preferred_match_policy
          when 'any', 'all'
            variant_ids.include? line_item.variant.id
          when 'none'
            variant_ids.exclude? line_item.variant.id
          else
            raise "unexpected match policy: #{preferred_match_policy.inspect}"
          end
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