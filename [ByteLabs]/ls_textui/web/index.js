async function fetchNui(event, data = {}) {
    try {
        const response = await fetch(`https://${GetParentResourceName()}/${event}`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8'
            },
            body: JSON.stringify(data)
        });

        const result = await response.json();
        return result;
    } catch (error) {
        return null;
    }
}

const App = Vue.createApp({
    data() {
        return {
            textUIs: [
            ],
        }
    },
    methods: {
        async onMessage(event) {
            if (event.data.type == "showTextUI") {
                if (typeof event.data.id != 'string' || typeof event.data.message != 'string' || 
                    (typeof event.data.key != 'string' && typeof event.data.icon != 'string')) return

                const exist = this.textUIs.some(ui => ui.id === event.data.id);

                if(!exist) {
                    this.textUIs.push({
                        id: event.data.id,
                        key: event.data.key || null,
                        icon: event.data.icon || null,
                        message: event.data.message,
                    });
                } else {
                    console.log('Text ui with the id is already exist')
                    return
                }
            } else if (event.data.type == 'hideTextUI') {
                this.textUIs = this.textUIs.filter(ui => ui.id !== event.data.id);
            } else if (event.data.type = 'getTextUIs') {
                const uiIds = this.textUIs.map(ui => ui.id);
                const timeout = new Promise((resolve) => setTimeout(() => resolve(false), 5000));
                
                try {
                    const result = await Promise.race([
                        fetchNui('returnTextUIs', uiIds),
                        timeout
                    ]);
                    
                    if (!result) {
                        console.log('Failed to get the ids');
                        return false;
                    }
                    
                    return result;
                } catch (error) {
                    console.error('Error occured when fetching the ids');
                    return false;
                }
            }
        },
    },
    async mounted() {
        window.addEventListener('message', this.onMessage);
    }
}).mount('#app');