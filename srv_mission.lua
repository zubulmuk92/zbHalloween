ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

-- fonction

function givePb(nombre)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    MySQL.Async.fetchAll(
		'SELECT * FROM users WHERE identifier = @identifier',
		{
			['@identifier'] = xPlayer.identifier
		},
		function(result)

            local pbsolde = result[1].fivecoin
			local pbagagner = pbsolde + nombre

            MySQL.Async.execute(
                'UPDATE users SET fivecoin = @fivecoin WHERE identifier = @identifier',
                 {
                     ['@fivecoin']     = pbagagner,
                     ['@identifier'] = xPlayer.identifier
                 }
            )
		end
    )


end

RegisterNetEvent("palsearp:serverSyncHalloween")
AddEventHandler("palsearp:serverSyncHalloween", function()
    local choixDeLaTab = math.random(1,2)

    local xPlayers = ESX.GetPlayers()

    for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('zubul:commencerEvent', xPlayers[i],zbConfig.tabCoords[choixDeLaTab].x,zbConfig.tabCoords[choixDeLaTab].y,zbConfig.tabCoords[choixDeLaTab].z,200.0)
        TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Palsea V3', '~o~HALLOWEEN', "Prenez garde~w~ !\nDes ~o~citrouilles~w~ sont apparues , allez les ~g~récupérer~w~ pour recevoir un ~o~cadeau~w~.", 'CHAR_ABIGAIL', 8)
	end

end)

RegisterNetEvent("palsearp:serverSyncHalloweenFin")
AddEventHandler("palsearp:serverSyncHalloweenFin", function()
    local xPlayers = ESX.GetPlayers()

    for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Palsea V3', '~o~HALLOWEEN', "Fin de l'évènement. Les citrouilles sont toujours présentes sur le lieu !", 'CHAR_ABIGAIL', 8)
	end

end)

RegisterNetEvent("palsearp:gainHalloweenArgent")
AddEventHandler("palsearp:gainHalloweenArgent", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local argent = math.random(zbConfig.argentParCitrouilleMin,zbConfig.argentParCitrouilleMax)
    xPlayer.addAccountMoney('money', argent)

    TriggerClientEvent('esx:showAdvancedNotification', _source, 'Palsea V3', '~o~HALLOWEEN', "Tu as ~g~ramassé~w~ une ~o~citrouille~w~.\nTu as gagné : ~g~"..argent.."~w~$.", 'CHAR_ABIGAIL', 8)

end)

RegisterNetEvent("palsearp:gainHalloweenPb")
AddEventHandler("palsearp:gainHalloweenPb", function()
    local _source = source

    local pb = math.random(zbConfig.pbParJackoMin,zbConfig.pbParJackoMax)
    givePb(pb)
    TriggerClientEvent('esx:showAdvancedNotification', _source, 'Palsea V3', '~o~HALLOWEEN', "Tu as ~g~ramassé~w~ un ~r~cercueil~w~.\nTu as gagné : ~g~"..pb.."~w~ ~g~Palsea~w~Coin.", 'CHAR_ABIGAIL', 8)

end)

Citizen.CreateThread(function()

    while true do 

        Citizen.Wait(5)

        TriggerEvent("palsearp:serverSyncHalloween")

        Citizen.Wait(zbConfig.eventReplay)

    end

end)

--=========    Script réalisé par zubulmuk92     =========--