# Clear existing data
Product.delete_all
User.delete_all # If you want to reset the users too

# Create a user with a password
User.create! name: 'dave',
        password: Rails.application.credentials.dave_password

# Create products
Product.create!(
  title: 'Design and Build Great Web APIs',
  description: %{
    <p>
      <em>Robust, Reliable, and Resilient</em>
      APIs are transforming the business world at an increasing pace. 
      Gain the essential skills needed to quickly design, build, 
      and deploy quality web APIs that are robust, reliable, and resilient.
    </p>
  },
  image_url: 'maapis.jpg',
  price: 24.95
)

Product.create!(
  title: 'Modern CSS with Tailwind',
  description: %{
    <p>
      Tailwind CSS is an exciting new way to build modern websites.
    </p>
  },
  image_url: 'tailwind.jpg',
  price: 18.95
)
