const siteGuessPreference = document.documentElement.getAttribute("data-show-guesses");

window.addEventListener("DOMContentLoaded", (event) => {
  var switchers = document.querySelectorAll("[id^='guess-toggle']");
  switchers.forEach((switcher) => {
    switcher.addEventListener("click", () => {
      document.documentElement.classList.toggle("show-guesses");
    });
  });
});