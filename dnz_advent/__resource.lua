resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

client_script "nui.lua"
server_script "server.lua"
ui_page "html/index.html"
server_script('@mysql-async/lib/MySQL.lua')
files {
    'html/index.html',
    'html/index.js',
    'html/index.css',
    'html/reset.css',
    'html/hat.png',
    'html/gift-box.png',
    'html/candy-cane.png',
    'html/512x512.png'
}
