// components/item_price.js
// 価格計算のロジックを書く
window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");
  if (priceInput) {
    priceInput.addEventListener("input", () => {
      const inputValue = priceInput.value;
      
      const addTaxPrice = Math.floor(inputValue * 0.1);
      const profit = Math.floor(inputValue - addTaxPrice);
      
      const addTaxPriceField = document.getElementById("add-tax-price");
      const profitField = document.getElementById("profit");
      
      addTaxPriceField.innerHTML = addTaxPrice;
      profitField.innerHTML = profit;
    });
  }
});

