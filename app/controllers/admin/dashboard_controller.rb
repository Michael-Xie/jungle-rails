class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with :name => ENV['ADMIN_NAME'], :password => ENV['ADMIN_PASSWORD']

  def show
    @num_products = Product.count(:all)
    @num_categories = Category.count(:all)
  end
end
