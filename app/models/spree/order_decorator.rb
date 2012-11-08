Spree::Order.class_eval do
  # need PR here
  def variants
    line_items.map { |li| li.variant }
  end
end
