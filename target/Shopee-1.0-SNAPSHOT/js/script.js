
function add_to_cart(pid, pname, price) {
            let cart = localStorage.getItem("cart");
            if (cart == null) {
                let products = [];

                let product = {productId: pid, productName: pname, productQuantity: 1, productPrice: price};
                products.push(product);

                localStorage.setItem("cart", JSON.stringify(products));
                console.log("product is added for first time");
                toast("product is added for first time")

            } else {
                let pcart = JSON.parse(cart);
                let oldProduct = pcart.find((item) => item.productId == pid);

                if (oldProduct) {

                    oldProduct.productQuantity = oldProduct.productQuantity + 1;
                    pcart.map((item) => {

                        if (item.productId == oldProduct.productId) {
                            item.productQuantity = oldProduct.productQuantity;
                        }
                    })

                    localStorage.setItem("cart", JSON.stringify(pcart));
                    console.log("product is increased");
                    toast("Product is increased")
                } else {

                    let product = {productId: pid, productName: pname, productQuantity: 1, productPrice: price};
                    pcart.push(product);
                    localStorage.setItem("cart", JSON.stringify(pcart));
                    console.log("Product is added");
                    toast("Product is added")
                }
            }
            updateCart()

        }



// update cart

function updateCart() {
    let cartString = localStorage.getItem("cart");
    let cart = JSON.parse(cartString);
    if (cart == null || cart.length == 0) {
        console.log("cart is empty.");
        $(".cart-items").html("(0)");
        $(".cart-body").html("<h3>Cart does not have any items</h3>");
        $(".checkout-btn").addClass('disabled');

    } else {
        console.log(cart);
        $(".cart-items").html(`( ${cart.length} )`);
        let table = `
            <table class='table'>
            <thead class='thead-light'>
        
                <tr>
                    <th> Item Name</th>
                    <th> Price</th>
                    <th> Quantity</th>
                    <th> Total Price</th>
                    <th> Action</th>
        
                </tr>
        
            </thead>
            `;

        let totalPrice = 0;
        cart.map((item) => {

            table += `
                    <tr>
                        <td>${item.productName}</td>
                        <td>${item.productPrice}</td>
                        <td>${item.productQuantity}</td>
                        <td>${item.productPrice * item.productQuantity}</td>
                        <td><button onclick='deleteItem(${item.productId})' class='btn btn-outline-danger'>Remove</td>
                    </tr>
            
                    
                `

            totalPrice += item.productPrice * item.productQuantity;

        });

        table = table + ` <tr><td colspan='5'>Total : <span class='align-item-right'> ${totalPrice}</span> </td></tr>
        </table>`
        $(".cart-body").html(table);

        $(".checkout-btn").removeClass('disabled');
    }
}

function deleteItem(pid) {
    let cart = JSON.parse(localStorage.getItem('cart'));

    let newCart = cart.filter((item) => item.productId != pid);

    localStorage.setItem('cart', JSON.stringify(newCart));
    updateCart();
    toast("Item Is Deleted");
}


function toast(msg) {
    Toastify({
        text: msg,
        duration: 3000,
        destination: "https://github.com/apvarun/toastify-js",
        newWindow: true,
        close: true,
        gravity: "top", // `top` or `bottom`
        position: "right", // `left`, `center` or `right`
        stopOnFocus: true, // Prevents dismissing of toast on hover
        style: {
            background: "linear-gradient(to right, #00b09b, #96c93d)",
        },
        onClick: function () {} // Callback after click
    }).showToast();

}


$(document).ready(function () {
    updateCart();
});


function goToCheckout(){
    window.location = "checkout.jsp";
}


