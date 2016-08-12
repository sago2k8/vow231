class User < ApplicationRecord
  rolify
  enum role: [:user, :admin]
  #  belongs_to :foundation
  #  belongs_to :voluntary
  #  validate :foundation_and_voluntary_mutually_exclusive
  # belongs_to :type_user, polymorphic: true
  attr_accessor :oauth_callback
  attr_accessor :current_password

  validates_presence_of   :email, if: :email_required?
  validates_uniqueness_of :email, allow_blank: true, if: :email_changed?
  validates_format_of     :email, with: Devise.email_regexp, allow_blank: true, if: :email_changed?

  validates_presence_of     :password, if: :password_required?
  validates_confirmation_of :password, if: :password_required?
  validates_length_of       :password, within: Devise.password_length, allow_blank: true
  # def type_user=(foundation_or_voluntary)
  #    case
  #    when foundation_or_voluntary.kind_of?(Foundation)
  #      self.foundation = foundation_or_voluntary
  #      self.voluntary = nil
  #    when foundation_or_voluntary.kind_of?(Voluntary)
  #      self.voluntary = foundation_or_voluntary
  #      self.foundation = nil
  #    else
  #      raise ArgumentError, "Expected foundation or voluntary"
  #    end
  #  end

  #  def type_user(foundation_or_voluntary)
  #    foundation || voluntary
  #  end

  #  private
  #  def foundation_and_voluntary_mutually_exclusive
  #    if foundation && voluntary
  #      errors.add "Can't have both a foundation and a voluntary"
  #    end
  #  end

  def password_required?
    return false if email.blank? || !email_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end

  def email_required?
    @oauth_callback != true
  end
  has_many :identities, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable
  def twitter
    identities.where( :provider => "twitter" ).first
  end

  def twitter_client
    @twitter_client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_APP_ID']
      config.consumer_secret     = ENV['TWITTER_APP_SECRET']
      config.access_token        = twitter.accesstoken
      config.access_token_secret = twitter.secrettoken
    end
  end

  def facebook
    identities.where( :provider => "facebook" ).first
  end

  def facebook_client
    @facebook_client ||= Facebook.client( access_token: facebook.accesstoken )
  end

end
