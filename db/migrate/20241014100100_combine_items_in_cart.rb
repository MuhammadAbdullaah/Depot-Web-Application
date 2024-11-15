class CombineItemsInCart < ActiveRecord::Migration[6.1]
  def up
    # Replace multiple items for a single product in a cart with a single item
    Cart.find_each do |cart|  # Use find_each for better performance in large datasets
      # Count the number of each product in the cart
      sums = cart.line_items.group(:product_id).sum(:quantity)
      sums.each do |product_id, quantity|
        if quantity > 1
          # Remove individual items
          cart.line_items.where(product_id: product_id).destroy_all
          # Replace with a single item with updated quantity
          cart.line_items.create!(product_id: product_id, quantity: quantity)
        end
      end
    end
  end

  def down
    # Split items with quantity > 1 into multiple items
    LineItem.where("quantity > 1").find_each do |line_item|
      # Add individual items
      line_item.quantity.times do
        LineItem.create!(
          cart_id: line_item.cart_id,
          product_id: line_item.product_id,
          quantity: 1
        )
      end
      # Remove original item
      line_item.destroy
    end
  end
end
