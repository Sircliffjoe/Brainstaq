class BusinessPlan < ApplicationRecord
  validates :executive_summary, :products_and_services, :industry_analysis, :competition, 
  :swot, :operations, :enterprise_id, :marketing, :financial, :management, :appendices, 
  :vision, :mission, :objectives, :value_proposition, :company_tax_rate, :bank_interest_rate,
  :inflation_rate, presence: true

  belongs_to :enterprise
  belongs_to :user
  
  has_many :products_and_growth_rates, dependent: :destroy
  has_many :positions, dependent: :destroy
  has_many :marketing_expenses, dependent: :destroy
  has_many :milestones, dependent: :destroy
  has_many :swots, dependent: :destroy

  # has_rich_text :description
  

  accepts_nested_attributes_for :swots, allow_destroy: true
  accepts_nested_attributes_for :milestones, allow_destroy: true
  accepts_nested_attributes_for :marketing_expenses, allow_destroy: true
  accepts_nested_attributes_for :positions, allow_destroy: true
  accepts_nested_attributes_for :products_and_growth_rates, allow_destroy: true
  
  
  def raw_materials_op_cost_1
    self.raw_material_cost.to_f * ( 1 + (0.01 * self.direct_cgr1.to_f))
  end
  def raw_materials_op_cost_2
    self.raw_materials_op_cost_1.to_f * ( 1 + (0.01 * self.direct_cgr2.to_f))
  end
  def raw_materials_op_cost_3
    self.raw_materials_op_cost_2.to_f * ( 1 + (0.01 * self.direct_cgr3.to_f))
  end
  def raw_materials_op_cost_4
    self.raw_materials_op_cost_3.to_f * ( 1 + (0.01 * self.direct_cgr4.to_f))
  end
  def raw_materials_op_cost_5
    self.raw_materials_op_cost_4.to_f * ( 1 + (0.01 * self.direct_cgr5.to_f))
  end

  def direct_labour_op_cost_1
    self.direct_labour_cost.to_f * ( 1 + (0.01 * self.direct_cgr1.to_f))
  end
  def direct_labour_op_cost_2
    self.direct_labour_op_cost_1.to_f * ( 1 + (0.01 * self.direct_cgr2.to_f))
  end
  def direct_labour_op_cost_3
    self.direct_labour_op_cost_2.to_f * ( 1 + (0.01 * self.direct_cgr3.to_f))
  end
  def direct_labour_op_cost_4
    self.direct_labour_op_cost_3.to_f * ( 1 + (0.01 * self.direct_cgr4.to_f))
  end
  def direct_labour_op_cost_5
    self.direct_labour_op_cost_4.to_f * ( 1 + (0.01 * self.direct_cgr5.to_f))
  end

  # def factory_overhead_op_cost_1
  #   self.factory_overhead * ( 1 + (0.01 * self.direct_cgr1))
  # end
  # def factory_overhead_op_cost_2
  #   self.factory_overhead_op_cost_1 * ( 1 + (0.01 * self.direct_cgr2))
  # end
  # def factory_overhead_op_cost_3
  #   self.factory_overhead_op_cost_2 * ( 1 + (0.01 * self.direct_cgr3))
  # end
  # def factory_overhead_op_cost_4
  #   self.factory_overhead_op_cost_3 * ( 1 + (0.01 * self.direct_cgr4))
  # end
  # def factory_overhead_op_cost_5
  #   self.factory_overhead_op_cost_4 * ( 1 + (0.01 * self.direct_cgr5))
  # end

  def factory_overhead_op_cost_1
    self.factory_overhead.to_f * (1 + (0.01 * self.direct_cgr1.to_f))
  end

  def factory_overhead_op_cost_2
    factory_overhead_op_cost_1 * (1 + (0.01 * self.direct_cgr2.to_f))
  end

  def factory_overhead_op_cost_3
    factory_overhead_op_cost_2 * (1 + (0.01 * self.direct_cgr3.to_f))
  end

  def factory_overhead_op_cost_4
    factory_overhead_op_cost_3 * (1 + (0.01 * self.direct_cgr4.to_f))
  end

  def factory_overhead_op_cost_5
    factory_overhead_op_cost_4 * (1 + (0.01 * self.direct_cgr5.to_f))
  end


  def inbound_transport_op_cost_1
    self.inbound_transport.to_f * ( 1 + (0.01 * self.direct_cgr1.to_f))
  end
  def inbound_transport_op_cost_2
    self.inbound_transport_op_cost_1 * ( 1 + (0.01 * self.direct_cgr2.to_f))
  end
  def inbound_transport_op_cost_3
    self.inbound_transport_op_cost_2 * ( 1 + (0.01 * self.direct_cgr3.to_f))
  end
  def inbound_transport_op_cost_4
    self.inbound_transport_op_cost_3 * ( 1 + (0.01 * self.direct_cgr4.to_f))
  end
  def inbound_transport_op_cost_5
    self.inbound_transport_op_cost_4 * ( 1 + (0.01 * self.direct_cgr5.to_f))
  end
  

  def total_direct_op_cost_1
    self.raw_materials_op_cost_1 + self.direct_labour_op_cost_1 + self.factory_overhead_op_cost_1 + 
    self.inbound_transport_op_cost_1
  end
  def total_direct_op_cost_2
    self.raw_materials_op_cost_2 + self.direct_labour_op_cost_2 + self.factory_overhead_op_cost_2 + 
    self.inbound_transport_op_cost_2
  end
  def total_direct_op_cost_3
    self.raw_materials_op_cost_3 + self.direct_labour_op_cost_3 + self.factory_overhead_op_cost_3 + 
    self.inbound_transport_op_cost_3
  end
  def total_direct_op_cost_4
    self.raw_materials_op_cost_4 + self.direct_labour_op_cost_4 + self.factory_overhead_op_cost_4 + 
    self.inbound_transport_op_cost_4
  end
  def total_direct_op_cost_5
    self.raw_materials_op_cost_5 + self.direct_labour_op_cost_5 + self.factory_overhead_op_cost_5 + 
    self.inbound_transport_op_cost_5
  end

  def inventory_schedule_1
    (self.raw_materials_op_cost_1 + self.direct_labour_op_cost_1 + self.factory_overhead_op_cost_1 + self.inbound_transport_op_cost_1) * self.inventory_days.to_f / 365
  end

  def inventory_schedule_2
    (self.raw_materials_op_cost_2 + self.direct_labour_op_cost_2 + self.factory_overhead_op_cost_2 + self.inbound_transport_op_cost_2) * self.inventory_days.to_f / 365
  end

  def inventory_schedule_3
    (self.raw_materials_op_cost_3 + self.direct_labour_op_cost_3 + self.factory_overhead_op_cost_3 + self.inbound_transport_op_cost_3) * self.inventory_days.to_f / 365
  end

  def inventory_schedule_4
    (self.raw_materials_op_cost_4 + self.direct_labour_op_cost_4 + self.factory_overhead_op_cost_4 + self.inbound_transport_op_cost_4) * self.inventory_days.to_f / 365
  end

  def inventory_schedule_5
    (self.raw_materials_op_cost_5 + self.direct_labour_op_cost_5 + self.factory_overhead_op_cost_5 + self.inbound_transport_op_cost_5) * self.inventory_days.to_f / 365
  end

  def days_payable_1
    (self.rent_op_cost_1.to_f + self.utilities_op_cost_1.to_f + self.marketing_op_cost_1.to_f + self.admin_op_cost_1.to_f + 
      self.website_op_cost_1.to_f + self.telephone_op_cost_1.to_f + self.transport_op_cost_1.to_f + self.misc_op_cost_1.to_f + self.salaries_one.to_f) * self.payable_days.to_f/365
  end

  def days_payable_2
    (self.rent_op_cost_2.to_f + self.utilities_op_cost_2.to_f + self.marketing_op_cost_2.to_f + self.admin_op_cost_2.to_f + 
      self.website_op_cost_2.to_f + self.telephone_op_cost_2.to_f + self.transport_op_cost_2.to_f + self.misc_op_cost_2.to_f + self.salaries_two.to_f) * self.payable_days.to_f/365
  end

  def days_payable_3
    (self.rent_op_cost_3.to_f + self.utilities_op_cost_3.to_f + self.marketing_op_cost_3.to_f + self.admin_op_cost_3.to_f + 
      self.website_op_cost_3.to_f + self.telephone_op_cost_3.to_f + self.transport_op_cost_3.to_f + self.misc_op_cost_3.to_f + self.salaries_three.to_f) * self.payable_days.to_f/365
  end

  def days_payable_4
    (self.rent_op_cost_4.to_f + self.utilities_op_cost_4.to_f + self.marketing_op_cost_4.to_f + self.admin_op_cost_4.to_f + 
      self.website_op_cost_4.to_f + self.telephone_op_cost_4.to_f + self.transport_op_cost_4.to_f + self.misc_op_cost_4.to_f + self.salaries_four.to_f) * self.payable_days.to_f/365
  end

  def days_payable_5
    (self.rent_op_cost_5.to_f + self.utilities_op_cost_5.to_f + self.marketing_op_cost_5.to_f + self.admin_op_cost_5.to_f + 
      self.website_op_cost_5.to_f + self.telephone_op_cost_5.to_f + self.transport_op_cost_5.to_f + self.misc_op_cost_5.to_f + self.salaries_five.to_f) * self.payable_days.to_f/365
  end

  def rent_op_cost_1
    self.rent_cost.to_f * ( 1 + (0.01 * self.rent_cgr1.to_f))
  end
  def rent_op_cost_2
    self.rent_op_cost_1 * ( 1 + (0.01 * self.rent_cgr2.to_f))
  end
  def rent_op_cost_3
    self.rent_op_cost_2 * ( 1 + (0.01 * self.rent_cgr3.to_f))
  end
  def rent_op_cost_4
    self.rent_op_cost_3 * ( 1 + (0.01 * self.rent_cgr4.to_f))
  end
  def rent_op_cost_5
    self.rent_op_cost_4 * ( 1 + (0.01 * self.rent_cgr5.to_f))
  end

  def utilities_op_cost_1
    self.utilities_cost.to_f * ( 1 + (0.01 * self.utilities_cgr1.to_f))
  end
  def utilities_op_cost_2
    self.utilities_op_cost_1 * ( 1 + (0.01 * self.utilities_cgr2.to_f))
  end
  def utilities_op_cost_3
    self.utilities_op_cost_2 * ( 1 + (0.01 * self.utilities_cgr3.to_f))
  end
  def utilities_op_cost_4
    self.utilities_op_cost_3 * ( 1 + (0.01 * self.utilities_cgr4.to_f))
  end
  def utilities_op_cost_5
    self.utilities_op_cost_4 * ( 1 + (0.01 * self.utilities_cgr5.to_f))
  end

  def marketing_op_cost_1
    self.marketing_cost.to_f * ( 1 + (0.01 * self.marketing_cgr1.to_f))
  end
  def marketing_op_cost_2
    self.marketing_op_cost_1 * ( 1 + (0.01 * self.marketing_cgr2.to_f))
  end
  def marketing_op_cost_3
    self.marketing_op_cost_2 * ( 1 + (0.01 * self.marketing_cgr3.to_f))
  end
  def marketing_op_cost_4
    self.marketing_op_cost_3 * ( 1 + (0.01 * self.marketing_cgr4.to_f))
  end
  def marketing_op_cost_5
    self.marketing_op_cost_4 * ( 1 + (0.01 * self.marketing_cgr5.to_f))
  end

  def admin_op_cost_1
    self.admin_cost.to_f * ( 1 + (0.01 * self.admin_cgr1.to_f))
  end
  def admin_op_cost_2
    self.admin_op_cost_1 * ( 1 + (0.01 * self.admin_cgr2.to_f))
  end
  def admin_op_cost_3
    self.admin_op_cost_2 * ( 1 + (0.01 * self.admin_cgr3.to_f))
  end
  def admin_op_cost_4
    self.admin_op_cost_3 * ( 1 + (0.01 * self.admin_cgr4.to_f))
  end
  def admin_op_cost_5
    self.admin_op_cost_4 * ( 1 + (0.01 * self.admin_cgr5.to_f))
  end

  def website_op_cost_1
    self.website_cost.to_f * ( 1 + (0.01 * self.maintenance_cgr1.to_f))
  end
  def website_op_cost_2
    self.website_op_cost_1 * ( 1 + (0.01 * self.maintenance_cgr2.to_f))
  end
  def website_op_cost_3
    self.website_op_cost_2 * ( 1 + (0.01 * self.maintenance_cgr3.to_f))
  end
  def website_op_cost_4
    self.website_op_cost_3 * ( 1 + (0.01 * self.maintenance_cgr4.to_f))
  end
  def website_op_cost_5
    self.website_op_cost_4 * ( 1 + (0.01 * self.maintenance_cgr5.to_f))
  end

  def telephone_op_cost_1
    self.telephone_cost.to_f * ( 1 + (0.01 * self.phone_cgr1.to_f))
  end
  def telephone_op_cost_2
    self.telephone_op_cost_1 * ( 1 + (0.01 * self.phone_cgr2.to_f))
  end
  def telephone_op_cost_3
    self.telephone_op_cost_2 * ( 1 + (0.01 * self.phone_cgr3.to_f))
  end
  def telephone_op_cost_4
    self.telephone_op_cost_3 * ( 1 + (0.01 * self.phone_cgr4.to_f))
  end
  def telephone_op_cost_5
    self.telephone_op_cost_4 * ( 1 + (0.01 * self.phone_cgr5.to_f))
  end

  def transport_op_cost_1
    self.transport_cost.to_f * ( 1 + (0.01 * self.transport_cgr1.to_f))
  end
  def transport_op_cost_2
    self.transport_op_cost_1 * ( 1 + (0.01 * self.transport_cgr2.to_f))
  end
  def transport_op_cost_3
    self.transport_op_cost_2 * ( 1 + (0.01 * self.transport_cgr3.to_f))
  end
  def transport_op_cost_4
    self.transport_op_cost_3 * ( 1 + (0.01 * self.transport_cgr4.to_f))
  end
  def transport_op_cost_5
    self.transport_op_cost_4 * ( 1 + (0.01 * self.transport_cgr5.to_f))
  end

  def misc_op_cost_1
    self.misc.to_f * ( 1 + (0.01 * self.misc_cgr1.to_f))
  end
  def misc_op_cost_2
    self.misc_op_cost_1 * ( 1 + (0.01 * self.misc_cgr2.to_f))
  end
  def misc_op_cost_3
    self.misc_op_cost_2 * ( 1 + (0.01 * self.misc_cgr3.to_f))
  end
  def misc_op_cost_4
    self.misc_op_cost_3 * ( 1 + (0.01 * self.misc_cgr4.to_f))
  end
  def misc_op_cost_5
    self.misc_op_cost_4 * ( 1 + (0.01 * self.misc_cgr5.to_f))
  end

  def total_op_expenses_1
    self.rent_op_cost_1 + self.utilities_op_cost_1 + self.marketing_op_cost_1 + self.admin_op_cost_1 + 
    self.website_op_cost_1 + self.telephone_op_cost_1 + self.transport_op_cost_1 + self.misc_op_cost_1 + 
    self.total_charge_1 + self.salaries_one
  end
  def total_op_expenses_2
    self.rent_op_cost_2 + self.utilities_op_cost_2 + self.marketing_op_cost_2 + self.admin_op_cost_2 + 
    self.website_op_cost_2 + self.telephone_op_cost_2 + self.transport_op_cost_2 + self.misc_op_cost_2 + 
    self.total_charge_2 + self.salaries_two
  end
  def total_op_expenses_3
    self.rent_op_cost_3 + self.utilities_op_cost_3 + self.marketing_op_cost_3 + self.admin_op_cost_3 + 
    self.website_op_cost_3 + self.telephone_op_cost_3 + self.transport_op_cost_3 + self.misc_op_cost_3 + 
    self.total_charge_3 + self.salaries_three
  end
  def total_op_expenses_4
    self.rent_op_cost_4 + self.utilities_op_cost_4 + self.marketing_op_cost_4 + self.admin_op_cost_4 + 
    self.website_op_cost_4 + self.telephone_op_cost_4 + self.transport_op_cost_4 + self.misc_op_cost_4 + 
    self.total_charge_4 + self.salaries_four
  end
  def total_op_expenses_5
    self.rent_op_cost_5 + self.utilities_op_cost_5 + self.marketing_op_cost_5 + self.admin_op_cost_5 + 
    self.website_op_cost_5 + self.telephone_op_cost_5 + self.transport_op_cost_5 + self.misc_op_cost_5 + 
    self.total_charge_5 + self.salaries_five
  end

  def total_add_1
    self.land.to_f + self.utilities.to_f + self.vehicles.to_f + self.equipment.to_f + self.office_supplies.to_f + self.rent.to_f
  end

  def land_add_2
    0
  end
  def building_add_2
    if 3 % (1 / (self.dep_building.to_f * 0.01)) < 1 
      then self.rent.to_f * ((1 + self.inflation_rate.to_f) ** 3) 
    else 
      0 
    end
  end
  def furniture_add_2
    if 3 % (1 / (self.dep_furniture.to_f * 0.01)) < 1 
      then self.office_supplies.to_f * ((1 + self.inflation_rate.to_f) ** 3) 
    else 
      0 
    end
  end
  def machinery_add_2
    if 3 % (1 / (self.dep_machinery.to_f * 0.01)) < 1 
      then self.equipment.to_f * ((1 + self.inflation_rate.to_f) ** 3) 
    else 
      0 
    end
  end
  def vehicles_add_2
    if 3 % (1 / (self.dep_vehicles.to_f * 0.01)) < 1 
      then self.vehicles.to_f * ((1 + self.inflation_rate.to_f) ** 3) 
    else 
      0 
    end
  end
  def installations_add_2
    if 3 % (1 / (self.dep_installations.to_f * 0.01)) < 1 
      then self.utilities.to_f * ((1 + self.inflation_rate.to_f) ** 3) 
    else 
      0 
    end
  end
  def total_add_2
    self.land_add_2 + self.building_add_2 + self.furniture_add_2 + self.machinery_add_2 + self.vehicles_add_2 + self.installations_add_2
  end

  def land_add_3
    0
  end
  def building_add_3
    if 4 % (1 / (self.dep_building.to_f * 0.01)) < 1 
      then self.rent.to_f * ((1 + self.inflation_rate.to_f) ** 4) 
    else 
      0 
    end
  end
  def furniture_add_3
    if 4 % (1 / (self.dep_furniture.to_f * 0.01)) < 1 
      then self.office_supplies.to_f * ((1 + self.inflation_rate.to_f) ** 4) 
    else 
      0 
    end
  end
  def machinery_add_3
    if 4 % (1 / (self.dep_machinery.to_f * 0.01)) < 1 
      then self.equipment.to_f * ((1 + self.inflation_rate.to_f) ** 4) 
    else 
      0 
    end
  end
  def vehicles_add_3
    if 4 % (1 / (self.dep_vehicles.to_f * 0.01)) < 1 
      then self.vehicles.to_f * ((1 + self.inflation_rate.to_f) ** 4) 
    else 
      0 
    end
  end
  def installations_add_3
    if 4 % (1 / (self.dep_installations.to_f * 0.01)) < 1 
      then self.utilities.to_f * ((1 + self.inflation_rate.to_f) ** 4) 
    else 
      0 
    end
  end
  def total_add_3
    self.land_add_3 + self.building_add_3 + self.furniture_add_3 + self.machinery_add_3 + self.vehicles_add_3 + self.installations_add_3
  end

  def land_add_4
    0
  end
  def building_add_4
    if 5 % (1 / (self.dep_building.to_f * 0.01)) < 1 
      then self.rent.to_f * ((1 + self.inflation_rate.to_f) ** 5) 
    else 
      0 
    end
  end
  def furniture_add_4
    if 5 % (1 / (self.dep_furniture.to_f * 0.01)) < 1 
      then self.office_supplies.to_f * ((1 + self.inflation_rate.to_f) ** 5) 
    else 
      0 
    end
  end
  def machinery_add_4
    if 5 % (1 / (self.dep_machinery.to_f * 0.01)) < 1 
      then self.equipment.to_f * ((1 + self.inflation_rate.to_f) ** 5) 
    else 
      0 
    end
  end
  def vehicles_add_4
    if 5 % (1 / (self.dep_vehicles.to_f * 0.01)) < 1 
      then self.vehicles.to_f * ((1 + self.inflation_rate.to_f) ** 5) 
    else 
      0 
    end
  end
  def installations_add_4
    if 5 % (1 / (self.dep_installations.to_f * 0.01)) < 1 
      then self.utilities.to_f * ((1 + self.inflation_rate.to_f) ** 5) 
    else 
      0 
    end
  end
  def total_add_4
    self.land_add_4 + self.building_add_4 + self.furniture_add_4 + self.machinery_add_4 + self.vehicles_add_4 + self.installations_add_4
  end

  def land_add_5
    0
  end
  def building_add_5
    if 6 % (1 / (self.dep_building.to_f * 0.01)) < 1 
      then self.rent.to_f * ((1 + self.inflation_rate.to_f) ** 6) 
    else 
      0 
    end
  end
  def furniture_add_5
    if 6 % (1 / (self.dep_furniture.to_f * 0.01)) < 1 
      then self.office_supplies.to_f * ((1 + self.inflation_rate.to_f) ** 6) 
    else 
      0 
    end
  end
  def machinery_add_5
    if 6 % (1 / (self.dep_machinery.to_f * 0.01)) < 1 
      then self.equipment.to_f * ((1 + self.inflation_rate.to_f) ** 6) 
    else 
      0 
    end
  end
  def vehicles_add_5
    if 6 % (1 / (self.dep_vehicles.to_f * 0.01)) < 1 
      then self.vehicles.to_f * ((1 + self.inflation_rate.to_f) ** 6) 
    else 
      0 
    end
  end
  def installations_add_5
    if 6 % (1 / (self.dep_installations.to_f * 0.01)) < 1 
      then self.utilities.to_f * ((1 + self.inflation_rate.to_f) ** 6) 
    else 
      0 
    end
  end
  def total_add_5
    self.land_add_5 + self.building_add_5 + self.furniture_add_5 + self.machinery_add_5 + self.vehicles_add_5 + self.installations_add_5
  end

  def land_close_2
    self.land.to_f + self.land_add_2
  end
  def building_close_2
    self.rent.to_f + self.building_add_2
  end
  def furniture_close_2
    self.office_supplies.to_f + self.furniture_add_2
  end
  def machinery_close_2
    self.equipment.to_f + self.machinery_add_2
  end
  def vehicles_close_2
    self.vehicles.to_f + self.vehicles_add_2
  end
  def installations_close_2
    self.utilities.to_f + self.installations_add_2
  end
  def total_close_2
    (self.land_close_2 + self.building_close_2 + self.furniture_close_2 + self.machinery_close_2 + self.vehicles_close_2 + self.installations_close_2)
  end

  def land_close_3
    self.land_close_2 + self.land_add_3
  end
  def building_close_3
    self.building_close_2 + self.building_add_3
  end
  def furniture_close_3
    self.furniture_close_2 + self.furniture_add_3
  end
  def machinery_close_3
    self.machinery_close_2 + self.machinery_add_3
  end
  def vehicles_close_3
    self.vehicles_close_2 + self.vehicles_add_3
  end
  def installations_close_3
    self.installations_close_2 + self.installations_add_3
  end
  def total_close_3
    (self.land_close_3 + self.building_close_3 + self.furniture_close_3 + self.machinery_close_3 + self.vehicles_close_3 + self.installations_close_3)
  end

  def land_close_4
    self.land_close_3 + self.land_add_4
  end
  def building_close_4
    self.building_close_3 + self.building_add_4
  end
  def furniture_close_4
    self.furniture_close_3 + self.furniture_add_4
  end
  def machinery_close_4
    self.machinery_close_3 + self.machinery_add_4
  end
  def vehicles_close_4
    self.vehicles_close_3 + self.vehicles_add_4
  end
  def installations_close_4
    self.installations_close_3 + self.installations_add_4
  end
  def total_close_4
    (self.land_close_4 + self.building_close_4 + self.furniture_close_4 + self.machinery_close_4 + self.vehicles_close_4 + self.installations_close_4)
  end

  def land_close_5
    self.land_close_4 + self.land_add_5
  end
  def building_close_5
    self.building_close_4 + self.building_add_5
  end
  def furniture_close_5
    self.furniture_close_4 + self.furniture_add_5
  end
  def machinery_close_5
    self.machinery_close_4 + self.machinery_add_5
  end
  def vehicles_close_5
    self.vehicles_close_4 + self.vehicles_add_5
  end
  def installations_close_5
    self.installations_close_4 + self.installations_add_5
  end
  def total_close_5
    (self.land_close_5 + self.building_close_5 + self.furniture_close_5 + self.machinery_close_5 + self.vehicles_close_5 + self.installations_close_5)
  end

  def land_charge_1
    0
  end
  def building_charge_1
    self.rent.to_f * self.dep_building.to_f * 0.01
  end
  def furniture_charge_1
    self.office_supplies.to_f * self.dep_building.to_f * 0.01
  end
  def machinery_charge_1
    self.equipment.to_f * self.dep_machinery.to_f * 0.01
  end
  def vehicles_charge_1
    self.vehicles.to_f * self.dep_vehicles.to_f * 0.01
  end
  def installations_charge_1
    self.utilities.to_f * self.dep_installations.to_f * 0.01
  end
  def total_charge_1
    (self.land_charge_1.to_f + self.building_charge_1.to_f + self.furniture_charge_1.to_f + self.machinery_charge_1.to_f + self.vehicles_charge_1.to_f + self.installations_charge_1.to_f)
  end

  def land_charge_2
    0
  end
  def building_charge_2
    self.building_close_2 * self.dep_building.to_f * 0.01
  end
  def furniture_charge_2
    self.furniture_close_2 * self.dep_building.to_f * 0.01
  end
  def machinery_charge_2
    self.machinery_close_2 * self.dep_machinery.to_f * 0.01
  end
  def vehicles_charge_2
    self.vehicles_close_2 * self.dep_vehicles.to_f * 0.01
  end
  def installations_charge_2
    self.installations_close_2 * self.dep_installations.to_f * 0.01
  end
  def total_charge_2
    (self.land_charge_2 + self.building_charge_2 + self.furniture_charge_2 + self.machinery_charge_2 + self.vehicles_charge_2 + self.installations_charge_2)
  end

  def land_charge_3
    0
  end
  def building_charge_3
    self.building_close_3 * self.dep_building.to_f * 0.01
  end
  def furniture_charge_3
    self.furniture_close_3 * self.dep_building.to_f * 0.01
  end
  def machinery_charge_3
    self.machinery_close_3 * self.dep_machinery.to_f * 0.01
  end
  def vehicles_charge_3
    self.vehicles_close_3 * self.dep_vehicles.to_f * 0.01
  end
  def installations_charge_3
    self.installations_close_3 * self.dep_installations.to_f * 0.01
  end
  def total_charge_3
    (self.land_charge_3 + self.building_charge_3 + self.furniture_charge_3 + self.machinery_charge_3 + self.vehicles_charge_3 + self.installations_charge_3)
  end

  def land_charge_4
    0
  end
  def building_charge_4
    self.building_close_4 * self.dep_building.to_f * 0.01
  end
  def furniture_charge_4
    self.furniture_close_4 * self.dep_building.to_f * 0.01
  end
  def machinery_charge_4
    self.machinery_close_4 * self.dep_machinery.to_f * 0.01
  end
  def vehicles_charge_4
    self.vehicles_close_4 * self.dep_vehicles.to_f * 0.01
  end
  def installations_charge_4
    self.installations_close_4 * self.dep_installations.to_f * 0.01
  end
  def total_charge_4
    (self.land_charge_4 + self.building_charge_4 + self.furniture_charge_4 + self.machinery_charge_4 + self.vehicles_charge_4 + self.installations_charge_4)
  end

  def land_charge_5
    0
  end
  def building_charge_5
    self.building_close_5 * self.dep_building.to_f * 0.01
  end
  def furniture_charge_5
    self.furniture_close_5 * self.dep_building.to_f * 0.01
  end
  def machinery_charge_5
    self.machinery_close_5 * self.dep_machinery.to_f * 0.01
  end
  def vehicles_charge_5
    self.vehicles_close_5 * self.dep_vehicles.to_f * 0.01
  end
  def installations_charge_5
    self.installations_close_5 * self.dep_installations.to_f * 0.01
  end
  def total_charge_5
    (self.land_charge_5 + self.building_charge_5 + self.furniture_charge_5 + self.machinery_charge_5 + self.vehicles_charge_5 + self.installations_charge_5)
  end

  def land_acc_2
    0
  end
  def building_acc_2
    self.building_charge_1
  end
  def furniture_acc_2
    self.furniture_charge_1
  end
  def machinery_acc_2
    self.machinery_charge_1
  end
  def vehicles_acc_2
    self.vehicles_charge_1
  end
  def installations_acc_2
    self.installations_charge_1
  end
  def total_acc_2
    (self.land_acc_2 + self.building_acc_2 + self.furniture_acc_2 + self.machinery_acc_2 + self.vehicles_acc_2 + self.installations_acc_2)
  end

  def land_acc_3
    0
  end
  def building_acc_3
    self.building_acc_2 + self.building_charge_2
  end
  def furniture_acc_3
    self.furniture_acc_2 + self.furniture_charge_2
  end
  def machinery_acc_3
    self.machinery_acc_2 + self.machinery_charge_2
  end
  def vehicles_acc_3
    self.vehicles_acc_2 + self.vehicles_charge_2
  end
  def installations_acc_3
    self.installations_acc_2 + self.installations_charge_2
  end
  def total_acc_3
    (self.land_acc_3 + self.building_acc_3 + self.furniture_acc_3 + self.machinery_acc_3 + self.vehicles_acc_3 + self.installations_acc_3)
  end

  def land_acc_4
    0
  end
  def building_acc_4
    self.building_acc_3 + self.building_charge_3
  end
  def furniture_acc_4
    self.furniture_acc_3 + self.furniture_charge_3
  end
  def machinery_acc_4
    self.machinery_acc_3 + self.machinery_charge_3
  end
  def vehicles_acc_4
    self.vehicles_acc_3 + self.vehicles_charge_3
  end
  def installations_acc_4
    self.installations_acc_3 + self.installations_charge_3
  end
  def total_acc_4
    (self.land_acc_4 + self.building_acc_4 + self.furniture_acc_4 + self.machinery_acc_4 + self.vehicles_acc_4 + self.installations_acc_4)
  end

  def land_acc_5
    0
  end
  def building_acc_5
    self.building_acc_4 + self.building_charge_4
  end
  def furniture_acc_5
    self.furniture_acc_4 + self.furniture_charge_4
  end
  def machinery_acc_5
    self.machinery_acc_4 + self.machinery_charge_4
  end
  def vehicles_acc_5
    self.vehicles_acc_4 + self.vehicles_charge_4
  end
  def installations_acc_5
    self.installations_acc_4 + self.installations_charge_4
  end
  def total_acc_5
    (self.land_acc_5 + self.building_acc_5 + self.furniture_acc_5 + self.machinery_acc_5 + self.vehicles_acc_5 + self.installations_acc_5)
  end


  def land_acc_close_2
    0
  end
  def building_acc_close_2
    self.building_acc_2 + self.building_charge_2
  end
  def furniture_acc_close_2
    self.furniture_acc_2 + self.furniture_charge_2
  end
  def machinery_acc_close_2
    self.machinery_acc_2 + self.machinery_charge_2
  end
  def vehicles_acc_close_2
    self.vehicles_acc_2 + self.vehicles_charge_2
  end
  def installations_acc_close_2
    self.installations_acc_2 + self.installations_charge_2
  end
  def total_acc_close_2
    (self.land_acc_close_2 + self.building_acc_close_2 + self.furniture_acc_close_2 + self.machinery_acc_close_2 + 
      self.vehicles_acc_close_2 + self.installations_acc_close_2)
  end

  def land_acc_close_3
    0
  end
  def building_acc_close_3
    self.building_acc_3 + self.building_charge_3
  end
  def furniture_acc_close_3
    self.furniture_acc_3 + self.furniture_charge_3
  end
  def machinery_acc_close_3
    self.machinery_acc_3 + self.machinery_charge_3
  end
  def vehicles_acc_close_3
    self.vehicles_acc_3 + self.vehicles_charge_3
  end
  def installations_acc_close_3
    self.installations_acc_3 + self.installations_charge_3
  end
  def total_acc_close_3
    (self.land_acc_close_3 + self.building_acc_close_3 + self.furniture_acc_close_3 + self.machinery_acc_close_3 + 
      self.vehicles_acc_close_3 + self.installations_acc_close_3)
  end

  def land_acc_close_4
    0
  end
  def building_acc_close_4
    self.building_acc_4 + self.building_charge_4
  end
  def furniture_acc_close_4
    self.furniture_acc_4 + self.furniture_charge_4
  end
  def machinery_acc_close_4
    self.machinery_acc_4 + self.machinery_charge_4
  end
  def vehicles_acc_close_4
    self.vehicles_acc_4 + self.vehicles_charge_4
  end
  def installations_acc_close_4
    self.installations_acc_4 + self.installations_charge_4
  end
  def total_acc_close_4
    (self.land_acc_close_4 + self.building_acc_close_4 + self.furniture_acc_close_4 + self.machinery_acc_close_4 + 
      self.vehicles_acc_close_4 + self.installations_acc_close_4)
  end

  def land_acc_close_5
    0
  end
  def building_acc_close_5
    self.building_acc_4 + self.building_charge_5
  end
  def furniture_acc_close_5
    self.furniture_acc_4 + self.furniture_charge_5
  end
  def machinery_acc_close_5
    self.machinery_acc_5 + self.machinery_charge_5
  end
  def vehicles_acc_close_5
    self.vehicles_acc_5 + self.vehicles_charge_5
  end
  def installations_acc_close_5
    self.installations_acc_5 + self.installations_charge_5
  end
  def total_acc_close_5
    (self.land_acc_close_5 + self.building_acc_close_5 + self.furniture_acc_close_5 + self.machinery_acc_close_5 + 
      self.vehicles_acc_close_5 + self.installations_acc_close_5)
  end

  def land_net_1
    self.land.to_f - self.land_charge_1
  end
  def building_net_1
    self.rent.to_f - self.building_charge_1
  end
  def furniture_net_1
    self.office_supplies.to_f - self.furniture_charge_1
  end
  def machinery_net_1
    self.equipment.to_f - self.machinery_charge_1
  end
  def vehicles_net_1
    self.vehicles.to_f - self.vehicles_charge_1
  end
  def installations_net_1
    self.utilities.to_f - self.installations_charge_1
  end
  def total_net_1
    (self.land_net_1 + self.building_net_1 + self.furniture_net_1 + self.machinery_net_1 + self.vehicles_net_1 + self.installations_net_1)
  end

  def land_net_2
    self.land_close_2 - self.land_acc_close_2
  end
  def building_net_2
    self.building_close_2 - self.building_acc_close_2
  end
  def furniture_net_2
    self.furniture_close_2 - self.furniture_acc_close_2
  end
  def machinery_net_2
    self.machinery_close_2 - self.machinery_acc_close_2
  end
  def vehicles_net_2
    self.vehicles_close_2 - self.vehicles_acc_close_2
  end
  def installations_net_2
    self.installations_close_2 - self.installations_acc_close_2
  end
  def total_net_2
    (self.land_net_2 + self.building_net_2 + self.furniture_net_2 + self.machinery_net_2 + self.vehicles_net_2 + self.installations_net_2)
  end
  
  def land_net_3
    self.land_close_3 - self.land_acc_close_3
  end
  def building_net_3
    self.building_close_3 - self.building_acc_close_3
  end
  def furniture_net_3
    self.furniture_close_3 - self.furniture_acc_close_3
  end
  def machinery_net_3
    self.machinery_close_3 - self.machinery_acc_close_3
  end
  def vehicles_net_3
    self.vehicles_close_3 - self.vehicles_acc_close_3
  end
  def installations_net_3
    self.installations_close_3 - self.installations_acc_close_3
  end
  def total_net_3
    (self.land_net_3 + self.building_net_3 + self.furniture_net_3 + self.machinery_net_3 + self.vehicles_net_3 + self.installations_net_3)
  end

  def land_net_4
    self.land_close_4 - self.land_acc_close_4
  end
  def building_net_4
    self.building_close_4 - self.building_acc_close_4
  end
  def furniture_net_4
    self.furniture_close_4 - self.furniture_acc_close_4
  end
  def machinery_net_4
    self.machinery_close_4 - self.machinery_acc_close_4
  end
  def vehicles_net_4
    self.vehicles_close_4 - self.vehicles_acc_close_4
  end
  def installations_net_4
    self.installations_close_4 - self.installations_acc_close_4
  end
  def total_net_4
    (self.land_net_4 + self.building_net_4 + self.furniture_net_4 + self.machinery_net_4 + self.vehicles_net_4 + self.installations_net_4)
  end

  def land_net_5
    self.land_close_5 - self.land_acc_close_5
  end
  def building_net_5
    self.building_close_5 - self.building_acc_close_5
  end
  def furniture_net_5
    self.furniture_close_5 - self.furniture_acc_close_5
  end
  def machinery_net_5
    self.machinery_close_5 - self.machinery_acc_close_5
  end
  def vehicles_net_5
    self.vehicles_close_5 - self.vehicles_acc_close_5
  end
  def installations_net_5
    self.installations_close_5 - self.installations_acc_close_5
  end
  def total_net_5
    (self.land_net_5 + self.building_net_5 + self.furniture_net_5 + self.machinery_net_5 + self.vehicles_net_5 + self.installations_net_5)
  end

  def salaries_one
    positions.sum(&:total_salaries_one)
  end
  def salaries_two
    positions.sum(&:total_salaries_two)
  end
  def salaries_three
    positions.sum(&:total_salaries_three)
  end
  def salaries_four
    positions.sum(&:total_salaries_four)
  end
  def salaries_five
    positions.sum(&:total_salaries_five)
  end

  def total_revenue_1
    products_and_growth_rates.sum(&:revenue_1)
  end
  def total_revenue_2
    products_and_growth_rates.sum(&:revenue_2)
  end
  def total_revenue_3
    products_and_growth_rates.sum(&:revenue_3)
  end
  def total_revenue_4
    products_and_growth_rates.sum(&:revenue_4)
  end
  def total_revenue_5
    products_and_growth_rates.sum(&:revenue_5)
  end
  
end
