class ProductsController < ApplicationController
    def index
      # This can be used for a main products page if desired
      @products = Product.all
    end
  
    def show
      @product = Product.find(params[:id])
      @related_products = Product.where(category: @product.category).where.not(id: @product.id).limit(4)
    end
  
    def laptops
      @products = Product.where(category: 'laptops')
      render :category_view
    end
  
    def computadoras
      @products = Product.where(category: 'computadoras')
      render :category_view
    end
  
    def celulares
      @products = Product.where(category: 'celulares')
      render :category_view
    end
  
    def accesorios
      @products = Product.where(category: 'accesorios')
      render :category_view
    end
  end
  