Spree::Api::ApiHelpers.class_eval do
  def variant_attributes
    [:id, :name, :sku, :price, :weight, :height, :width, :depth, :is_master, :cost_price, :permalink, :options_text]
  end
end