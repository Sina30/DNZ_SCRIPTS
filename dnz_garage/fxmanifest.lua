fx_version 'adamant'

game 'gta5'

description 'dnz_garage'

version '1.0.0'

ui_page 'html/ui.html'

files {
	--Webseite
	'html/ui.html',
	'html/styles.css',
	'html/scripts.js',
	'html/bootstrap.min.css',
	--Fahrzeuge
	'html/fahrzeuge/*.png'
}

server_scripts {
	'@es_extended/locale.lua',
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'server/main.lua' -- letzter ohne komma, für nobrainer -dnz
}

client_scripts {
	'config.lua',
	'client/main.lua' -- letzter ohne komma, für nobrainer -dnz
}
