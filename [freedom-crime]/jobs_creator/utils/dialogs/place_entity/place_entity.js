async function placeEntity(model, entityType, placedEntities) {
	$("html").hide();

	const data = await $.post(`https://${resName}/placeEntity`, JSON.stringify({ model, entityType, placedEntities }));
	
	$("html").show();

	return data;
}
