class Student < ActiveRecord::Base
  validates_presence_of :username, :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  validates :username, uniqueness: true
  validates :password, presence: true, on: :create
  has_many :presentations
  has_many :comments, through: :presentations
  has_secure_password

  def full_name
    self.first_name + " " + self.last_name
  end

  def comments_published
    Comment.find_by(:id => self.id)
  end

  def presentation_message(presentation)
    if presentation.nil? || presentation.youtube_link.empty?
      "Upload"
    else
      "Change"
    end
  end
end
