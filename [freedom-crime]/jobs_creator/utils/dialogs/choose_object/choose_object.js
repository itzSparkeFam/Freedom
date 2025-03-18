const ITEM_TYPES = {
    item: {icon: "bi bi-box", color: "#b8e994"},
    weapon: {icon: "bi bi-radioactive", color: "#d35400"},
    account: {icon: "bi bi-wallet2", color: "#f1c40f"},
}

let previousObject = null;
let isMetadataDisabled = false;
let isDialogOpen = false;

function addDivForMetadataField(parentDiv, fieldId, fieldValue, fieldType="string") {
    const div = $(`
        <div class="field-div d-flex justify-content-center align-items-center gap-3 mb-4">
            <button type="button" class="btn-close"></button>

            <div class="input-group">
                <input type="text" class="form-control font-monospace w-25 field-id" placeholder="Field ID" required>

                <select class="form-select field-type-select">
                    <option value="string">String</option>
                    <option value="number">Number</option>
                    <option value="boolean">Bool</option>
                </select>
                
                <input type="text" class="form-control field-value-input w-25" data-field-type="string" placeholder="A tasty apple" style="display:none;">
                <input type="number" step="0.01" class="form-control field-value-input w-25" data-field-type="number" placeholder="1074" style="display:none;">
                <select class="form-select field-value-input w-25" data-field-type="boolean" style="display:none;">
                    <option value="true" selected>True</option>
                    <option value="false">False</option>
                </select>
            </div>
        </div>
    `);

    if (fieldId) div.find(".field-id").val(fieldId);

    if (fieldValue !== undefined && fieldValue !== null) {
        fieldType = typeof fieldValue;
        div.find(`.field-value-input[data-field-type='${fieldType}']`).val(fieldValue.toString());
    }

    if (fieldType) {
        div.find(".field-type-select").val(fieldType);
        div.find(`.field-value-input[data-field-type='${fieldType}']`).prop("required", true).show();
    }

    div.find(".field-type-select").change(function() {
        const fieldType = $(this).val();

        div.find(".field-value-input").prop("required", false).hide();
        div.find(`.field-value-input[data-field-type='${fieldType}']`).prop("required", true).show();
    });
    
    div.find(".btn-close").click(function() { div.remove(); });

    parentDiv.append(div);
}

async function metadataDialog(oldMetadata={}) {
    let resolve = null;
    const promise = new Promise((res) => { resolve = res; });

    const div = $(`
        <div class="modal fade" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" role="dialog" style="z-index: 1070;">
            <div class="modal-dialog modal-dialog-centered" role="document">
            <form class="modal-content needs-validation" novalidate>
                <div class="modal-header">
                    <h5 class="modal-title">${getLocalizedText("menu:items_dialog:title")}</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">

                    <div class="metadata-fields-list">

                    </div>

                </div>
				<div class="modal-footer">
                    <div class="d-flex col">
                        <button type="button" class="btn btn-info add-metadata-field-btn float-start">Add field</button>
                    </div>

					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">${getLocalizedText("menu:close")}</button>
					<button type="submit" class="btn btn-success">${getLocalizedText("menu:input_text:confirm")}</button>
				</div>
            </form>
        </div>
    `);

    div.find(".add-metadata-field-btn").click(function() {
        const parentDiv = div.find(".metadata-fields-list");
        addDivForMetadataField(parentDiv);
    });

    for(const [fieldId, fieldValue] of Object.entries(oldMetadata)) {
        addDivForMetadataField(div.find(".metadata-fields-list"), fieldId, fieldValue);
    }

    // delete the div when the modal is closed
    div.on("hidden.bs.modal", function() {
        div.remove();
    });
    
    div.modal("show");

    div.find("form").submit(function(event) {
        if(isThereAnyErrorInForm(event)) return;

        const metadata = {};
        let foundAny = false;

        div.find(".field-div").each(function() {
            const fieldId = $(this).find(".field-id").val();
            const fieldType = $(this).find(".field-type-select").val();
            let fieldValue = $(this).find(`.field-value-input[data-field-type='${fieldType}']`).val();

            if(fieldType == "number") fieldValue = parseFloat(fieldValue);
            else if(fieldType == "boolean") fieldValue = fieldValue == "true";

            metadata[fieldId] = fieldValue;

            foundAny = true;
        });

        
        div.modal("hide");
        
        if(!foundAny) { resolve(null); return; };

        resolve(metadata);
    });

    return promise;
}

function appendObjectToItemsList(object, itemsListDiv) {
    let objectDiv = $(`
        <li class="list-group-item list-group-item-action clickable object-li" data-object-name="${object.name}">
            <i class="${ITEM_TYPES[object.type].icon}" title="${object.type}" data-bs-toggle="tooltip" data-bs-placement="top"></i>
            <span class="ms-2 object-label-span" title="${object.name}" data-bs-toggle="tooltip" data-bs-placement="right">${object.label}</span>
        </li>
    `);
    
    // Keeps old metadata
    if(object.name === previousObject?.name && !isMetadataDisabled) {
        object.metadata = previousObject.metadata;
    }

    if(object.type == "item" && !isMetadataDisabled) {
        const editMetadataBtn = $(`
            <button type="button" class="edit-metadata-btn btn p-0 border-0 float-end" data-bs-toggle="tooltip" data-bs-placement="left" title="Metadata">
                <i class="bi bi-pencil-square"></i>
            </button>
        `);

        objectDiv.append(editMetadataBtn);
    }

    objectDiv.hover(function() {
        objectDiv.find("[data-bs-toggle='tooltip']").tooltip();
    }, function() {
        objectDiv.find("[data-bs-toggle='tooltip']").tooltip("hide");
    });

    objectDiv.find(".edit-metadata-btn").click(async function(e) {
        e.stopPropagation();

        let object = objectDiv.data("object");
        
        let newMetadata = await metadataDialog(object.metadata);
        if (!newMetadata) return;

        object.metadata = newMetadata;
        objectDiv.data("object", object);
    });
    
    if(object.isManualInput) {
        objectDiv.find(".object-label-span").addClass("font-monospace fw-light").attr("title", "Manual input")
        objectDiv.addClass("manual-input-div");
        objectDiv.hide();
    }

    objectDiv.css("color", ITEM_TYPES[object.type].color);
    objectDiv.data("object", object);

    itemsListDiv.append(objectDiv);

    return objectDiv;
}

