document.addEventListener('DOMContentLoaded', () => {
    setupCartEvents();
    document.addEventListener('turbo:load', setupCartEvents);
});

function setupCartEvents() {
    const cartIcon = document.querySelector('.cart-icon');
    const closeButton = document.querySelector('.close-cart');
    const continueShoppingButton = document.getElementById('continue-shopping');
    const addToCartButton = document.querySelector('.add-to-cart');

    // Evento para desplegar el carrito al hacer clic en el icono del carrito
    if (cartIcon) {
        cartIcon.onclick = (event) => {
            event.preventDefault();
            toggleCart(true);
        };
    }

    // Evento para cerrar el carrito con la "X"
    if (closeButton) {
        closeButton.onclick = (event) => {
            event.preventDefault();
            toggleCart(false);
        };
    }

    // Evento para cerrar el carrito con "Seguir comprando"
    if (continueShoppingButton) {
        continueShoppingButton.onclick = (event) => {
            event.preventDefault();
            toggleCart(false);
        };
    }

    // Evento para añadir producto desde la vista de detalles
    if (addToCartButton) {
        addToCartButton.onclick = () => {
            const productId = addToCartButton.dataset.productId;
            const quantity = document.querySelector('#product-quantity').value || 1;
            addToCart(productId, quantity);
        };
    }
}
function addToCart(productId, quantity) {
    fetch('/cart/add', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        },
        body: JSON.stringify({ product_id: productId, quantity: parseInt(quantity, 10) })
    })
    .then(response => response.json())
    .then((data) => {
        if (data.status === 'success') {
            alert('Producto añadido al carrito');
            toggleCart(true); // Actualizar y mostrar el carrito
        } else {
            console.error('Error al añadir al carrito:', data.error);
        }
    })
    .catch(error => console.error('Error al añadir al carrito:', error));
}

function toggleCart(forceOpen = false) {
    const cartOverlay = document.getElementById('cart-overlay');
    const isCartOpen = cartOverlay.style.width === '300px';

    if (forceOpen || !isCartOpen) {
        cartOverlay.style.width = '300px';

        // Cargar contenido del carrito
        fetch('/cart/show')
            .then(response => response.json())
            .then(data => {
                const cartItemsContainer = document.getElementById('cart-items');
                cartItemsContainer.innerHTML = '';

                if (data.cart_items && data.cart_items.length > 0) {
                    data.cart_items.forEach(item => {
                        const itemElement = document.createElement('div');
                        itemElement.classList.add('cart-item');
                        itemElement.innerHTML = `
                            <img src="${item.image_url}" alt="${item.name}" class="cart-item-image">
                            <div>
                                <p>${item.name}</p>
                                <p>${item.quantity} × S/${item.price} = S/${item.total_price}</p>
                                <button class="remove-from-cart" data-product-id="${item.id}">Eliminar</button>
                            </div>
                        `;
                        cartItemsContainer.appendChild(itemElement);
                    });

                    document.getElementById('empty-cart-message').style.display = 'none';
                    document.getElementById('checkout').style.display = 'block';
                } else {
                    document.getElementById('empty-cart-message').style.display = 'block';
                    document.getElementById('checkout').style.display = 'none';
                }

                document.getElementById('cart-total').textContent = `Total: S/${data.total}`;

                // Evento de eliminar producto en los botones "Eliminar"
                document.querySelectorAll('.remove-from-cart').forEach(button => {
                    button.onclick = () => {
                        const productId = button.dataset.productId;
                        removeFromCart(productId);
                    };
                });
            })
            .catch(error => console.error('Error al cargar el carrito:', error));
    } else {
        cartOverlay.style.width = '0';
    }
}

function removeFromCart(productId) {
    fetch(`/cart/remove`, {
        method: 'DELETE',
        headers: {
            'Content-Type': 'application/json',
            'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        },
        body: JSON.stringify({ product_id: productId })
    })
    .then(response => response.json())
    .then(() => {
        toggleCart(true); // Actualizar el carrito después de eliminar un producto
    })
    .catch(error => console.error('Error al eliminar del carrito:', error));
}
 //