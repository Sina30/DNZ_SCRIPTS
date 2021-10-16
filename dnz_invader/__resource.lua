resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

client_script {
    "nui.lua",
    "config.lua"
}
ui_page "html/index.html"
files {
    'html/index.html',
    'html/index.js',
    'html/index.css',
    'html/reset.css',
    'html/img/exit.png',
    'html/img/invaderlogo.png',
    'html/img/links.png',
    'html/img/rechts.png'
}

server_scripts {  
    'server.lua',
    "config.lua"
}
