window.addEventListener('load', function(){
  const itemPrice = document.getElementById("item-price");
  itemPrice.addEventListener('input', function(){
    const priceVal = itemPrice.value;
    const addTaxPrice = document.getElementById("add-tax-price");
    addTaxPrice.innerHTML = `${Math.floor(priceVal / 10)}`;
    const profit = document.getElementById("profit");
    profit.innerHTML = `${priceVal - Math.floor(priceVal / 10)}`;
  });
});