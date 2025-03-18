let scoreboard = false;

async function closeNUI() {
  await fetch(`https://jg-scoreboard/close`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json; charset=UTF-8",
    },
  });
}

function main() {
  window.addEventListener("message", ({ data }) => {
    switch (data.type) {
      case "showScoreboard":
        showScoreboard(data.data);
        break;
      case "closeScoreboard":
        closeScoreboard();
      default:
        break;
    }
  });

  scoreboard = new bootstrap.Modal(document.getElementById("scoreboard-modal"));

  document.querySelectorAll(".modal").forEach((modal) => {
    modal.addEventListener("hidden.bs.modal", () => {
      closeNUI();
    });
  });
}

main();
