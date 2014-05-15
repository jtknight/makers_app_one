class Brand < ActiveRecord::Base
	require 'uri'

  has_many :videos, dependent: :destroy
  #mount the carrierwave uploader to give Brands a profile avatar pic
  mount_uploader :avatar, AvatarUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save { self.email = email.downcase }
  before_save { self.hometown = hometown.capitalize }
  before_save { self.homestate = homestate.upcase }

  validates :email, uniqueness: { case_sensitive: false }
  validates :name, 	      presence: true, length: { maximum: 50}, uniqueness: { case_sensitive: false }
  validates :website,     presence: true, length: { maximum: 100}, uniqueness: { case_sensitive: false }
  validates :description, length: { maximum: 1000}
  validates :hometown,    presence: true, length: { maximum: 50}
  validates :homestate,   presence: true, length: { maximum: 2}
  validate :email_matches_website

  def email_matches_website
    email_domain = email.partition("@")[2].downcase
    website_domain = get_host_without_www(website)
    if email_domain != website_domain
      errors.add(:email, "address must match the domain of the website.  This helps protect the security of your brand identity.  For example, if the website is 'www.MakersAtlas.com', then 'contact@makersatlas.com' is acceptable, but 'contact@gmail.com' is NOT acceptable.")
    end
  end

  def get_host_without_www(url)
    uri = URI.parse(url)
    uri = URI.parse("http://#{url}") if uri.scheme.nil?
    host = uri.host.downcase
    host.start_with?('www.') ? host[4..-1] : host
  end
end
