class Pago
  def self.charge(order, pay_type_params)
    # Simulate a slow payment processing time
    sleep 5
    puts "Processing check: #{pay_type_params['routing_number']}/#{pay_type_params['account_number']}"
  end
end
