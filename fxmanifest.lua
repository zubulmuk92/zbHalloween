fx_version 'adamant'

game 'gta5'

author "zubulmuk92"

shared_script {
    "zbConfig.lua"
}

server_script {
    '@async/async.lua',
	'@mysql-async/lib/MySQL.lua',
    "srv_mission.lua",
}

client_script {
    "cl_mission.lua",
}

dependency 'es_extended'

