import {dBank} from "../../declarations/dBank";

window.addEventListener("load", async function () {
  update();
});

document.querySelector("form").addEventListener("submit", async function(event) {
  event.preventDefault();

  const addAmount = document.getElementById("input-amount").value;
  const withdrawAmount = document.getElementById("withdrawal-amount").value;
  const button = document.querySelector("#submit-btn");

  button.setAttribute("disabled", true);

  if(addAmount.length != 0)
    await dBank.topUp(parseFloat(addAmount));
  
  if(withdrawAmount.length != 0)
    await dBank.withDraw(parseFloat(withdrawAmount));

  update();

  document.getElementById("input-amount").value = "";
  document.getElementById("withdrawal-amount").value = "";
  button.removeAttribute("disabled");
});

async function update() {
  const currentAmount = await dBank.checkBalance();

  // show val till 2 decimal place
  document.getElementById("value").innerText = Math.round(currentAmount * 100) / 100;
}