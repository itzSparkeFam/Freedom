const JS17Movement = {
	Sounds: {},
	PlayerData: {
		x: 0,
		y: 0,
		z: 0,
		h: 0,
	},
};

JS17Movement.Post = (endpoint, data) => {
	$.post(`https://${window.name}/` + endpoint, data);
};

JS17Movement.GetTranslation = (key, args) => {
	let translation = JS17Movement.Lang[key] ?? "Unkown";

	if (args) {
		args.forEach((arg) => {
			translation = translation.replace("%s", arg);
		});
	}

	return translation;
};

const _U = (key, selector, ...args) => {
	document.querySelector(selector).innerHTML = JS17Movement.GetTranslation(
		key,
		args
	);
};

JS17Movement.PlaySound = (id, audioFile, volume, looped) => {
	if (!window.audioContext) window.audioContext = new window.AudioContext();
	const source = audioContext.createBufferSource();
	const gainNode = audioContext.createGain();

	fetch(`assets/sounds/${audioFile}.wav`)
		.then((response) => response.arrayBuffer())
		.then((arrayBuffer) => audioContext.decodeAudioData(arrayBuffer))
		.then((audioBuffer) => {
			source.buffer = audioBuffer;
			if (looped) source.loop = true;
			gainNode.gain.value = volume;
			source.connect(gainNode);
			gainNode.connect(audioContext.destination);
			JS17Movement.Sounds[id] = { source, gainNode };
			source.start();
		});

	source.onended = () => {
		delete JS17Movement.Sounds[id];
		JS17Movement.Post(`soundsEnd`, JSON.stringify({ id }));
	};
};

JS17Movement.PlaySound3D = (
	id,
	audioFile,
	volume,
	maxDistance,
	x,
	y,
	z,
	looped
) => {
	if (!window.audioContext) window.audioContext = new window.AudioContext();
	const source = audioContext.createBufferSource();
	const gainNode = audioContext.createGain();
	const panner = audioContext.createPanner();
	panner.panningModel = "HRTF";
	panner.distanceModel = "inverse";
	panner.refDistance = 5;
	panner.maxDistance = maxDistance * 1000;
	panner.rolloffFactor = 0.5;
	panner.coneInnerAngle = 75;
	panner.coneOuterAngle = 285;
	panner.coneOuterGain = 0.8;

	fetch(`assets/sounds/${audioFile}.wav`)
		.then((response) => response.arrayBuffer())
		.then((arrayBuffer) => audioContext.decodeAudioData(arrayBuffer))
		.then((audioBuffer) => {
			source.buffer = audioBuffer;
			if (looped) source.loop = true;
			gainNode.gain.value = volume;
			source.connect(panner);
			panner.connect(gainNode);
			gainNode.connect(audioContext.destination);
			JS17Movement.Sounds[id] = { source, panner, x, y, z };
			source.start();
		});

	source.onended = () => {
		delete JS17Movement.Sounds[id];
		JS17Movement.Post(`soundsEnd`, JSON.stringify({ id }));
	};
};

JS17Movement.StopSound = (id) => {
	if (JS17Movement.Sounds[id]) {
		JS17Movement.Sounds[id].source.stop();
		delete JS17Movement.Sounds[id];
		JS17Movement.Post(`soundsEnd`, JSON.stringify({ id }));
	}
};

JS17Movement.UpdateSoundCoords = (id, x, y, z) => {
	if (JS17Movement.Sounds[id] != undefined) {
		JS17Movement.Sounds[id].x = x;
		JS17Movement.Sounds[id].y = y;
		JS17Movement.Sounds[id].z = z;
	}
};

