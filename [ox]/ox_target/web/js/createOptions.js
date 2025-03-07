
import { fetchNui } from "./fetchNui.js";

const optionsWrapper = document.getElementById("options-wrapper");

function onClick() {
  // when nuifocus is disabled after a click, the hover event is never released
  this.style.pointerEvents = "none";

  fetchNui("select", [this.targetType, this.targetId, this.zoneId]);
  // is there a better way to handle this? probably
  setTimeout(() => (this.style.pointerEvents = "auto"), 100);
}

export function createOptions(type, data, id, zoneId) {
  if (data.hide) return;

  const option = document.createElement("div");

  option.className = "flex flex-row gap-1 group";
  option.innerHTML = 
  `
    <div class="bg-[#242424] w-[35px] h-[35px] rounded h-1/4 flex items-center justify-center text-base flex">
        <span class="font-bold text-base">
            <i class="fa-fw ${data.icon} text-mainColor ${data.iconColor ? '' : 'textShadow'} text-xl" 
              style="${data.iconColor ? `color: ${data.iconColor} !important; text-shadow: 0px 0px 15px ${data.iconColor} !important;` : ''}">
            </i>
        </span>
    </div>
    <div class="bg-[#242424] h-[35px] p-3 rounded text-neutral-200 flex justify-start items-center h-3/4 text-base font-semibold relative">
        <span class="px-2">${data.label}</span>
        <span class="absolute top-1 left-1 w-1.5 h-1.5 rounded-full 
            ${data.iconColor ? `group-hover:bg-[${data.iconColor}]` : 'group-hover:bg-sky-600'} 
            group-hover:transition-all group-hover:animate-pulse bg-[#2e2e2e] boxShadow"></span>
    </div>
  `;

  option.id = `div_${id}`
  option.targetType = type;
  option.targetId = id;
  option.zoneId = zoneId;

  option.addEventListener("click", onClick);
  optionsWrapper.appendChild(option);
}
