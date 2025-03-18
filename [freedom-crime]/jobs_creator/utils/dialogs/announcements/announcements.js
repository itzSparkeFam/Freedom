let announcements = [];

const secondsBetweenAnnouncement = 20;
let currentAnnouncementIndex = 0;

function hideAnnouncements() {
    $("#nexus-announcements-div").remove();
}

function setAnnouncement(index) {
    const announcement = announcements[index];
    if(!announcement) {
        hideAnnouncements();
        return;
    }

    const animationsTime = 1000;
    $("#nexus-announcements-div").fadeOut(animationsTime);

    setTimeout(() => {
        if(!announcement) return;

        const scriptColor = $(".script-name").css("color");

        if(announcement.url) {
            const div = $(`
                <a id="nexus-announcements-div" href="${announcement.url}" target="_blank" onclick="window.invokeNative('openUrl', '${announcement.url}');" class="my-3 p-1 rounded fw-bold d-flex justify-content-between align-items-center"
                    style="background: linear-gradient(to right, #181818, ${scriptColor}); color: white;">
                            <span class="font-monospace" style="color: rgba(255, 255, 255, 0.1)">${announcement.id}</span>
                    <p class="mb-0">${announcement.message}</p>
                    <button type="button" class="btn-close float-end"></button>
                </a>
            `);

            div.click(function() {
                $.post(`https://${resName}/nexusAnnouncementClicked`, JSON.stringify({ announcementId: announcement.id }));
            });

            $("#nexus-announcements-div").replaceWith(div).fadeIn(animationsTime);
        } else {
            $("#nexus-announcements-div").replaceWith(`
                <div id="nexus-announcements-div" class="my-3 p-1 rounded fw-bold d-flex justify-content-between align-items-center" 
                style="background: linear-gradient(to right, #181818, ${scriptColor}); color: white;">
                    <span class="font-monospace" style="color: rgba(255, 255, 255, 0.1)">${announcement.id}</span>
                    <p class="mb-0">${announcement.message}</p>
                    <button type="button" class="btn-close float-end"></button>
                </div>
            `).fadeIn(animationsTime);
        }

        $("#nexus-announcements-div").find(".btn-close").click((event) => {
            event.stopPropagation();

            markAnnouncementAsHidden(announcement.id);
        });

        $.post(`https://${resName}/nexusAnnouncementSeen`, JSON.stringify({ announcementId: announcement.id }));
    }, animationsTime);
}

function processAnnouncements() {
    currentAnnouncementIndex = (currentAnnouncementIndex + 1) % announcements.length;

    setAnnouncement(currentAnnouncementIndex);
}

async function markAnnouncementAsHidden(announcementId) {
    await $.post(`https://${resName}/nexusMarkAnnouncementAsHidden`, JSON.stringify({ announcementId }));
    refreshAnnouncements();
}

let announcementsIntervalId;

async function refreshAnnouncements() {
    hideAnnouncements();

    clearInterval(announcementsIntervalId);
    announcementsIntervalId = setInterval(processAnnouncements, secondsBetweenAnnouncement * 1000);

    announcements = await $.post(`https://${resName}/nexusGetAnnouncements`);
    if(!announcements || announcements.length == 0) return;

    currentAnnouncementIndex = Math.floor(Math.random() * announcements.length);

    const div = $(`
    <div id="nexus-announcements-div"></div>
    `);

    processAnnouncements()
    $("#main-bar").prepend(div);
}