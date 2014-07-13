require 'spec_helper'

describe Spree::Promotion::Rules::Variant do
	let!(:order) { FactoryGirl.create :order }

	it "should not be eligible if no variants are defined" do
		rule = Spree::Promotion::Rules::Variant.new

		expect(rule.eligible?(order)).to eq(false)
	end

	it "should be eligible when variants match" do
		variant = FactoryGirl.create :variant
		order.add_variant(variant)

		rule = Spree::Promotion::Rules::Variant.new
		rule.variants << variant

		expect(rule.eligible?(order)).to eq(true)
	end

	it "should not be eligible when no variants match" do
		variant = FactoryGirl.create :variant
		order.add_variant(variant)
		rule = Spree::Promotion::Rules::Variant.new

		expect(rule.eligible?(order)).to eq(false)
	end

	# TODO test different match limits
end