require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  setup do
    @order = orders(:one)
  end

  test "visiting the index" do
    visit orders_url
    assert_selector "h1", text: "Orders"
  end

  test "should create order" do
    visit orders_url
    click_on "New order"

    fill_in "Address", with: @order.address
    fill_in "Email", with: @order.email
    fill_in "Name", with: @order.name
    fill_in "Pay type", with: @order.pay_type
    click_on "Create Order"

    assert_text "Order was successfully created"
    click_on "Back"
  end

  test "should update Order" do
    visit order_url(@order)
    click_on "Edit this order", match: :first

    fill_in "Address", with: @order.address
    fill_in "Email", with: @order.email
    fill_in "Name", with: @order.name
    fill_in "Pay type", with: @order.pay_type
    click_on "Update Order"

    assert_text "Order was successfully updated"
    click_on "Back"
  end

  test "should destroy Order" do
    visit order_url(@order)
    click_on "Destroy this order", match: :first

    assert_text "Order was successfully destroyed"
  end

  test "check dynamic fields" do
    visit store_index_url
    click_on 'Add to Cart', match: :first
    click_on 'Checkout'

    # Check initial state - no payment fields visible
    assert has_no_field?('Routing number')
    assert has_no_field?('Account number')
    assert has_no_field?('Credit card number')
    assert has_no_field?('Expiration date')
    assert has_no_field?('Po number')

    # Select 'Check' payment type
    select 'Check', from: 'Pay type'
    assert has_field?('Routing number')
    assert has_field?('Account number')
    assert has_no_field?('Credit card number')
    assert has_no_field?('Expiration date')
    assert has_no_field?('Po number')

    # Select 'Credit card' payment type
    select 'Credit card', from: 'Pay type'
    assert has_no_field?('Routing number')
    assert has_no_field?('Account number')
    assert has_field?('Credit card number')
    assert has_field?('Expiration date')
    assert has_no_field?('Po number')

    # Select 'Purchase order' payment type
    select 'Purchase order', from: 'Pay type'
    assert has_no_field?('Routing number')
    assert has_no_field?('Account number')
    assert has_no_field?('Credit card number')
    assert has_no_field?('Expiration date')
    assert has_field?('Po number')
  end
end
