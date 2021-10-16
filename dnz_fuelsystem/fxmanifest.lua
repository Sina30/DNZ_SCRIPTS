fx_version 'bodacious'
game 'gta5'

client_scripts {
	'config.lua',
	'functions/functions_client.lua',
	'source/fuel_client.lua',
	'html/index.html',
    'html/index.js',
    'html/index.css',
	'html/reset.css',
	'html/img/tanke.png'
}

server_scripts {
	'config.lua',
	'source/fuel_server.lua'
}

exports {
	'GetFuel',
	'SetFuel'
}

ui_page "html/index.html"