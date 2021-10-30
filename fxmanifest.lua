fx_version 'adamant'

game 'gta5'

author "zubulmuk92"



-- SCRIPT



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



-- PROPS



this_is_a_map 'yes'

files {

    "stream/*.ymap",

    "stream/*.ytd",

    "stream/*.ydr",

    "stream/*.ybn",

    "stream/*.ytyp", 

    "stream/*.ymf",

    "stream/*.yft",

}

data_file "DLC_ITYP_REQUEST" "pumpkinreal_ytyp.ytyp"

data_file "DLC_ITYP_REQUEST" "jackolantern_ytyp.ytyp"
