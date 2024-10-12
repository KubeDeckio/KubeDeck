const darkModeSwitches = document.querySelectorAll(".dark-mode-switch");

if (darkModeSwitches) {
  darkModeSwitches.forEach((item) => {
    item.addEventListener("click", () => {
      darkModeSwitches.forEach((item) => item.classList.add("animated"));
      toggleDarkMode();
    });
  });
}

function toggleDarkMode() {
  let darkMode = localStorage.getItem("darkMode");
  if (darkMode === "true") {
    document.documentElement.setAttribute("data-bs-theme", "light");
    localStorage.setItem("darkMode", false);
    darkModeSwitches.forEach((item) => item.classList.add("light"));
    darkModeSwitches.forEach((item) => item.classList.remove("dark"));
  } else {
    document.documentElement.setAttribute("data-bs-theme", "dark");
    localStorage.setItem("darkMode", true);
    darkModeSwitches.forEach((item) => item.classList.add("dark"));
    darkModeSwitches.forEach((item) => item.classList.remove("light"));
  }
}

function initDarkMode() {
  let darkMode = localStorage.getItem("darkMode");
  if (darkMode === "true") {
    darkModeSwitches.forEach((item) => item.classList.add("dark"));
    return;
  }
  if (darkMode === "false") {
    darkModeSwitches.forEach((item) => item.classList.add("light"));
    return;
  }
  if (window.matchMedia("(prefers-color-scheme: dark)").matches) {
    document.documentElement.setAttribute("data-bs-theme", "dark");
    darkModeSwitches.forEach((item) => item.classList.add("dark"));
  }
}

initDarkMode();