JS17Movement.UpdateSound = (id, x, y, z, h) => {
	if (!JS17Movement.Sounds[id]) return;

	JS17Movement.PlayerData.x = x;
	JS17Movement.PlayerData.y = y;
	JS17Movement.PlayerData.z = z;
	JS17Movement.PlayerData.h = h;

	const heading = JS17Movement.PlayerData.h;
	const rad = heading * (Math.PI / 180);
	const sinHeading = Math.sin(rad);
	const cosHeading = Math.cos(rad);
	const dx = JS17Movement.Sounds[id].x - JS17Movement.PlayerData.x;
	const dy = JS17Movement.Sounds[id].y - JS17Movement.PlayerData.y;
	const dz = JS17Movement.Sounds[id].z - JS17Movement.PlayerData.z;
	const pannerX = cosHeading * dx + sinHeading * dy;
	const pannerY = cosHeading * dy - sinHeading * dx;
	const pannerZ = dz;
	const orX = Math.sin(rad);
	const orY = Math.cos(rad);

	if (id && JS17Movement.Sounds[id].panner) {
		JS17Movement.Sounds[id].panner.setPosition(pannerX, pannerZ, -pannerY);
		JS17Movement.Sounds[id].panner.setOrientation(-orX, 0, orY);
	}
};

JS17Movement.ToggleCrosshair = (state) => {
	const crosshairEl = document.querySelector(".crosshair");

	if (state) {
		crosshairEl.style.display = null;
		requestAnimationFrame(() => {
			crosshairEl.style.opacity = "1";
		});
	} else {
		crosshairEl.style.opacity = "0";
		setTimeout(() => {
			crosshairEl.style.display = "none";
		}, 300);
	}
};

window.addEventListener("DOMContentLoaded", () => {
	JS17Movement.Post("nuiLoaded");
});

window.addEventListener("keydown", (e) => {
	const key = e.code.toLowerCase();

	if (key === "escape") {
		JS17Movement.Post("exit");
	}
});

// Lobby
let currentSliderStatus = 0;
let currentActiveTab = "mainMenu";
let lastNotifyId = 0;
let PlayerOwnsTeam = false;
let startJobBtnExist = true;
let scriptIntialized = false;
let tutorialActive = false;
let counterActive = false;
let myId;
let showingInvite = false;
let currentCallbackName;

$(".switchFlex .option").click(function () {
	if (this.id != currentSliderStatus) {
		currentSliderStatus = this.id;
		if (currentSliderStatus == 1) {
			$(".activeSlider").css({ "margin-left": "34px" });
			setTimeout(async function () {
				if (currentSliderStatus == 1)
					JS17Movement.Post(
						`changeClothes`,
						JSON.stringify({ type: "work" })
					);
				$("#clothesId").html(Number(currentSliderStatus) + 1);
			}, 200);
		} else {
			$(".activeSlider").css({ "margin-left": "0px" });
			setTimeout(async function () {
				if (currentSliderStatus == 0)
					JS17Movement.Post(
						`changeClothes`,
						JSON.stringify({ type: "citizen" })
					);
				$("#clothesId").html(Number(currentSliderStatus) + 1);
			}, 200);
		}
	}
});

$(".tab").click(function () {
	if (currentActiveTab != this.id) {
		currentActiveTab = this.id;
		$(".activeTab").removeClass("activeTab");
		$(`#${currentActiveTab}`).addClass("activeTab");
		if (currentActiveTab == "management") {
			$(".tabsSlider").scrollLeft(410);
		} else {
			$(".tabsSlider").scrollLeft(0);
		}
	}
});

function closeCustomPanel(boolean) {
	$(".multiplayerMenu").fadeOut(250);
	$("#customScreen").fadeOut(250);

	if (startJobBtnExist) $("#startJob").fadeIn(250);

	if (boolean) {
		JS17Movement.Post(`${currentCallbackName}`);
		currentCallbackName = undefined;
	}

	JS17Movement.Post(`focusOff`);
}

