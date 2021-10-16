resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

client_script {
    'client/client.lua',
    'config.lua'
}

server_script {
    'server/server.lua',
    'config.lua'
}

ui_page "client/html/index.html"

files {
    'client/html/index.html',
    'client/html/index.js',
    'client/html/bootstrap.min.css',
    'client/html/index.css',
    'client/html/bilder/*.png',
    'client/html/reset.css'
}


dependencies {
	'esx_vehicleshop'
}