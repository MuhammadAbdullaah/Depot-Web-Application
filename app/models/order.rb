require 'pago'

class Order < ApplicationRecord
  has_many :line_items

  # Ensure necessary fields are present for an order
  validates :name, :address, :email, :pay_type, presence: true

  # Add line items from the cart to the order
  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  # Enum for payment types
  enum pay_type: {
    "Check" => 0,
    "Credit card" => 1,
    "Purchase order" => 2
  }
  
  # Method to charge payment based on payment type
  def charge!(pay_type_params)
    payment_details = {}
    payment_method = nil

    # Process payment details based on the payment method selected
    case pay_type
    when "Check"
      payment_method = :check
      payment_details[:routing] = pay_type_params[:routing_number]
      payment_details[:account] = pay_type_params[:account_number]

    when "Credit card"
      payment_method = :credit_card
      month, year = pay_type_params[:expiration_date].split('/') # Properly split expiration date
      payment_details[:cc_num] = pay_type_params[:credit_card_number]
      payment_details[:expiration_month] = month
      payment_details[:expiration_year] = year

    when "Purchase order"
      payment_method = :po
      payment_details[:po_num] = pay_type_params[:po_number]

    else
      raise "Unknown payment type"
    end

    # Attempt to process payment via Pago
    payment_result = Pago.make_payment(
      order_id: id,
      payment_method: payment_method,
      payment_details: payment_details
    )

    # Handle payment success or failure
    if payment_result.succeeded?
      OrderMailer.received(self).deliver_later
    else
      logger.error "Payment failed for order #{id}: #{payment_result.error}"
      raise payment_result.error
    end
  end
end