function ShowCustomPanel(
	tittle,
	subttitle,
	content,
	img,
	confirmBtn,
	closeBtn
) {
	$(".header .bgText").text(tittle);
	$(".header .text").text(tittle);
	$("#customScreenSubTittle").text(subttitle);
	$("#customImg").attr("src", img);
	$("#CustomCloseBtn").text(closeBtn);
	$("#CustomConfirmBtn").text(confirmBtn);
	$(".mainScreen").fadeOut(250);
	$("#customScreen .text").html(content);
	$("#warningScreen").fadeOut(250);
	$("#inviteScreen").fadeOut(250);
	$(".mainScreen").fadeOut(250);
	$(".multiplayerMenu").fadeIn(250);
	$("#customScreen").fadeIn(250);
	$("#startJob").fadeOut(250);
}

function showTutorial(content) {
	$(".header .bgText").text(JS17Movement.GetTranslation("tutorial"));
	$(".header .text").text(JS17Movement.GetTranslation("tutorial"));
	$(".mainScreen").fadeOut(250);
	$("#tutorialScreen .text").text(content);
	$("#warningScreen").fadeOut(250);
	$("#inviteScreen").fadeOut(250);
	$(".mainScreen").fadeOut(250);
	$(".multiplayerMenu").fadeIn(250);
	$("#startJob").fadeOut(250);
	$("#tutorialScreen").fadeIn(250);
}

function showInvitation(inviter) {
	showingInvite = true;
	$(".header .bgText").text(JS17Movement.GetTranslation("invitation"));
	$(".header .text").text(JS17Movement.GetTranslation("invitation"));
	$(".mainScreen").fadeOut(250);
	$(".inviterName").text(inviter);
	$("#warningScreen").fadeOut(250);
	$("#tutorialScreen").fadeOut(250);
	$(".mainScreen").fadeOut(250);
	$(".multiplayerMenu").fadeIn(250);
	$("#inviteScreen").fadeIn(250);
	$("#startJob").fadeOut(250);
}

function showWarning() {
	$(".header .bgText").text(JS17Movement.GetTranslation("warning"));
	$(".header .text").text(JS17Movement.GetTranslation("warning"));
	$(".mainScreen").fadeOut(250);
	$("#tutorialScreen").fadeOut(250);
	$("#inviteScreen").fadeOut(250);
	$(".mainScreen").fadeOut(250);
	$(".multiplayerMenu").fadeIn(250);
	$("#warningScreen").fadeIn(250);
	$("#startJob").fadeOut(250);
}

let oldHostId = 0;

async function SetHost(name, playerId, percentage) {
	if (percentage == undefined) {
		percentage = 100;
	}

	if (oldHostId != 0) {
		$(`#myTeamHostPlayerId${oldHostId}`).remove();
		$(`#manageRewardHostPlayerId${oldHostId}`).remove();
	}

	oldHostId = playerId;
	let mainMenuTemplate = `<div id="myTeamHostPlayerId${playerId}" style="transform: translateX(-106%)" class="box"><div class="icon"><img src="assets/multiplayerlobby/hostIcon.svg" height="50px"><img src="assets/multiplayerlobby/strokes.svg" height="40px"></div><div class="content"><div class="topic">${JS17Movement.GetTranslation(
		"bossName"
	)}</div><div class="value">${name}</div></div></div>`;

	let manageRewardTemplate = `<div id="manageRewardHostPlayerId${playerId}" style="transform: translateX(-106%)" class="box"><div class="icon"><img src="assets/multiplayerlobby/hostIcon.svg" height="50px"><img src="assets/multiplayerlobby/strokes.svg" height="40px"></div><div class="content"><div class="topic">${JS17Movement.GetTranslation(
		"bossName"
	)}</div><div class="value">${name}</div></div><input type="number" class="boxInput" id="rewardInput${playerId}" value=${percentage} lastVal=${percentage}></div>`;

	$(".myTeam").prepend(mainMenuTemplate);
	$(".teamRewards").prepend(manageRewardTemplate);

	if (currentActiveTab == "mainMenu") {
		$(`#manageRewardHostPlayerId${playerId}`).css("transform", "none");
	}

	await new Promise((r) => setTimeout(r, 20));
	$(`#myTeamHostPlayerId${playerId}`).css("transform", "none");
	$(`#manageRewardHostPlayerId${playerId}`).css("transform", "none");
	addRewardInputEvent(`#rewardInput${playerId}`, playerId);
}

