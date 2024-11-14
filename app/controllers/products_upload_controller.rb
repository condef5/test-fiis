class ProductsUploadController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:edit, :update, :destroy, :show]

  # Acción para crear un nuevo producto
  def new
    @product = Product.new
    @products_by_category = Product.all.group_by(&:category)
  end

  # Acción para guardar un nuevo producto
  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_upload_path(@product), notice: 'Producto cargado exitosamente.'
    else
      @products_by_category = Product.all.group_by(&:category)
      render :new
    end
  end

  # Acción para editar un producto
  def edit
    # No necesitas código aquí, ya que `set_product` encuentra el producto
  end

  # Acción para actualizar un producto

  def update
    # byebug
    if @product.update(product_params)
      redirect_to products_upload_path(@product), notice: 'Producto actualizado exitosamente.'
    else
      render :edit
    end
  end
  
  

  # Acción para eliminar un producto
  def destroy
    @product.image.purge if @product.image.attached?  # Elimina la imagen adjunta, si existe
    if @product.destroy
      redirect_to new_products_upload_path, notice: 'Producto eliminado exitosamente.'
    else
      redirect_to products_upload_path(@product), alert: 'No se pudo eliminar el producto.'
    end
  end

  # Acción para mostrar los detalles de un producto
  def show
    # Rails renderiza automáticamente la vista `show.html.erb`
  end

  private

  # Parámetros permitidos para un producto
  def product_params
    params.require(:product).permit(:name, :description, :price, :category, :brand, :stock, :material, :dimension, :peso, :color, :caracteristicas, :image)
  end

  # Encuentra el producto usando el :id de los parámetros
  def set_product
    @product = Product.find(params[:id])
  end
end
