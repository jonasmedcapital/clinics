class Operations::Products::Clinics::RegimeParameterRepository < Base

  def self.build(attrs)
    obj = entity.new
    obj.clinic_id = attrs["clinic_id"]
    obj.monthly = attrs["monthly"]
    obj.per_partner = attrs["per_partner"]
    obj.tax_regime = attrs["tax_regime"]
    obj.special_tax_regime = attrs["special_tax_regime"]
    obj.legal_nature = attrs["legal_nature"]
    obj.year = attrs["year"]
    obj.started_at = attrs["started_at"].to_date
    obj.iss_rate = attrs["iss_rate"]
    return obj
  end

  def self.all_active
    entity.where(active: true)
  end

  def self.all_active_clinic(clinic_id)
    entity.where(active: true, clinic_id: clinic_id)
  end

  def self.list_all(parameters)
    mapper.map_all(parameters)
  end

  def self.read(parameter)
    mapper.map(parameter)
  end

  def self.find_by_id(id)
    entity.find_by(id: id)
  end

  private

  def self.entity
    "Operation::Product::Clinic::RegimeParameter".constantize
  end

  def self.mapper
    "Operations::Products::Clinics::RegimeParameterMapper".constantize
  end

  TAX_REGIME = {
    "simple_national" => "SimplesNacional",
    "presumed_profit" => "LucroPresumido"
  }

  SPECIAL_TAX_REGIME = {
    "automatic" => "Automatico",
    "none" => "Nenhum",
    "municipal_microenterprise" => "MicroempresaMunicipal",
    "estimation" => "Estimativa",
    "professional_society" => "SociedadeDeProfissionais",
    "cooperative" => "Cooperativa",
    "microenterprise_individual" => "MicroempreendedorIndividual",
    "microenterprise_small_company" => "MicroempresarioEmpresaPequenoPorte"
  }

  LEGAL_NATURE = {
    "public_company" => "EmpresaPublica",
    "mixed_economy_company" => "SociedadeEconomiaMista",
    "public_limited_company" => "SociedadeAnonimaAberta",
    "private_limited_company" => "SociedadeAnonimaFechada",
    "limited_business_company" => "SociedadeEmpresariaLimitada",
    "corporate_company_in_simple_name" => "SociedadeEmpresariaEmNomeColetivo",
    "business_company_in_simple_command" => "SociedadeEmpresariaEmComanditaSimples",
    "business_company_in_joint_action" => "SociedadeEmpresariaEmComanditaporAcoes",
    "partnership_in_account_participation" => "SociedadeemContaParticipacao",
    "entrepreneur" => "Empresario",
    "cooperative_legal" => "Cooperativa",
    "consortium_societies" => "ConsorcioSociedades",
    "sociedad_group" => "GrupoSociedades",
    "abroad_domiciled_company" => "EmpresaDomiciliadaExterior",
    "investment_fund_club" => "ClubeFundoInvestimento",
    "pure_simple_society" => "SociedadeSimplesPura",
    "limited_simple_society" => "SociedadeSimplesLimitada",
    "simple_partnership_in_simple_name" => "SociedadeSimplesEmNomeColetivo",
    "simple_partnership_in_comandita_simples" => "SociedadeSimplesEmComanditaSimples",
    "binational_company" => "EmpresaBinacional",
    "employers_consortium" => "ConsorcioEmpregadores",
    "simple_consortium" => "ConsorcioSimples",
    "eireli_natureza_empresaria" => "EireliNaturezaEmpresaria",
    "eireli_natureza_simples" => "EireliNaturezaSimples",
    "notarial_service_" => "ServicoNotarial",
    "private_foundation" => "FundacaoPrivada",
    "autonomous_social_service" => "ServicoSocialAutonomo",
    "condominium_building" => "CondominioEdilicio",
    "prior_conciliation_commission" => "ComissaoConciliacaoPrevia",
    "mediation_arbitration_entity" => "EntidadeMediacaoArbitragem",
    "political_party" => "PartidoPolitico",
    "trade_union_entity" => "EntidadeSindical",
    "establishment_of_brazil_foreign_association_foundation" => "EstabelecimentoBrasilFundacaoAssociacaoEstrangeiras",
    "abroad_domiciliated_association_foundation" => "",
    "religious_organization" => "OrganizacaoReligiosa",
    "indigenous_community" => "ComunidadeIndigena",
    "private_fund" => "FundoPrivado",
    "associacao_priveted" => "AssociacaoPrivada"
  }

end
