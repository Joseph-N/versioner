class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :organisation
  has_many :articles, through: :organisation
  before_save :assign_organisation

  validates_presence_of :name


  private

  def assign_organisation
    self.organisation_id = Organisation.all.map(&:id).sample
  end

end
