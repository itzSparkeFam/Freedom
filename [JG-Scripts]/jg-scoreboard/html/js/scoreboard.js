function renderPlayerCard(player, config) {
  const { id, ping, name, jobName, jobLabel, jobOnDuty, isAdmin } = player;
  const whitelistJob = config.HighlightedJobs.find(({ jobs }) => jobs.includes(jobName));

  return `
    <div class="card player-card">
      <div class="card-body">
        ${config.ShowPlayerIds ? `<div class="player-id">${id}</div>` : ""}
        <div class="player-details">
          <div class="player-name">${name}</div>
          <div class="player-accolades">
            ${config.ShowAdminBadges && isAdmin ? `<span class="badge bg-warning"><i class="bi-${config.AdminBadgeIcon}"></i></span>` : ""}
            ${
              config.ShowPlayerJob
                ? `<span class="badge ${!whitelistJob ? "bg-primary" : ""}" ${whitelistJob ? `style="background: ${whitelistJob.color}"` : ""}>
                    ${whitelistJob ? `<i class="bi-${whitelistJob.icon}"></i> ` : ""}
                    ${jobLabel} ${config.ShowPlayerJobDutyStatus && jobName !== "unemployed" ? (jobOnDuty ? "(on duty)" : "(off duty)") : ""}
                  </span>`
                : ""
            }
          </div>
        </div>
        ${config.ShowPing ? `
        <div class="player-ping ${ping <= 50 ? "text-success" : ping > 50 && ping < 100 ? "text-warning" : "text-danger"}">
          <i class="bi-broadcast-pin me-1"></i>
          <span>${ping}ms</span>
        </div>` : ""}
      </div>
    </div>
  `;
}

function showScoreboard(data) {
  const { config, maxSlots, players = [] } = data;

  // Header data
  document.querySelector("#server-title").innerHTML = config.ServerName;
  document.querySelector("#players-count").innerHTML = `${players.length}/${maxSlots}`;

  // Highlighted Jobs
  if (config.ShowHighlightedJobs) {
    let highlightedJobsHtml = "";
    for (let job of Object.values(config.HighlightedJobs).sort((a, b) => a.order - b.order)) {
      let { label, icon, color, count } = job;
      highlightedJobsHtml += `
        <div class="badge whitelist-job" style="background: ${color}">
          <i class="bi-${icon} job-icon"></i>
          <div class="player-count">${count}</div>
          <small class="job-name">${label}</small>
        </div>
      `;
    }

    document.querySelector("#highlighted-jobs").innerHTML = highlightedJobsHtml;
  }

  // Current player
  let currentPlayerData = players.find(({ me }) => me);
  if (currentPlayerData) {
    document.querySelector("#current-player-data").innerHTML = renderPlayerCard(currentPlayerData, config);
  }

  // All other players
  if (config.ShowPlayers) {
    let allPlayers = players.filter(({ me }) => !me);
    let allPlayersHtml = "";
    for (let player of allPlayers) {
      allPlayersHtml += renderPlayerCard(player, config);
    }

    document.querySelector("#all-players").classList.add("modal-body");
    document.querySelector("#all-players").innerHTML = allPlayersHtml || "No other players online.";
  }

  scoreboard.show();
}

function closeScoreboard() {
  scoreboard.hide();
}
