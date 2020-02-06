class Admin::CategoriesController < ApplicationController
  def index
    @categories = Category.order(id: :desc).all
  end

  def new
    @category = Category.new
  end

  def create
    # @category = Product.new(product_params)

    # if @category.save
    #   redirect_to [:admin, :products], notice: 'Product created!'
    # else
    #   render :new
    # end
  end

end
