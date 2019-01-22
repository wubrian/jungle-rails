class User < ActiveRecord::Base
    has_many :reviews
    
    before_save { email.downcase! }
    validates :first_name, presence: true, length: { maximum: 50 }
    validates :last_name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false }

    has_secure_password
    validates :password, :presence => true, :confirmation => true, :length => {:within => 6..40}

    def self.authenticate_with_credentials (email, password)
        user = User.find_by_email(email)
        user.authenticate(password)
    end
end
