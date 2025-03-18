/// <reference types="@citizenfx/server" />
/// <reference types="image-js" />
/// <reference types="axios" />
/// <reference types="form-data" />

const { Image } = require('image-js')
const axios = require('axios')
let FormData = require('form-data')
let fs = require('fs')

async function removeGreenScreen(inputPath) {
  const image = await Image.load(inputPath)

  image.resize({
    width: image.width,
    height: image.height,
    fill: 'transparent',
  })

  image.data.forEach((_, index) => {
    const r = image.data[index * 4]
    const g = image.data[index * 4 + 1]
    const b = image.data[index * 4 + 2]

    if (r < 100 && g > 150 && b < 100) {
      image.data[index * 4 + 3] = 0
    }
  })

  return image.toDataURL()
}

async function TakeScreenShot(source, name, upload) {
  return new Promise((resolve, _) => {
    exports['screenshot-basic'].requestClientScreenshot(
      source,
      {
        encoding: 'png',
        quality: 1.0,
      },
      async (err, fileName) => {
        if (err) {
          console.error('Screenshot error:', err)
          resolve({ success: false })
        }
        try {
          const img = await removeGreenScreen(fileName)
          let data = JSON.stringify({
            file: img,
          })

          const buffer = Buffer.from(img.split(',')[1], 'base64')

          const formData = new FormData()

          // Attach the file
          formData.append('file', buffer, { filename: 'image.png' })

          // Optional message
          formData.append(
            'payload_json',
            JSON.stringify({ content: 'Here is the image!' })
          )
          // Optional metadata field (JSON string)
          formData.append(
            'metadata',
            JSON.stringify({
              name: 'My image',
              description: 'This is my image',
            })
          )

          if (
            upload.screenshot == 'fivemanage' ||
            upload.screenshot == 'discord'
          ) {
            axios
              .post(upload.server, formData, {
                headers: upload.headers,
              })
              .then((res) => {
                resolve({
                  success: true,
                  data:
                    upload.screenshot == 'discord'
                      ? res.data.attachments[0].proxy_url
                      : res.data.url,
                })
              })
              .catch((err) => {
                console.error(err)
              })
          } else {
            let config = {
              method: 'post',
              maxBodyLength: Infinity,
              url: upload.server,
              headers: upload.headers,
              data: data,
            }

            axios
              .request(config)
              .then((response) => {
                if (img) {
                  resolve({
                    success: true,
                    data:
                      upload.screenshot == 'discord'
                        ? response.data.attachments[0].proxy_url
                        : response.data.url,
                  })
                }
              })
              .catch((error) => {
                console.log(error)
              })
          }
        } catch (err) {
          console.error('Error removing green screen:', err)
          resolve({ success: false })
        }
      }
    )
  })
}

exports('TakeScreenShot', TakeScreenShot)

async function FileToBase64(path) {
  var bitmap = fs.readFileSync(path)
  // convert binary data to base64 encoded string
  return Buffer.from(bitmap).toString('base64')
}
exports('FileToBase64', FileToBase64)
