class ProductsAndGrowthRate < ApplicationRecord
  belongs_to :business_plan
  mount_uploader :product_image, ImageUploader

  def jan_sales
    self.sales_percentage_one.to_f * 0.01 * self.monthly_sales_volume.to_f
  end

  def feb_sales
    self.sales_percentage_two.to_f * 0.01 * self.monthly_sales_volume.to_f
  end

  def mar_sales
    self.sales_percentage_three.to_f * 0.01 * self.monthly_sales_volume.to_f
  end

  def apr_sales
    self.sales_percentage_four.to_f * 0.01 * self.monthly_sales_volume.to_f
  end

  def may_sales
    self.sales_percentage_five.to_f * 0.01 * self.monthly_sales_volume.to_f
  end

  def jun_sales
    self.sales_percentage_six.to_f * 0.01 * self.monthly_sales_volume.to_f
  end

  def jul_sales
    self.sales_percentage_seven.to_f * 0.01 * self.monthly_sales_volume.to_f
  end

  def aug_sales
    self.sales_percentage_eight.to_f * 0.01 * self.monthly_sales_volume.to_f
  end

  def sep_sales
    self.sales_percentage_nine.to_f * 0.01 * self.monthly_sales_volume.to_f
  end

  def oct_sales
    self.sales_percentage_ten.to_f * 0.01 * self.monthly_sales_volume.to_f
  end

  def nov_sales
    self.sales_percentage_eleven.to_f * 0.01 * self.monthly_sales_volume.to_f
  end

  def dec_sales
    self.sales_percentage_twelve.to_f * 0.01 * self.monthly_sales_volume.to_f
  end

  def annual_sales_1
    jan_sales + feb_sales + mar_sales + apr_sales + may_sales + jun_sales + jul_sales + aug_sales + sep_sales + oct_sales + nov_sales + dec_sales
  end

  def annual_sales_2
    annual_sales_1 * (1 + (self.sales_volume_growth_rate_two.to_f * 0.01))
  end

  def annual_sales_3
    annual_sales_2 * (1 + (self.sales_volume_growth_rate_three.to_f * 0.01))
  end

  def annual_sales_4
    annual_sales_3 * (1 + (self.sales_volume_growth_rate_four.to_f * 0.01))
  end

  def annual_sales_5
    annual_sales_4 * (1 + (self.sales_volume_growth_rate_five.to_f * 0.01))
  end


  def annual_price_2
    base_product_price * (1 + (self.unit_price_growth_rate_two.to_f * 0.01))
  end

  def annual_price_3
    annual_price_2 * (1 + (self.sales_volume_growth_rate_three.to_f * 0.01))
  end

  def annual_price_4
    annual_price_3 * (1 + (self.sales_volume_growth_rate_four.to_f * 0.01))
  end

  def annual_price_5
    annual_price_4 * (1 + (self.sales_volume_growth_rate_five.to_f * 0.01))
  end

  def revenue_1
    annual_sales_1 * base_product_price.to_f
  end
  def revenue_2
    annual_sales_2 * annual_price_2
  end
  def revenue_3
    annual_sales_3 * annual_price_3
  end
  def revenue_4
    annual_sales_4 * annual_price_4
  end
  def revenue_5
    annual_sales_5 * annual_price_5
  end

  

  def days_receivable_one
    annual_sales_1 * base_product_price.to_f * business_plan.receivable_days.to_f / 365
  end
  def days_receivable_two
    annual_sales_2 * annual_price_2 * business_plan.receivable_days.to_f / 365
  end
  def days_receivable_three
    annual_sales_3 * annual_price_3 * business_plan.receivable_days.to_f / 365
  end
  def days_receivable_four
    annual_sales_4 * annual_price_4 * business_plan.receivable_days.to_f / 365
  end
  def days_receivable_five
    annual_sales_5 * annual_price_5 * business_plan.receivable_days.to_f / 365
  end

end
