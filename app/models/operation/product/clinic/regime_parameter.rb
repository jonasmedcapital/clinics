class Operation::Product::Clinic::RegimeParameter < ApplicationRecord

  self.table_name = "operation_clinic_regime_parameters"
  
  # Relations
  belongs_to :clinic, class_name: "Operation::Product::Entity", foreign_key: "clinic_id"

  # Validations

  # Enums
  enum tax_regime: {exempt: 0, simple_national: 1, presumed_profit: 2, real_profit: 3}, _prefix: :_
  
  enum special_tax_regime: { automatic: 0, none: 1, municipal_microenterprise: 2, estimation: 3, professional_society: 4, cooperative: 5, microenterprise_individual: 6, microenterprise_small_company: 7}, _prefix: :_
  
  enum legal_nature: { public_company: 0, mixed_economy_company: 1, public_limited_company: 2, private_limited_company: 3, limited_business_company: 4, corporate_company_in_simple_name: 5, business_company_in_simple_command: 6, business_company_in_joint_action: 7, partnership_in_account_participation: 8, entrepreneur: 9, cooperative_legal: 10, consortium_societies: 11, sociedad_group: 12, abroad_domiciled_company: 13, investment_fund_club: 14, pure_simple_society: 15, limited_simple_society: 16, simple_partnership_in_simple_name: 17, simple_partnership_in_comandita_simples: 18, binational_company: 19, employers_consortium: 20, simple_consortium: 21, eireli_natureza_empresaria: 22, eireli_natureza_simples: 23, notarial_service_: 24, private_foundation: 25, autonomous_social_service: 26, condominium_building: 27, prior_conciliation_commission: 28, mediation_arbitration_entity: 29, political_party: 30, trade_union_entity: 31, establishment_of_brazil_foreign_association_foundation: 32, abroad_domiciliated_association_foundation: 33, religious_organization: 34, indigenous_community: 35, private_fund: 36, associacao_priveted: 37  }, _prefix: :_

  #Callbacks  
end