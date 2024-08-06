fx_version 'cerulean'
game 'gta5'

author 'TheMach1neDK'
description 'Dette script tillader at man kan oprette tabeller i databasen ingame'
lua54 'yes'

shared_script '@ox_lib/init.lua'


server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/server.lua'
}

client_scripts {
    'client/client.lua'
}