fx_version 'cerulean'
game 'gta5'

author 'Markow'
description 'just a crafting system i think.'
version '1.0.0'
lua54 'yes'

client_scripts {
    'client/*.lua',
}

server_scripts {
    'server/*.lua',
}
shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
}
