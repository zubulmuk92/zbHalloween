ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(100)
	end
end)

-- Client event

RegisterNetEvent("zubul:zync")
AddEventHandler("zubul:zync", function()

    -- déclaration joueur
    local plyPed = PlayerPedId()

    print("'dqsdk qsld ")
    TriggerServerEvent('palsearp:serverSyncHalloween',plyPed)

end)

RegisterNetEvent("zubul:commencerEvent")
AddEventHandler("zubul:commencerEvent", function(x,y,z,radius)

    Citizen.CreateThread(function()
    
        local blip = AddBlipForRadius(x, y, z , radius) -- you can use a higher number for a bigger zone

        SetBlipHighDetail(blip, true)
        SetBlipColour(blip, 1)
        SetBlipAlpha (blip, 128)

        local blip = AddBlipForCoord(x, y, z)

        SetBlipSprite (blip, 162)
        SetBlipDisplay(blip, 4)
        SetBlipScale  (blip, 1.0)
        SetBlipColour (blip, 1)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("~o~HALLOWEEN~w~ : EVENEMENT")
        EndTextCommandSetBlipName(blip)
    
    end)

    --x2=x-100
    --y2=y-100

    main(x,y,z,radius)

end)

RegisterNetEvent("zubul:eventPourRamasser")
AddEventHandler("zubul:eventPourRamasser", function(eventencours)


        while eventencours == true do
            Citizen.Wait(1)
            local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
            local citrouilleProche = GetClosestObjectOfType(x, y, z, 40.0, "pumpkinreal", false, false, false)
            local jackoProche = GetClosestObjectOfType(x, y, z, 40.0, "jackolantern", false, false, false)
            local x2,y2,z2 = table.unpack(GetEntityCoords(citrouilleProche))
            local x3,y3,z3 = table.unpack(GetEntityCoords(jackoProche))

            local distanceargent = GetDistanceBetweenCoords(x, y, z, x2, y2, z2, true)
            local distancepb = GetDistanceBetweenCoords(x, y, z, x3, y3, z3, true)
    
            if distanceargent < 2.0 then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour rammasser la ~o~citrouille~w~")
                if IsControlJustReleased(0, 38) then
                    SetModelAsNoLongerNeeded("pumpkinreal")
                    DeleteEntity(citrouilleProche) -- si c'est pendant l'event
                    DeleteObject(citrouilleProche) -- si c'est apres l'event dcp evite le glitch
                    TriggerServerEvent("palsearp:gainHalloweenArgent")
                end
            elseif distancepb < 2.0 then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour rammasser la ~r~Jack'O'Lantern~w~")
                if IsControlJustReleased(0, 38) then
                    SetModelAsNoLongerNeeded("jackolantern")
                    DeleteEntity(jackoProche) -- si c'est pendant l'event
                    DeleteObject(jackoProches) -- si c'est apres l'event dcp evite le glitch
                    TriggerServerEvent("palsearp:gainHalloweenPb")
                end
            -- LOPTIMISATIONNNNNNNNNNNNNNNNN
            elseif distanceargent > 20.0 and distancepb > 20.0 then
                Citizen.Wait(1500)
            elseif distanceargent > 10.0 and distancepb > 10.0 then
                Citizen.Wait(500)
            elseif distanceargent > 5.0 and distancepb > 5.0 then
                Citizen.Wait(200)
            end
        end

end)

-- Fonctions

function create_object(object_model,x,y,z)
    Citizen.CreateThread(function()
        Citizen.Wait(5)
         RequestModel(object_model)
         local iter_for_request = 1
         while not HasModelLoaded(object_model) and iter_for_request < 5 do
             Citizen.Wait(500)				
             iter_for_request = iter_for_request + 1
         end
         if not HasModelLoaded(object_model) then
             SetModelAsNoLongerNeeded(object_model)
         else
             local ped = PlayerPedId()
             local bool,nouveauz = GetGroundZFor_3dCoord(x,y,z,true) -- on essaye de placer le props le plus proprement possible
             local created_object = CreateObjectNoOffset(object_model, x, y, nouveauz, 1, 1, 1)
             FreezeEntityPosition(created_object,true)
             SetModelAsNoLongerNeeded(object_model)
          end
    end)
end

local xspawn,yspawn,zspawn = 0.0,0.0,0.0

local iteration = zbConfig.nombreDeProps -- plus vous avez de joueur plus vous devrez baisser cette valeur

local eventencours = false

function main(x,y,z,radius)

        for i=0 ,iteration do
            Citizen.Wait(10) -- on va éviter de trop spam les spawns de props (la boucle reste bien assez rapide par  rapport a la demande)

            chance = math.random(1,2)
            chance2 = math.random(1,10)

            if chance == 1 then
                xspawn = x-(math.random()+math.random(1,100))
                yspawn = y-(math.random()+math.random(1,100))

                local blip = AddBlipForCoord(xspawn, yspawn, z)

                SetBlipSprite (blip, 162)
                SetBlipDisplay(blip, 4)
                SetBlipScale  (blip, 1.0)
                SetBlipColour (blip, 1)
                SetBlipAsShortRange(blip, true)

                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString("aaaaaaaaa")
                EndTextCommandSetBlipName(blip)

                
                if chance2 == 1 then
                    create_object("jackolantern",xspawn,yspawn,z)
                else
                    create_object("pumpkinreal",xspawn,yspawn,z)
                end
            elseif chance == 2 then
                xspawn = x+(math.random()+math.random(1,100))
                yspawn = y+(math.random()+math.random(1,100))

                local blip = AddBlipForCoord(xspawn, yspawn, z)

                SetBlipSprite (blip, 162)
                SetBlipDisplay(blip, 4)
                SetBlipScale  (blip, 1.0)
                SetBlipColour (blip, 1)
                SetBlipAsShortRange(blip, true)

                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString("bbbbbbbbb")
                EndTextCommandSetBlipName(blip)

                if chance2 == 1 then
                    create_object("jackolantern",xspawn,yspawn,z)
                else
                    create_object("pumpkinreal",xspawn,yspawn,z)
                end
            end

        end

        local eventencours = true
        TriggerEvent("zubul:eventPourRamasser",eventencours)
end

Citizen.CreateThread(function()

    while true do
        Citizen.Wait(5)

        local plyCoords = GetEntityCoords(plyPed)

        TriggerServerEvent('palsearp:serverSyncHalloween')

        Citizen.Wait(500000)


    end

end)