let activeInput = 0;
$("body").click(function () {
	if (activeInput != 0) {
		checkReward("#" + activeInput, Number(activeInput.replace(/\D/g, "")));
		activeInput = 0;
	}
});

function checkReward(id, plyId) {
	let beforeValue = $(id).attr("lastVal");
	let currentValue = $(id).val();
	$(id).attr("value", Math.floor(currentValue));
	$(id).val(Math.floor(currentValue));
	fetch(`https://${window.name}/checkIfThisRewardIsFine`, {
		method: "POST",
		headers: {
			"Content-Type": "application/json; charset=UTF-8",
		},
		body: JSON.stringify({
			value: currentValue,
			plyId: plyId,
		}),
	})
		.then((resp) => resp.json())
		.then(async function (resp) {
			$(id).css("transition", `0.25s`);
			if (resp) {
				$(id).css("border", "1px solid #80FF00");
				$(id).attr("lastVal", currentValue);
				$(id).attr("value", currentValue);
			} else {
				$(id).css("border", "1px solid #FF002E");
				shakeAnim(id, 5);
				$(id).attr("value", beforeValue);
				$(id).val(beforeValue);
			}
			await new Promise((r) => setTimeout(r, 250));
			$(id).css("border", "1px rgba(255, 255, 255, 0.15) solid");
		});
}

function addRewardInputEvent(id, plyId) {
	$(id).keyup(async function (event) {
		if (event.keyCode === 13) {
			checkReward(id, plyId);
		}
	});

	$(id).on("focus", function () {
		let idToSet = this.id;
		setTimeout(function () {
			activeInput = idToSet;
		}, 100);
	});
}

async function shakeAnim(id, offsets) {
	$(id).css("transform", `translateX(${offsets}px)`);
	await new Promise((r) => setTimeout(r, 125));
	$(id).css("transform", `translateX(-${offsets}px)`);
	await new Promise((r) => setTimeout(r, 125));
	$(id).css("transform", `none`);
}

async function AddMember(name, playerId, addQuitBtn, percentage) {
	let myTeamTemplate = `<div id="myTeamPlayerId${playerId}" style="transform: translateX(-106%)" class="box"><div class="icon"><img src="assets/multiplayerlobby/clientIcon.svg" height="50px"><img src="assets/multiplayerlobby/strokes.svg" height="40px"></div><div class="content"><div class="topic">${JS17Movement.GetTranslation(
		"memberName"
	)}</div><div class="value">${name}</div></div></div>`;

	let ManageTeamTemplate = `<div id="manageMyTeamPlayerId${playerId}" style="transform: translateX(-106%)" class="box"><div class="icon"><img src="assets/multiplayerlobby/clientIcon.svg" height="50px"><img src="assets/multiplayerlobby/strokes.svg" height="40px"></div><div class="content"><div class="topic">${JS17Movement.GetTranslation(
		"memberName"
	)}</div><div class="value">${name}</div></div><div onclick="kickPlayer('${playerId}')" class="kickBtn"><img src="assets/multiplayerlobby/kickIcon.svg"></div></div>`;

	let manageRewardTemplate = `<div id="manageRewardPlayerId${playerId}" style="transform: translateX(-106%)"  class="box"><div class="icon"><img src="assets/multiplayerlobby/clientIcon.svg" height="50px"><img src="assets/multiplayerlobby/strokes.svg" height="40px"></div><div class="content"><div class="topic">${JS17Movement.GetTranslation(
		"memberName"
	)}</div><div class="value">${name}</div></div><input type="number" class="boxInput" id="rewardInput${playerId}" value=${percentage} lastVal=${percentage}></div>`;

	$(".myTeam").append(myTeamTemplate);
	$(".manageMyTeam").append(ManageTeamTemplate);
	$(".teamRewards").append(manageRewardTemplate);

	addRewardInputEvent(`#rewardInput${playerId}`, playerId);

	if (addQuitBtn) {
		$(`#myTeamPlayerId${playerId}`).append(
			`<div onclick="kickPlayer('${playerId}')" class="kickBtn"><img src="assets/multiplayerlobby/kickIcon.svg"></div>`
		);
	}

	if (currentActiveTab == "mainMenu") {
		$(`#manageMyTeamPlayerId${playerId}`).css("transform", "none");
		$(`#manageRewardPlayerId${playerId}`).css("transform", "none");
	} else {
		$(`#myTeamPlayerId${playerId}`).css("transform", "none");
	}

	await new Promise((r) => setTimeout(r, 20));
	$(`#myTeamPlayerId${playerId}`).css("transform", "none");
	$(`#manageMyTeamPlayerId${playerId}`).css("transform", "none");
	$(`#manageRewardPlayerId${playerId}`).css("transform", "none");
}

