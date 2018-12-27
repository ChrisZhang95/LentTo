require 'open-uri'

class User < ApplicationRecord
  has_one :profile, :dependent => :destroy
  has_one :credential, :dependent => :destroy
  has_many :friends, :dependent => :destroy
  has_many :uratings, :dependent => :destroy
  has_many :transactions, :dependent => :destroy
  has_many :items, :dependent => :destroy
  before_create :build_profile
  before_create :build_credential
  accepts_nested_attributes_for :profile
  accepts_nested_attributes_for :credential

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :confirmable, :timeoutable, omniauth_providers: [:google_oauth2, :facebook]
            
  def self.from_omniauth(auth)
    # Either create a User record or update it based on the provider (Google) and the UID   
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      #General Info
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.skip_confirmation!
    end
  end

  def update_profile(auth)
    # update user profile information
    self.profile.first_name = auth.info.first_name
    self.profile.last_name = auth.info.last_name
    self.profile.save!
    self.save_remote_file(auth.info.image)
  end

  def update_credential(auth)
    # update 3rd party credentials
    self.credential.token = auth.credentials.token
    self.credential.expires = auth.credentials.expires
    self.credential.expires_at = auth.credentials.expires_at
    self.credential.refresh_token = auth.credentials.refresh_token
    self.credential.save!
  end

  def save_remote_file(url)
    if url[-4] == "."
      self.profile.picture = url
      self.profile.save
    else
      file = open(url)
      self.profile.avatar.attach(io: file, filename: "user_avatar_#{self.id}.png", content_type: "image/png")
    end
  end

  def average_rating
    _rating = self.uratings.average(:score)
    if _rating
      _rating.round(1)
    else
      "-"
    end
  end
  
end
