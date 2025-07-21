
document.addEventListener('DOMContentLoaded', function () {
    const qtyInputs = document.querySelectorAll('.qty-input');

    qtyInputs.forEach(input => {
        // Gắn giá trị gốc để so sánh
        input.dataset.original = input.value;

        input.addEventListener('input', function () {
            const quantity = parseInt(this.value);
            const original = parseInt(this.dataset.original);
            const unitPrice = parseFloat(this.dataset.price);
            const discountRate = parseFloat(this.dataset.discount);
            const id = this.dataset.id;

            if (isNaN(quantity) || quantity < 1 || quantity === original)
                return;

            // === Update Line Total in UI ===
            const row = this.closest('tr');
            const totalCell = row.querySelector('.line-total');
            const newLineTotal = unitPrice * quantity;
            totalCell.textContent = newLineTotal.toLocaleString('vi-VN') + ' đ';

            // === Update Cart Summary
            updateCartSummary();

            // === Send AJAX using jQuery
            $.post('MainController', {
                action: 'updateQuantity',
                id: id,
                qty: quantity
            });

            // Cập nhật lại giá trị gốc
            this.dataset.original = quantity;
        });
    });

    function updateCartSummary() {
        let subtotal = 0;
        let totalDiscount = 0;

        document.querySelectorAll('.qty-input').forEach(input => {
            const price = parseFloat(input.dataset.price);
            const qty = parseInt(input.value);
            const discount = parseFloat(input.dataset.discount);

            subtotal += price * qty;
            totalDiscount += price * qty * discount;
        });

        const total = subtotal - totalDiscount;

        document.querySelector('.totals div:nth-child(1) span:nth-child(2)').textContent = subtotal.toLocaleString('vi-VN') + ' đ';
        document.querySelector('.totals div:nth-child(2) span:nth-child(2)').textContent = totalDiscount.toLocaleString('vi-VN') + ' đ';
        document.querySelector('.totals .total span:nth-child(2)').textContent = total.toLocaleString('vi-VN') + ' đ';
    }
    
    

});