async function AddNearbyPlayer(name, playerId) {
	let template = `<div style="transform: translateX(-106%)" id="nearbyPlayerId${playerId}" class="box"><div class="icon"> <img src="assets/multiplayerlobby/newUser.svg" height="50px"><img src="assets/multiplayerlobby/strokes.svg" height="40px"></div><div class="content"><div class="topic">${JS17Movement.GetTranslation(
		"memberName"
	)}</div><div class="value">${name}</div></div><div class="inviteBtn" onclick="inviteNearbyPlayer('${playerId}')"><img src="assets/multiplayerlobby/inviteBtn.svg"></img></div></div>`;

	$(".nearbyPlayers").append(template);
	await new Promise((r) => setTimeout(r, 20));
	$(`#nearbyPlayerId${playerId}`).css("transform", "none");
	await new Promise((r) => setTimeout(r, 1000));
}

function kickPlayer(id) {
	if (PlayerOwnsTeam) {
		if (myId == id) {
			JS17Movement.Post(
				`notify`,
				JSON.stringify({
					msg: JS17Movement.GetTranslation("kickPlayerNotify"),
				})
			);
			return;
		}
		JS17Movement.Post(`kickPlayerFromLobby`, JSON.stringify({ id: id }));
	} else if (myId == id) {
		JS17Movement.Post(`leaveLobby`, JSON.stringify({ id: id }));
	}
}

async function DeletePlayer(id) {
	$(`${id}`).css("transform", "translateX(-106%)");
	await new Promise((r) => setTimeout(r, 500));
	$(`${id}`).remove();
}

function inviteNearbyPlayer(id) {
	JS17Movement.Post(`sendRequest`, JSON.stringify({ id: id }));
}

