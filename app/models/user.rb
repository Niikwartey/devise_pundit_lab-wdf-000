class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :notes
  has_many :viewers
  has_many :readable, through: :viewers, source: :note

  enum role: [:user, :vip, :admin]

  after_initialize :set_default_role, if: :new_record?



  def guest?
    persistedc?
  end

  private
    def set_default_role
      self.role = "user"
    end


end
