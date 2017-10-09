class User <ActiveRecord::Base
  has_many :lineups
  has_secure_password
end
