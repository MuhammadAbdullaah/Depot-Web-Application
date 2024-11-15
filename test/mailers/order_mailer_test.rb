require "test_helper"

class OrderMailerTest < ActionMailer::TestCase
  test "received" do
    mail = OrderMailer.received(orders(:one)) # Assuming 'orders(:one)' exists
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
    assert_equal ["dave@example.org"], mail.to
    assert_equal ["depot@example.com"], mail.from
    assert_match /1 x Programming Ruby 1.9/, mail.body.encoded # Update as per your actual order items
  end

  test "shipped" do
    mail = OrderMailer.shipped(orders(:one)) # Assuming 'orders(:one)' exists
    assert_equal "Pragmatic Store Order Shipped", mail.subject
    assert_equal ["dave@example.org"], mail.to
    assert_equal ["depot@example.com"], mail.from
    assert_match %r(
      <td[^>]*>1<\/td>\s*
      <td>&times;<\/td>\s*
      <td[^>]*>\s*Programming\sRuby\s1.9\s*</td>
    )x, mail.body.to_s # Update as per your actual order items
  end
end