async function chooseObject(oldObject, metadataDisabled) {
    if(isDialogOpen) return;
    isDialogOpen = true;

    previousObject = oldObject;
    isMetadataDisabled = metadataDisabled;

    let resolve = null;
    const promise = new Promise((res) => { resolve = res; });
    
    const div = $(`
        <div class="modal fade" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" role="dialog" style="z-index: 1070;">
            <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">${getLocalizedText("menu:items_dialog:title")}</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body pt-0">
                    <div class="input-group">
                        <span class="input-group-text">${getLocalizedText("menu:items_dialog:search_item")}</span>
                        <input type="text" class="form-control item-search" placeholder="Name | ID | Type">
                    </div>
    
                    <ul class="list-group mt-2 items-list scrollbar" style="overflow: auto; max-height: 70vh">           
                        
                    </ul>
                </div>
            </div>
        </div>
    `);

    let objects = await $.post(`https://${resName}/getAllObjects`);
    objects = objects
        .filter(object => object && object.name && object.label && object.type && typeof object.label == "string")
        .sort((a, b) => a.label.localeCompare(b.label));

    objects.push(
        {type: "item", label: "Manual input", name: "manual_input", isManualInput: true},
        {type: "weapon", label: "Manual input", name: "manual_input", isManualInput: true},
        {type: "account", label: "Manual input", name: "manual_input", isManualInput: true}
    );

    let itemsListDiv = div.find(".items-list");

    // delete the div when the modal is closed
    div.on("hidden.bs.modal", function() {
        isDialogOpen = false;
        div.remove();
        resolve(null);
    });

    div.on("shown.bs.modal", function() {
        div.find(".item-search").focus();
    });
    
    div.find(".item-search").val("").on("keyup", function() {        
        const rawVal = $(this).val();
        const lowercaseVal = rawVal.toLowerCase();
        const valToId = rawVal.replaceAll(" ", "_");
    
        div.find(".items-list li").each(function() {
            const object = $(this).data("object");

            let canShow = lowercaseVal == "" || object.label.toLowerCase().indexOf(lowercaseVal) > -1 || object.name.toLowerCase().indexOf(lowercaseVal) > -1 || object.type.toLowerCase().indexOf(lowercaseVal) > -1;
            $(this).toggle(canShow)
        });

        const manualInputDiv = div.find(".manual-input-div");

        if (rawVal) {
            let object = manualInputDiv.data("object");
            object.label = valToId;
            object.name = valToId;
            manualInputDiv.data("object", object);
            
            manualInputDiv.find(".object-label-span").text(valToId);
            manualInputDiv.show();
        } else {
            manualInputDiv.hide();
        }
    });

    div.modal("show");

    objects.forEach(thisObj => {
        const objectDiv = appendObjectToItemsList(thisObj, itemsListDiv);

        objectDiv.click(function() {
            let object = $(this).data("object");
            div.modal("hide");
            resolve(object);
        });
    });

    return promise;
}

function setChoosenObject(chooseObjectDiv, object) {
    const objectInput = chooseObjectDiv.find(".choose-object-label");
    objectInput.tooltip("dispose");

    if(!object) {
        objectInput.data("object", null);
        objectInput.val("");
        return;
    }

    objectInput.data("object", object);
    objectInput.val(object.label);

    if(object.metadata) {
        objectInput.tooltip({title: `${object.type}: ${object.name}<br><span class="font-monospace">${JSON.stringify(object.metadata)}<span>`, placement: "top", html: true});
    } else {
        objectInput.tooltip({title: `${object.type}: ${object.name}`, placement: "top"});
    }
}

function getChoosenObject(chooseObjectDiv) {
    return chooseObjectDiv.find(".choose-object-label").data("object");
}

function loadChooseObjectDivs(elements, oldObject) {
    if(!elements) return;

    elements.each(function() {
        const chooseObjectDiv = $(this);
        const chooseObjectBtn = chooseObjectDiv.find(".choose-object-btn");
        const objectInput = chooseObjectDiv.find(".choose-object-label");
        objectInput.prop("disabled", true); // User can't edit it anyway

        const metadataDisabled = chooseObjectDiv.attr("data-metadata-disabled") != undefined;

        chooseObjectBtn.click(async function() {
            let object = await chooseObject(objectInput.data("object"), metadataDisabled);
            setChoosenObject(chooseObjectDiv, object);
        });

        if(oldObject) setChoosenObject(chooseObjectDiv, oldObject);
    });
}

function createDivForObjectChoose(object) {
    const div = $(`
        <div class="choose-object-div input-group col" data-metadata-disabled>
            <input type="text" class="form-control choose-object-label" placeholder="Item ID">
            <button type="button" class="btn btn-secondary choose-object-btn" data-bs-toggle="tooltip" data-bs-placement="top" title="${getLocalizedText("menu:dialog:choose_item")}"><i class="bi bi-list-ul"></i></button>
        </div>
    `);

    loadChooseObjectDivs(div);
    setChoosenObject(div.find(".choose-object-label"), object);

    return div;
}

// Loads the choose object divs in .html (not in js)
loadChooseObjectDivs( $(".choose-object-div") );