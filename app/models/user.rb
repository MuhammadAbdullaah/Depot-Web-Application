class User < ApplicationRecord
  has_secure_password

  after_destroy :ensure_an_admin_remains

  class LastUserError < StandardError
  end

  private

  def ensure_an_admin_remains
    if User.count.zero?
      raise LastUserError.new "Can't delete the last user"
    end
  end
end
