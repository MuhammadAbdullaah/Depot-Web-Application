class LineItemsController < ApplicationController
  skip_before_action :authorize, only: %i[ create ]
  include CurrentCart # Include the CurrentCart module
  before_action :set_cart, only: %i[create] # Ensure cart is set before creating a line item
  before_action :set_line_item, only: %i[ show edit update destroy ]

  # GET /line_items or /line_items.json
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1 or /line_items/1.json
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

# app/controllers/line_items_controller.rb
def create
  product = Product.find(params[:product_id])
  @line_item = @cart.add_product(product)

  respond_to do |format|
    if @line_item.save
      @current_item = @line_item  # Store the current item for potential highlighting
      @notice = 'Item was added to the cart.'  # Define the notice message

      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace('notice', partial: 'store/notice', locals: { notice: @notice }),
          turbo_stream.replace('cart', partial: 'carts/cart', locals: { cart: @cart, current_item: @current_item })
        ]
      end

      format.html { redirect_to store_index_url, notice: @notice }
      format.json { render :show, status: :created, location: @line_item }
    else
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @line_item.errors, status: :unprocessable_entity }
    end
  end
end

  
  
  

  # PATCH/PUT /line_items/1 or /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: "Line item was successfully updated." }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1 or /line_items/1.json
  def destroy
    @line_item.destroy!

    respond_to do |format|
      format.html { redirect_to line_items_path, status: :see_other, notice: "Line item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def line_item_params
      params.require(:line_item).permit(:product_id)
    end
    
end
