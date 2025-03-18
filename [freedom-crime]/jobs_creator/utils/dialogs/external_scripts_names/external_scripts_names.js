let allResources = [];
let externalScriptsNames = {};

async function getAllResources() {
    const resources = await $.post(`https://${resName}/getAllResources`);
    return resources;
}

async function getIntegrationsResources() {
    const resources = await $.post(`https://${resName}/getIntegrationsResources`);
    return resources;
}

async function resourcesDialog() {
    let resolve, reject;
    let promise = new Promise((res, rej) => { resolve = res; reject = rej; });
    
    const div = $(`
    <div class="modal fade" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" role="dialog" style="z-index: 1070;">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">${ getLocalizedText("menu:dialogs:resources") }</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body text-center">
                    <div class="scrollbar" style="max-height:60vh; overflow-y:auto; overflow-x:hidden;">
                        <div class="resources-list">

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    `);
    
    // delete the div when the modal is closed
    div.on("hidden.bs.modal", function() {
        div.remove();
        resolve();
    });

    div.modal("show");

    let resourcesList = div.find(".resources-list");

    const resources = await getAllResources();
    resourcesList.empty();

    resources.forEach(resource => {
        const resourceDiv = createDivForResource(resource);

        resourceDiv.click(() => {
            div.modal("hide");
            resolve(resource.name);
        });

        resourcesList.append(resourceDiv);
    });

    return promise;
}

function getLegendForState(state) {
    switch(state) {
        case "started": return "bg-success";
        case "stopped": return "bg-danger";
        default: return "";
    }
}

function createDivForResource(resource) {
    const div = $(`
    <span class="resource-span d-flex align-items-center lh-large" role="button">
        <span class="legend-circle-lg ${getLegendForState(resource.state)}"></span>
        <span>${resource.name} ${resource.version || ""}</span>
        ${ resource.author ?
            `<span class="ms-2 badge bg-info">
                ${resource.author}
            </span>`
            : "" }
    </span>
    `);

    // Tooltip
    div.find(".legend-circle-lg").tooltip({
        title: resource.state,
        placement: "left",
        trigger: "hover",
    });

    return div;
}

function createDivForIntegration(resource) {
    const resName = resource.name;
    const div = $(`<button type="button" class="btn d-flex align-items-center py-1" data-integration-name="${resName}"></button>`);

    const resourceDiv = createDivForResource(resource);
    resourceDiv.appendTo(div);

    const newResName = externalScriptsNames[resName];
    if(newResName && newResName !== resName) {
        let newRes = allResources.find(r => r.name === newResName);
        
        if(!newRes) {
            newRes = {
                name: newResName,
                version: undefined,
                state: "stopped",
            };
        }
        
        $(`<i class="bi bi-arrow-right mx-3"></i>`).appendTo(div);
        createDivForResource(newRes).appendTo(div);

        resourceDiv.css("opacity", 0.3);
    }

    div.click(async function() {
        const newResource = await resourcesDialog() || resName;
        externalScriptsNames[resName] = newResource;
        loadIntegrationsSettings(externalScriptsNames);
    });

    return div;
}

async function loadIntegrationsSettings(newIntegrationsScripts) {
    externalScriptsNames = newIntegrationsScripts;
    const resources = await getIntegrationsResources();
    if(resources.length === 0) return;

    allResources = await getAllResources();

    const integrationsListDiv = $(".external-scripts-names-dialog");
    integrationsListDiv.empty();

    resources.forEach(resource => {
        const div = createDivForIntegration(resource);
        div.appendTo(integrationsListDiv);
    });
}

function getIntegrationSettings() {
    for (const [key, value] of Object.entries(externalScriptsNames)) {
        if(!value) {
            externalScriptsNames[key] = key;
        }
    }

    return externalScriptsNames;
}