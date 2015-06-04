require! {MD5, fs}

filename = 'users.json'
fileContent = fs.readFileSync filename, 'utf-8'
fileContent = fileContent.replace /"password":"(.*?)"/g, (p0, p1)-> "\"password\": \"#{MD5 p1}\""
fs.writeFileSync 'users_.json', fileContent
