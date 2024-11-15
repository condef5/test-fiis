# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

require "open-uri"
require "active_support/inflector"

puts "Cleaning database..."
Product.destroy_all

puts "Creating products..."

products = [
  {
    name: "Mouse Logitech MX Master 3",
    description: "Mouse inalámbrico ergonómico",
    price: 100.00,
    brand: "Logitech",
    stock: 30,
    category: "accesorios",
    material: "Plástico",
    dimension: "126x84x51 mm",
    peso: "141 g",
    color: "Negro",
    caracteristicas: "Bluetooth, USB-C, DPI ajustable",
    image_filename: "logitech_mx.jpg",
  },
  {
    name: "Teclado Razer BlackWidow",
    description: "Teclado mecánico para gaming",
    price: 150.00,
    brand: "Razer",
    stock: 20,
    category: "accesorios",
    material: "Plástico",
    dimension: "450x150x40 mm",
    peso: "1.2 kg",
    color: "Negro",
    caracteristicas: "Switches mecánicos, retroiluminación RGB",
    image_filename: "razer_blackwidow.jpg",
  },
  {
    name: "Audífonos Sony WH-1000XM4",
    description: "Audífonos inalámbricos con cancelación de ruido",
    price: 300.00,
    brand: "Sony",
    stock: 15,
    category: "accesorios",
    material: "Plástico",
    dimension: "174x76x187 mm",
    peso: "254 g",
    color: "Negro",
    caracteristicas: "Bluetooth, cancelación de ruido activa, 30 horas de batería",
    image_filename: "sony_wh1000xm4.jpg",
  },
  {
    name: "Cargador Anker PowerPort",
    description: "Cargador rápido con múltiples puertos",
    price: 50.00,
    brand: "Anker",
    stock: 40,
    category: "accesorios",
    material: "Plástico",
    dimension: "65x65x29 mm",
    peso: "150 g",
    color: "Blanco",
    caracteristicas: "USB-A y USB-C, carga rápida",
    image_filename: "anker_powerport.jpg",
  },

  # Laptops
  {
    name: "MacBook Pro 14",
    description: "Laptop profesional con chip M2 Pro",
    price: 1999.99,
    brand: "Apple",
    stock: 10,
    category: "laptops",
    material: "Aluminio",
    dimension: "312.6x221.2x15.5 mm",
    peso: "1.6 kg",
    color: "Gris Espacial",
    caracteristicas: "Chip M2 Pro, 16GB RAM, 512GB SSD, Pantalla Liquid Retina XDR",
    image_filename: "macbook_pro.jpg",
  },
  {
    name: "ThinkPad X1 Carbon",
    description: "Laptop empresarial ultraligera",
    price: 1499.99,
    brand: "Lenovo",
    stock: 15,
    category: "laptops",
    material: "Fibra de carbono",
    dimension: "315x222x14.9 mm",
    peso: "1.13 kg",
    color: "Negro",
    caracteristicas: "Intel Core i7, 16GB RAM, 1TB SSD, Pantalla 4K",
    image_filename: "thinkpad_x1.jpg",
  },

  # Computadoras
  {
    name: "iMac 24 M1",
    description: "Desktop todo en uno con pantalla Retina 4.5K",
    price: 1499.99,
    brand: "Apple",
    stock: 8,
    category: "computadoras",
    material: "Aluminio y vidrio",
    dimension: "547x461x147 mm",
    peso: "4.48 kg",
    color: "Azul",
    caracteristicas: "Chip M1, 8GB RAM, 256GB SSD, Pantalla Retina 4.5K",
    image_filename: "imac_24.jpg",
  },
  {
    name: "HP Pavilion Gaming Desktop",
    description: "Torre gaming de alto rendimiento",
    price: 1299.99,
    brand: "HP",
    stock: 12,
    category: "computadoras",
    material: "Metal y plástico",
    dimension: "155x293x364 mm",
    peso: "5.7 kg",
    color: "Negro/Verde",
    caracteristicas: "AMD Ryzen 7, RTX 3060, 16GB RAM, 1TB SSD",
    image_filename: "hp_pavilion.jpg",
  },

  # Celulares
  {
    name: "iPhone 15 Pro",
    description: "Smartphone de última generación con chip A17 Pro",
    price: 999.99,
    brand: "Apple",
    stock: 25,
    category: "celulares",
    material: "Titanio",
    dimension: "146.6x70.6x8.25 mm",
    peso: "187 g",
    color: "Titanio Natural",
    caracteristicas: "A17 Pro, 128GB, Cámara 48MP, Dynamic Island, USB-C",
    image_filename: "iphone_15_pro.jpg",
  },
  {
    name: "Samsung Galaxy S24 Ultra",
    description: "Smartphone premium con S Pen integrado",
    price: 1199.99,
    brand: "Samsung",
    stock: 20,
    category: "celulares",
    material: "Vidrio y titanio",
    dimension: "162.3x77.9x8.6 mm",
    peso: "233 g",
    color: "Negro Titanio",
    caracteristicas: "Snapdragon 8 Gen 3, 256GB, Cámara 200MP, S Pen, 5G",
    image_filename: "galaxy_s24.jpg",
  },
]

products.each do |product_attrs|
  # Create the product without the image first
  product = Product.new(product_attrs.except(:image_filename))

  format_name = ActiveSupport::Inflector.transliterate(product.name).gsub(" ", "+")
  image_url = "https://placehold.co/800x600.jpg?text=#{format_name}"

  begin
    # Download and attach the image
    downloaded_image = URI.open(image_url)
    product.image.attach(
      io: downloaded_image,
      filename: product_attrs[:image_filename],
      content_type: "image/jpeg",
    )

    if product.save
      puts "Created #{product.name}"
    else
      puts "Failed to create #{product.name}: #{product.errors.full_messages.join(", ")}"
    end
  rescue OpenURI::HTTPError => e
    puts "Failed to download image for #{product.name}: #{e.message}"
  rescue StandardError => e
    puts "Error creating #{product.name}: #{e.message}"
  end
end

puts "Finished creating #{Product.count} products"

puts "\nProducts created by category:"
Product.group(:category).count.each do |category, count|
  puts "#{category}: #{count} products"
end

User.create(
  username: "super_gato",
  password: "gato123",
  password_confirmation: "gato123",
)
