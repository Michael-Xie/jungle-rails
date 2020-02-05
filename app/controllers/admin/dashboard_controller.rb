class Admin::DashboardController < ApplicationController
  def show
    @num_products = Product.count(:all)
    @num_categories = Category.count(:all)
  end
end
