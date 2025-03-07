import { createOptions } from "./createOptions.js";

const optionsWrapper = document.getElementById("options-wrapper");
const body = document.body;
const eye = document.getElementById("eyeSvg");
const faIcon = document.querySelector(".fa-circle")

window.addEventListener("message", (event) => {
  optionsWrapper.innerHTML = "";

  switch (event.data.event) {
    case "visible": {
      body.style.visibility = event.data.state ? "visible" : "hidden";
      
      if (!event.data.state) {
        faIcon.classList.remove("fa-solid", "textShadow");

        void faIcon.offsetWidth;
        faIcon.classList.add("fa-regular", "pulse");
      }

      return true
    }

    case "leftTarget": {
      if (faIcon) {
        faIcon.classList.remove("fa-solid", "textShadow");
        faIcon.classList.add("fa-regular","pulse" );
      }

      return true
    }

    case "setTarget": {
      eye.classList.add("eye-hover");

      if (faIcon) {
        faIcon.classList.remove("fa-regular", "pulse");
        faIcon.classList.add("fa-solid", "textShadow",);
      }

      if (event.data.options) {
        for (const type in event.data.options) {
          event.data.options[type].forEach((data, id) => {
            createOptions(type, data, id + 1);
          });
        }
      }

      if (event.data.zones) {
        for (let i = 0; i < event.data.zones.length; i++) {
          event.data.zones[i].forEach((data, id) => {
            createOptions("zones", data, id + 1, i + 1);
          });
        }
      }
    }
  }
});
