fx_version 'cerulean'
author 'Mirow'
version '1.0.0'
game 'gta5'

lua54 'yes'

client_scripts {
    'example.lua',
    'source/nui.lua',
    'source/main.lua',
    'job.lua'
}

ui_page 'web/dist/index.html'
files {
    'web/dist/**/*'
}