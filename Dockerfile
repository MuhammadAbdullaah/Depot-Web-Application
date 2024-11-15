# Use Ruby 3.1.3 as the base image
FROM ruby:3.1.0

# Set environment variables
ENV RAILS_ENV=production
ENV BUNDLE_WITHOUT="development test"
ENV HOME=/home/app
ENV SECRET_KEY_BASE="1e500665aa6def2b28f641f8fc77cae902a4a6993fd3e80753f3b5a2eae9db1129fc0386cb0f1f747013476be73a77f1e325b83f72dc78c31132cf6bc8938a14"

# Install dependencies
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nginx && \
    rm -rf /var/lib/apt/lists/*

# Create the application directory and set ownership
RUN mkdir -p $HOME/depot && chown -R nobody:nogroup $HOME

# Switch to a non-root user
USER nobody

# Set the working directory
WORKDIR $HOME/depot

# Copy Gemfile and Gemfile.lock with proper ownership and install gems
COPY --chown=nobody:nogroup Gemfile Gemfile.lock ./
RUN bundle install

# Copy the rest of the application code with proper ownership
COPY --chown=nobody:nogroup . .

# Install Passenger
RUN gem install passenger -v 6.0.12

# Precompile assets using the predefined SECRET_KEY_BASE
RUN bundle exec rails assets:precompile

# Switch back to root user to create symbolic link
USER root

# Copy the Nginx configuration file
COPY config/nginx.conf /etc/nginx/sites-available/depot.conf
RUN ln -s /etc/nginx/sites-available/depot.conf /etc/nginx/sites-enabled/depot.conf

# Switch back to non-root user
USER nobody

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
