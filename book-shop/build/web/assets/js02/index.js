
let loadCount = 0;

function getLastProductId() {
    const newArrivals = document.querySelector('[data-section="new-arrivals"] #product-container');
    const inputs = newArrivals.querySelectorAll('input[name="id"]');
    if (inputs.length === 0)
        return 0;
    return inputs[inputs.length - 1].value;
}

document.getElementById("loadMoreBtn").addEventListener("click", function () {
    const lastId = getLastProductId();

    fetch("loadMore?lastId=" + lastId)
            .then(response => response.text())
            .then(html => {
                const newArrivals = document.querySelector('[data-section="new-arrivals"] #product-container');
                newArrivals.insertAdjacentHTML("beforeend", html);

                loadCount++;
                if (loadCount >= 2) {
                    document.getElementById("loadMoreBtn").style.display = "none";
                    document.getElementById("viewAllBtn").style.display = "inline-block";
                }
            })
            .catch(err => console.error("Load more failed:", err));
});
