class HomeController < ApplicationController
  def index
    @random_laptops = Product.where(category: 'laptops').order('RANDOM()').limit(2)
    @random_computers = Product.where(category: 'computadoras').order('RANDOM()').first
    @random_cellphones = Product.where(category: 'celulares').order('RANDOM()').limit(2)
    @random_accessory = Product.where(category: 'accesorios').order('RANDOM()').first
  end
end

