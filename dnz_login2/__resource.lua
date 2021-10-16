resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    "server.lua",
    "config.lua",
}

client_scripts {
    'html/index.html',
    'html/index.js',
    'html/index.css',
    'html/11.png',
    'html/cursor.png',
    'html/reset.css',
    'config.lua',
    'nui.lua'
}


ui_page "html/index.html"

files {
    'html/index.html',
    'html/index.js',
    'html/index.css',
    'html/11.png',
    'html/cursor.png',
    'html/reset.css',
    'config.lua'
}
