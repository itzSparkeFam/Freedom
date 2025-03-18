Upload = {}

Upload.Method = 'fivemanage' -- discord, imgur, fivemanage, custom

Upload.Methods = {
    ['discord'] = {
        link = 'https://discord.com/api/webhooks/', -- your webhook link
        field = 'files[]',
        path = 'attachments.1.url',
        options = {
            encoding = 'webp' -- webp for small size, you can use png, jpg or png
        }
    },
    ['imgur'] = {
        link = 'https://api.imgur.com/3/upload',
        field = 'image',
        path = 'data.link',
        options = {
            headers = {
                ['Authorization'] = 'Client-ID YOUR_KEY_HERE' -- add your client id
            }
        }
    },
    ['fivemanage'] = {
        link = 'https://api.fivemanage.com/api/image',
        field = 'image',
        path = 'url',
        options = {
            encoding = 'png',
            headers = {
                ['Authorization'] = 'YOUR_KEY_HERE'
            }
        }
    },
    ['custom'] = {
        link = 'https://api.your_website.com/api', -- your api link
        field = 'file',
        path = 'link',
        options = {
            headers = {
                ['Authorization'] = 'Key YOUR_KEY_HERE'
            }
        }
    }
}
