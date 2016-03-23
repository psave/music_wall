class Song < ActiveRecord::Base

  belongs_to :user

  belongs_to :artist

  validates :title, presence: true

end