class User < ApplicationRecord
  include CpfValidates
  include Blockable
  extend FriendlyId
  friendly_id :token, use: :slugged

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Validations
  validate :blocked_user, on: [:login]
  validate :cpf_validate, on: [:login, :create, :update]
  validates :token, presence: {message: "Token não pode ficar em branco. "}, uniqueness: { case_sensitive: false, message: "Token já existe na base. "  }, on: [:update]
  validates :cpf, presence: {message: "CPF não pode ficar em branco. "}, uniqueness: { case_sensitive: false, message: "CPF já existe na base. "  }, on: [:create, :update]
  validates :email, presence: {message: "E-mail não pode ficar em branco. "}, uniqueness: { case_sensitive: false, message: "E-mail já existe na base. "  }, on: [:create, :update]

  # Relations
  has_one :account, class_name: "Account::Entity", foreign_key: "user_id"
  
  #Enums
  enum account_kind: { admin: 0,
                       team: 1,
                       doctor: 2,
                       helper: 3,
                       patient: 4 }, _prefix: :_

  enum sex: { male: 0,
              female: 1}, _prefix: :_

  #Callbacks
        
  def should_generate_new_friendly_id?
    self.token_changed?
  end

  def normalize_friendly_id(value)
    value.to_s.parameterize(preserve_case: true)
  end

  def create_basic_permissions
    ::Users::Permissions::CreateBasicPermissionsService.basic_permissions(self)
  end
end
