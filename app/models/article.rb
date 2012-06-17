class Article < ActiveRecord::Base
  belongs_to :source
  has_many :comments, :dependent => :destroy, :order => "id ASC"
end
