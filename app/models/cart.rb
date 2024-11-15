class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  # Method to add a product to the cart
  def add_product(product)
    # Find or initialize a line item with the given product_id
    current_item = line_items.find_or_initialize_by(product_id: product.id)
    
    # Increment quantity if the line item already exists
    current_item.quantity += 1 if current_item.persisted?
    
    current_item
  end

  # Method to calculate the total price of all line items in the cart
  def total_price
    # Sum up the total price of each line item
    line_items.sum(&:total_price)
  end
end