async function ShowNotification(type, msg) {
	msg = msg.toString();
	lastNotifyId++;
	let notificationTemplate;
	let thisId = lastNotifyId;

	if (type == "wrong") {
		if (msg.length > 135) {
			notificationTemplate = `<div style="transform: translateX(106%)" class="notification" id="notify${thisId}"><div class="flexBox"><div class="text longNotify"><div class="wrongTittle">${JS17Movement.GetTranslation(
				"notification"
			)}</div><div class="content">${msg}</div></div></div><div class="progressbar"><div class="track"><div class="wrongRdyTrack" id="track${thisId}"></div></div></div></div>`;
		} else {
			notificationTemplate = `<div style="transform: translateX(106%)" class="notification" id="notify${thisId}"><div class="flexBox"><div class="icon"><img src="assets/multiplayerlobby/xMark.svg"></div><div class="text shortNotify"><div class="wrongTittle">${JS17Movement.GetTranslation(
				"notification"
			)}</div><div class="content">${msg}</div></div></div><div class="progressbar"><div class="track"><div class="wrongRdyTrack" id="track${thisId}"></div></div></div></div>`;
		}
	} else {
		if (msg.length > 135) {
			notificationTemplate = `<div style="transform: translateX(106%)" class="notification " id="notify${thisId}"><div class="flexBox"><div class="text longNotify"><div class="tittle">${JS17Movement.GetTranslation(
				"notification"
			)}</div><div class="content">${msg}</div></div></div><div class="progressbar"><div class="track"><div class="rdyTrack" id="track${thisId}"></div></div></div></div>`;
		} else {
			notificationTemplate = `<div style="transform: translateX(106%)" class="notification" id="notify${thisId}"><div class="flexBox"><div class="icon"><img src="assets/multiplayerlobby/check.svg"></div><div class="text shortNotify"><div class="tittle">${JS17Movement.GetTranslation(
				"notification"
			)}</div><div class="content">${msg}</div></div></div><div class="progressbar"><div class="track"><div class="rdyTrack" id="track${thisId}"></div></div></div></div>`;
		}
	}

	$(".notifications").append(notificationTemplate);
	await new Promise((r) => setTimeout(r, 20));

	$(`#notify${thisId}`).css("transform", "translateX(0%)");
	await new Promise((r) => setTimeout(r, 500));

	let totalTime = msg.split(" ").length * 200;
	if (totalTime < 1000) totalTime = 1000;
	let addPerTick = 100 / totalTime;

	for (let i = 0; i <= 100; i = i + addPerTick) {
		$(`#track${thisId}`).css("width", i + "%");
		await new Promise((r) => setTimeout(r, 1));
	}

	$(`#track${thisId}`).css("width", "100%");
	$(`#notify${thisId}`).css("transform", "translateX(106%)");
	await new Promise((r) => setTimeout(r, 500));
	$(`#notify${thisId}`).remove();
}

function reactInvite(boolean) {
	showingInvite = false;
	$(".multiplayerMenu").fadeOut(250);
	$("#inviteScreen").fadeOut(250);
	if (startJobBtnExist) $("#startJob").fadeIn(250);

	JS17Movement.Post(`requestReacted`, JSON.stringify({ boolean: boolean }));
	JS17Movement.Post(`focusOff`);
}

function reactWarning(boolean) {
	$(".multiplayerMenu").fadeOut(250);
	$("#warningScreen").fadeOut(250);
	if (startJobBtnExist) $("#startJob").fadeIn(250);
	if (boolean) JS17Movement.Post(`acceptWarning`);

	JS17Movement.Post(`focusOff`);
}

function closeTutorial(boolean) {
	tutorialActive = false;
	$(".multiplayerMenu").fadeOut(250);
	$("#tutorialScreen").fadeOut(250);
	if (boolean) JS17Movement.Post(`dontShowTutorialAgain`);

	if (startJobBtnExist) $("#startJob").fadeIn(250);

	JS17Movement.Post(`tutorialClosed`);
	JS17Movement.Post(`focusOff`);
}

function startJob() {
	if (PlayerOwnsTeam || scriptIntialized) {
		JS17Movement.Post(`startJob`);
		closeHUD();
	} else {
		JS17Movement.Post(
			`notify`,
			JSON.stringify({
				msg: JS17Movement.GetTranslation("startJobNotify"),
			})
		);
	}
}

