class Position < ApplicationRecord
  belongs_to :business_plan
  mount_uploader :image, ImageUploader

  validates :bio, length: { maximum: 160 }

  # def total_salaries_one
  #   self.number_of_employees_one * (self.base_annual_salary * (1 + (self.salaries_cgr1 * 0.01)) * (1 + (self.salary_benefits * 0.01)))
  # end

  def total_salaries_one
    base_salary = self.base_annual_salary.to_f * (1 + (self.salaries_cgr1.to_f * 0.01))
    total_salary = base_salary.to_f * (1 + (self.salary_benefits.to_f * 0.01))
    total_salary * self.number_of_employees_one.to_f
  end

  def total_salaries_two
    base_salary = self.base_annual_salary.to_f * (1 + (self.salaries_cgr2.to_f * 0.01))
    total_salary = base_salary.to_f * (1 + (self.salary_benefits.to_f * 0.01))
    total_salary * self.number_of_employees_two.to_f
  end

  def total_salaries_three
    base_salary = self.base_annual_salary.to_f * (1 + (self.salaries_cgr3.to_f * 0.01))
    total_salary = base_salary.to_f * (1 + (self.salary_benefits.to_f * 0.01))
    total_salary * self.number_of_employees_three.to_f
  end

  def total_salaries_four
    base_salary = self.base_annual_salary.to_f * (1 + (self.salaries_cgr4.to_f * 0.01))
    total_salary = base_salary.to_f * (1 + (self.salary_benefits.to_f * 0.01))
    total_salary * self.number_of_employees_four.to_f
  end

  def total_salaries_five
    base_salary = self.base_annual_salary.to_f * (1 + (self.salaries_cgr5.to_f * 0.01))
    total_salary = base_salary.to_f * (1 + (self.salary_benefits.to_f * 0.01))
    total_salary * self.number_of_employees_five.to_f
  end
end