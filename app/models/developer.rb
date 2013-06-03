class Developer < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :password
  validates :email, :first_name, :last_name, :password, :presence => :true

  has_many :entries
  has_many :invoices, :dependent => :destroy
  

  def to_s 
  	"#{first_name} #{last_name}"
  end
  
end
