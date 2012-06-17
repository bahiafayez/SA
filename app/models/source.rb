class Source < ActiveRecord::Base
  has_many :articles, :dependent => :destroy, :order => "id ASC"
end
