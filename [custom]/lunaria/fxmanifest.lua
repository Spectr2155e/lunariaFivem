fx_version 'adamant'
game 'gta5'

authors {
    "Spectr2155e",
    "Fifou1165",
    "Zeroak"
}
name 'lunaria'

client_scripts {
    "utils/dbutils/*.lua",
    "utils/functionutils.lua",
    "scripts/clientSide/**/*.lua",
    "menu/adminMenu/client.lua"
} 

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    "utils/dbutils/*.lua",
    "utils/functionutils.lua",
    "scripts/serverSide/**/*.lua",
    "menu/adminMenu/server.lua"
}

client_scripts {
    "src/RMenu.lua",
    "src/menu/RageUI.lua",
    "src/menu/Menu.lua",
    "src/menu/MenuController.lua",
    "src/components/*.lua",
    "src/menu/elements/*.lua",
    "src/menu/items/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/windows/*.lua"
}