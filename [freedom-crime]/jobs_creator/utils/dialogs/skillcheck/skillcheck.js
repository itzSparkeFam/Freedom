let skillCheckCSSLink = document.createElement("link");
skillCheckCSSLink.href = "../utils/dialogs/skillcheck/skillcheck.css";
skillCheckCSSLink.rel = "stylesheet";
skillCheckCSSLink.type = "text/css";
document.head.appendChild(skillCheckCSSLink);

window.addEventListener("message", e => {
	if (e.data.action !== "cancelSkillcheck") return;

	$(".skillcheck-container").remove();
	$('html').off("keydown.skillcheck");
});

window.addEventListener("message", e => {
	if (e.data.action !== "skillcheck") return;
	const speed = e.data.speed * 233

	$(".skillcheck-container").remove();
	let numSegments = 25,
		containerWidth = 400,
		gap = 4,
		segmentWidth = (containerWidth - (numSegments - 1) * gap) / numSegments,
		segmentUnit = segmentWidth + gap,
		correctBlocksCount = e.data.positiveBars,
		baseColors = { correct: "rgba(3, 110, 187, 0.8)", incorrect: "rgba(141, 17, 48, 0.8)" },
		highlightColors = { correct: "rgba(0, 200, 255, 0.96)", incorrect: "rgb(243, 23, 45)" },
		pattern = new Array(numSegments).fill("incorrect"),
		startIndex = Math.floor(Math.random() * (numSegments - correctBlocksCount + 1));
	for (let i = startIndex; i < startIndex + correctBlocksCount; i++) pattern[i] = "correct";
	let bar = $('<div id="bar-container" class="skillcheck-container"></div>').css({ width: containerWidth + "px", height: "70px" });
	for (let i = 0; i < numSegments; i++)
		$('<div class="segment"></div>')
			.attr("data-type", pattern[i])
			.css({ "background-color": baseColors[pattern[i]], width: segmentWidth + "px", height: "100%" })
			.appendTo(bar);
	$("body").append(bar);
	let cursorSpeed = speed, pos = 0, last = performance.now(), dir = 1, active = true, maxPos = containerWidth,
		pauseTime = null, pauseDuration = 0.1;
	function animate(t) {
		if (!active) return;
		let dt = (t - last) / 1000;
		last = t;
		if (pauseTime !== null) {
			if (t - pauseTime >= pauseDuration * 1000) { dir *= -1; pauseTime = null; }
			else { pos = (dir > 0) ? maxPos : 0; }
		} else {
			pos += cursorSpeed * dt * dir;
			if (pos >= maxPos) { pos = maxPos; pauseTime = t; }
			else if (pos <= 0) { pos = 0; pauseTime = t; }
		}
		let currentIndex = Math.min(Math.floor(pos / segmentUnit), numSegments - 1);
		bar.children(".segment").each((i, el) => {
			let seg = $(el), type = seg.attr("data-type");
			if (i === currentIndex)
				seg.css({ transition: "transform 0.2s ease, background-color 0.2s ease", "background-color": highlightColors[type], transform: "scale(1.4)" });
			else if (i === currentIndex - 1 || i === currentIndex + 1)
				seg.css({ transition: "transform 0.3s ease, background-color 0.3s ease", "background-color": highlightColors[type], transform: "scale(1.2)" });
			else if (i === currentIndex - 2 || i === currentIndex + 2)
				seg.css({ transition: "transform 0.4s ease, background-color 0.4s ease", "background-color": highlightColors[type], transform: "scale(1.1)" });
			else
				seg.css({ transition: "transform 0.5s ease, background-color 0.5s ease", "background-color": baseColors[type], transform: "scale(1)" });
		});
		requestAnimationFrame(animate);
	}
	requestAnimationFrame(animate);
	$('html').off("keydown.skillcheck").on("keydown.skillcheck", e => {
		if (!active) return;
		if ((e.key && e.key.toLowerCase() !== "e") && (e.which && e.which !== 69)) return;
		active = false;
		let currentIndex = Math.min(Math.floor(pos / segmentUnit), numSegments - 1),
			seg = bar.children(".segment").eq(currentIndex),
			type = seg.attr("data-type");
		$.post(`https://${resName}/skillCheckFinish`, JSON.stringify({ success: type === "correct" }));
		setTimeout(() => bar.remove(), 300);
	});
});