class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :organization, required: false

  def full_name
    "#{first_name} #{last_name}"
  end

  def admin?
    has_role? :admin
  end

  def founder?
    has_role? :founder
  end
end
