
function addTabForWizard(wizardDiv, tab, active=false) {
    const { id, title, description, options } = tab;

    const li = $(`
        <li class="nav-item">
            <button class="nav-link" id="wizardTabOne" data-bs-toggle="pill" data-bs-target="#${id}" type="button" role="tab">
            ${title}
            </button>
        </li>
    `);

    if (active) {
        li.find('button').addClass('active');
    }

    wizardDiv.find(".nav").append(li);

    const tabContent = $(`
        <div class="tab-pane fade" id="${id}" role="tabpanel">
            <h4>${title}</h4>
            <p>${description}</p>
        </div>
    `);

    // TODO: ADD options
}

async function wizard(tabs=[]) {
    const div = $(`
        <div>
            <ul class="nav nav-pills steps mb-7 wizard-div" role="tablist">

            </ul>

            <div class="tab-content">

            </div>
        </div>
    `);
}