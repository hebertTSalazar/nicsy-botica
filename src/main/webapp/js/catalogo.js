/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
/* 
    Created on : 7 oct 2025, 18:03:21
    Author     : frank
*/
document.addEventListener("DOMContentLoaded", function () {

    const inputBuscar = document.querySelector("input[name='q']");
    const selectCategoria = document.querySelector("select[name='categoria']");
    const cards = document.querySelectorAll(".card");
    const form = document.querySelector("form");

    function filtrarProductos() {
        const texto = inputBuscar.value.toLowerCase().trim();
        const categoria = selectCategoria.value;

        cards.forEach(card => {
            const nombre = card.querySelector(".card-title").textContent.toLowerCase();
            const categoriaProd = card.querySelector(".text-secondary").textContent;

            
            const coincideTexto = nombre.includes(texto);
            const coincideCategoria = categoria === "" || categoria === categoriaProd;

            
            if (coincideTexto && coincideCategoria) {
                card.parentElement.style.display = "block";
                card.classList.add("fade-in");
            } else {
                card.parentElement.style.display = "none";
                card.classList.remove("fade-in");
            }
        });
    }

   
    inputBuscar.addEventListener("input", filtrarProductos);

    selectCategoria.addEventListener("change", filtrarProductos);

    form.addEventListener("submit", function (event) {
        event.preventDefault();
        filtrarProductos();
    });

    const style = document.createElement("style");
    style.innerHTML = `
        .fade-in {
            animation: fadeIn 0.4s ease-in-out;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: scale(0.98); }
            to { opacity: 1; transform: scale(1); }
        }
    `;
    document.head.appendChild(style);
});
