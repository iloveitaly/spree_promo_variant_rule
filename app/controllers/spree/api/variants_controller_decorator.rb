Spree::Api::VariantsController.class_eval do
  # based on Spree::Api::ProductsController
  def index
    if params[:ids]
      @variants = scope.includes(:option_values).accessible_by(current_ability, :read).where(:id => params[:ids])
    else
      @variants = scope.includes(:option_values).ransack(params[:q]).result
    end

    @variants = @variants.page(params[:page]).per(params[:per_page])

    respond_with(@variants)
  end
end
