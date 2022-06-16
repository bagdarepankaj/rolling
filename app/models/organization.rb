class Organization < ApplicationRecord
  has_many :users
  has_many :projects
  # has_many :founders
  # has_many :employees

  def founders
    users.joins(:roles).where('roles.name = ?', 'founder')
  end

  def employees
    users.joins(:roles).where('roles.name = ?', 'employee')
  end
end
