function post (){
  const ItemPrice = document.getElementById("item-price");
  ItemPrice.addEventListener("keyup", () => {
    const ItemPrice1 = ItemPrice.value;
    const AddTaxPrice  = document.getElementById("add-tax-price");
    AddTaxPrice.innerHTML = Math.floor(ItemPrice1 * 0.1);
    const Profit  = document.getElementById("profit");
    Profit.innerHTML = Math.floor(ItemPrice1 * 0.9);
  });
}

window.addEventListener('load', post);
