class User < ApplicationRecord
    validates :username, :password_digest, :session_token, :password, presence: true
    validates :username, :session_token, uniqueness: true
    attr_reader :password

    after_initialize :ensure_session_token

    has_many :goals
    has_many :authored_comments


    def password=(pw)
        @password = pw
        self.password_digest = BCrypt::Password.create(pw)
    end

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
        return nil if user.nil?
        user.is_password?(password) ? user : nil
    end

    def self.generate_session_token
        SecureRandom::urlsafe_base64(16)
    end
    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    def ensure_session_token
        self.session_token ||= self.class.generate_session_token
    end 

    def reset_session_token!
        self.session_token = self.class.generate_session_token
    end


end