window.addEventListener("message", function (event) {
	let action = event.data.action;
	let data = event.data;
	if (action === "addNewMember") {
		scriptIntialized = false;
		if (event.data.isHost) {
			SetHost(event.data.name, event.data.id, event.data.rewardPercent);
		} else {
			AddMember(
				event.data.name,
				event.data.id,
				event.data.showQuitBtn,
				event.data.rewardPercent
			);
		}
	} else if (action === "ToggleHostHUD") {
		if (event.data.boolean) {
			PlayerOwnsTeam = true;
			currentActiveTab = "mainMenu";
			$(".activeTab").removeClass("activeTab");
			$(`#${currentActiveTab}`).addClass("activeTab");
			$(".tabs").fadeIn(250);
			$(".nearbyPlayersParent").fadeIn(250);
			$(".management").fadeIn(250);
			$("#startJob").fadeIn(250);
			startJobBtnExist = true;
		} else {
			PlayerOwnsTeam = false;
			$(".tabsSlider").scrollLeft(0);
			currentActiveTab = "mainMenu";
			$(".activeTab").removeClass("activeTab");
			$(`#${currentActiveTab}`).addClass("activeTab");
			$(".tabs").fadeOut(250);
			$(".nearbyPlayersParent").fadeOut(250);
			$(".management").fadeOut(250);
			$("#startJob").fadeOut(250);
			startJobBtnExist = false;
		}
	} else if (action === "DeletePlayer") {
		scriptIntialized = false;
		DeletePlayer(`#myTeamPlayerId${event.data.id}`);
		DeletePlayer(`#manageMyTeamPlayerId${event.data.id}`);
		DeletePlayer(`#manageRewardPlayerId${event.data.id}`);
	} else if (action === "OpenWorkMenu") {
		if (startJobBtnExist) {
			$("#startJob").fadeIn(250);
		}
		$("#counter").fadeOut(250);
		$(".header .bgText").text(JS17Movement.GetTranslation("minerLobby"));
		$(".header .text").text(JS17Movement.GetTranslation("minerLobby"));
		$("#inviteScreen").fadeOut(250);
		$("#warningScreen").fadeOut(250);
		$("#tutorialScreen").fadeOut(250);
		$(".mainScreen").fadeIn(250);
		$(".multiplayerMenu").fadeIn(250);
	} else if (action === "hideCloakroom") {
		$("#cloakroom").css("display", "none");
	} else if (action === "openWarning") {
		showWarning();
	} else if (action === "ShowInviteBox") {
		showInvitation(event.data.name);
	} else if (action === "showTutorial") {
		tutorialActive = true;
		showTutorial(event.data.customText);
	} else if (action === "showCustomPanel") {
		currentCallbackName = event.data.callbackName;
		ShowCustomPanel(
			event.data.tittle,
			event.data.subtittle,
			event.data.content,
			event.data.img,
			event.data.confirmBtn,
			event.data.closeBtn
		);
	} else if (action === "Init") {
		scriptIntialized = true;
		myId = event.data.myId;
		$(".myTeam").empty();
		$(".manageMyTeam").empty();
		$(".teamRewards").empty();
		SetHost(event.data.name, event.data.myId, 100);
		$(".tabs").fadeOut(250);
		$(".tabsSlider").scrollLeft(0);
		$(".management").fadeOut(250);
		$("#startJob").fadeIn(250);
		startJobBtnExist = true;
	} else if (action === "showMyTeamTab") {
		$(".myTeamParent").fadeIn(250);
	} else if (action === "hideMyTeamTab") {
		$(".myTeamParent").fadeOut(250);
	} else if (action === "showCounter") {
		$(".gasContainer").fadeIn(0);
		$("#counter").css("display", "block").hide().fadeIn(250);
		counterActive = true;
	} else if (action === "hideCounter") {
		$("#counter").fadeOut(250);
		counterActive = false;
	} else if (action === "updateCounter") {
		_U("progress", "#progress", event.data.value.toString());
	} else if (action === "updateGas") {
		_U("gasProgress", "#gasProgress", event.data.value.toString());
		_U(
			"tasksContentSecondary",
			"#tasksContentSecondary",
			event.data.value.toString()
		);
	} else if (action === "hideGas") {
		$(".gasContainer").fadeOut(250);
	} else if (action === "hideNearbyPlayersTab") {
		$(".nearbyPlayersParent").fadeOut(250);
	} else if (action === "showNearbyPlayersTab") {
		$(".nearbyPlayersParent").fadeIn(250);
	} else if (action === "addNewNearbyPlayer") {
		AddNearbyPlayer(event.data.name, event.data.id);
	} else if (action === "DeleteNearbyPlayer") {
		DeletePlayer(`#nearbyPlayerId${event.data.id}`);
	} else if (action === "updateMyReward") {
		$(".salaryPercent").text(event.data.reward + "%");
	} else if (action === "showNotification") {
		ShowNotification(event.data.type, event.data.msg);
	} else if (action === "hideManageRewards") {
		$(".manageReward").fadeOut(100);
		$("#cashPercentage").fadeOut(100);
	} else if (action === "updateHostRewards") {
		$(".teamRewards input").attr("lastVal", event.data.value);
		$(".teamRewards input").attr("value", event.data.value);
	} else if (action === "replaceStartBtn") {
		$("#startBtn").text("End Job")
		$("#decoLineStart").text("MANAGE JOB")
	} else if (action === "startBtnBackToNormal") {
		$("#startBtn").text("Start Job")
		$("#decoLineStart").text("Start")
	} else if (action === "setProgressBarAlign") {
		var $counter = $("#counter");

		$counter.css({
			top: "",
			bottom: "",
			left: "",
			right: "",
			margin: "",
			gap: "0 20px",
		});

		var position = event.data.offset;
		switch (event.data.align) {
			case "top-left":
				$counter.css({
					top: position,
					left: position,
				});
				break;
			case "top-center":
				$counter.css({
					top: position,
					left: "50%",
					transform: "translateX(-50%)",
				});
				break;
			case "top-right":
				$counter.css({
					top: position,
					right: position,
				});
				break;
			case "bottom-left":
				$counter.css({
					bottom: position,
					left: position,
				});
				break;
			case "bottom-center":
				$counter.css({
					bottom: position,
					left: "50%",
					transform: "translateX(-50%)",
				});
				break;
			case "bottom-right":
				$counter.css({
					bottom: position,
					right: position,
				});
				break;
			default:
		}
	} else if (action === "SetupLang") {
		JS17Movement.Lang = { ...event.data.lang };
	} else if (action === "openWelding") {
		JS17Movement.Welding.Level = data.level;
		JS17Movement.Welding.Setup();
	} else if (action === "openPipes") {
		_U(
			"tasksContentSecondary",
			"#tasksContentSecondary",
			event.data.value.toString()
		);

		JS17Movement.Pipes.Level = {
			time: data.time,
			speed: data.level / 1000,
		};
		JS17Movement.Pipes.Setup();
	} else if (action === "openSigning") {
		JS17Movement.Signing.Open();
	} else if (action === "updateTasks") {
		_U(
			"tasksContentSecondary2",
			"#tasksContentSecondary",
			data.currentTask,
			data.tasks
		);
	} else if (action === "playSound") {
		JS17Movement.PlaySound(
			data.id,
			data.audioFile,
			data.volume,
			data.looped
		);
	} else if (action === "playSound3D") {
		JS17Movement.PlaySound3D(
			data.id,
			data.audioFile,
			data.volume,
			data.maxDistance,
			data.x,
			data.y,
			data.z,
			data.looped
		);
	} else if (action === "updateSoundCoords") {
		JS17Movement.UpdateSoundCoords(data.id, data.x, data.y, data.z);
	} else if (action === "updateSound") {
		JS17Movement.UpdateSound(data.id, data.x, data.y, data.z, data.h);
	} else if (action === "stopSound") {
		JS17Movement.StopSound(data.id);
	} else if (action === "showCrosshair") {
		JS17Movement.ToggleCrosshair(true);
	} else if (action === "hideCrosshair") {
		JS17Movement.ToggleCrosshair(false);
	}
});

function closeHUD() {
	if (showingInvite) {
		reactInvite(false);
	}

	$(".mainScreen").fadeOut(250);
	$(".multiplayerMenu").fadeOut(250);
	$("#inviteScreen").fadeOut(250);
	$("#warningScreen").fadeOut(250);
	$("#tutorialScreen").fadeOut(250);
	$("#customScreen").fadeOut(250);

	JS17Movement.Post(`menuClosed`);

	if (tutorialActive) {
		tutorialActive = false;
		JS17Movement.Post(`tutorialClosed`);
	}

	if (counterActive) $("#counter").css("display", "block").hide().fadeIn(250);
}

window.addEventListener("keydown", (e) => {
	const key = e.key.toLowerCase();

	if (key === "escape") {
		closeHUD();
	}
});
