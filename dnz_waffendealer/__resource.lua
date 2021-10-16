resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

client_script {
    "nui.lua",
    'config.lua'
}

ui_page "html/index.html"

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    "server.lua",
    "config.lua",
}

files {
    'html/index.html',
    'html/index.js',
    'html/index.css',
    'html/reset.css',
    'html/eins.png',
    'html/zwei.png',
    'config.lua',
    'html/drei.png'
}
