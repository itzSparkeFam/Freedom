exports('SaveResourceFile', (path, data)=>{
	if(!path || !data) return false
	const fs=require('fs')
	try {
		fs.writeFileSync(path, data, 'utf8')
	} catch(e){
		return false
	}
	return true
})