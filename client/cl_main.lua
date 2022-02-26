---@author Razzwaay
---@version 1.0
---@public
ESX, isFarming = nil, false

CreateThread(function()
    while ESX == nil do
        TriggerEvent(_Config.getESX, function(object) ESX = object end)
        Wait(10)
    end

    if _Config.showBlips then
        for _, btc in pairs(_Config.position.farm.interactionZone) do
            local blip = AddBlipForCoord(btc.pos)
            SetBlipSprite(blip, _Config.position.farm.infoBlip.Sprite)
            SetBlipDisplay(blip, _Config.position.farm.infoBlip.Display)
            SetBlipScale(blip, _Config.position.farm.infoBlip.Scale)
            SetBlipColour(blip, _Config.position.farm.infoBlip.Color)
            SetBlipAsShortRange(blip, _Config.position.farm.infoBlip.Range)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(_Config.position.farm.infoBlip.Name)
            EndTextCommandSetBlipName(blip)
        end

        for _, sell in pairs(_Config.position.sell.interactionZone) do
            local blip = AddBlipForCoord(sell.pos)
            SetBlipSprite(blip, _Config.position.sell.infoBlip.Sprite)
            SetBlipDisplay(blip, _Config.position.sell.infoBlip.Display)
            SetBlipScale(blip, _Config.position.sell.infoBlip.Scale)
            SetBlipColour(blip, _Config.position.sell.infoBlip.Color)
            SetBlipAsShortRange(blip, _Config.position.sell.infoBlip.Range)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(_Config.position.sell.infoBlip.Name)
            EndTextCommandSetBlipName(blip)
        end
    end

    if _Config.showPed then
        for _, ped in pairs(_Config.position.sell.interactionZone) do
            while (not HasModelLoaded(ped.pedModel)) do
                RequestModel(ped.pedModel)
                Wait(1)
            end
            local nwPed = CreatePed(2, GetHashKey(ped.pedModel), ped.pedPos, ped.heading, 0, 0)
            FreezeEntityPosition(nwPed, 1)
            if _Config.scenarioPed then
                TaskStartScenarioInPlace(nwPed, _Config.scenarioName, 0, false)
            end
            SetEntityInvincible(nwPed, true)
            SetBlockingOfNonTemporaryEvents(nwPed, 1)
            npc = nwPed
        end
    end

    while true do
        local interval = 500

        for _, btc in pairs(_Config.position.farm.interactionZone) do
            local pCoords, interactionPos = GetEntityCoords(PlayerPedId()), btc.pos

            if #(pCoords-interactionPos) < 9.0 then
                interval = 0
                DrawMarker(_Config.Marker.Type, interactionPos, 0, 0, 0, _Config.Marker.Rotation, nil, nil, _Config.Marker.Size[1], _Config.Marker.Size[2], _Config.Marker.Size[3], _Config.Marker.Color[1], _Config.Marker.Color[2], _Config.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
            end
            if #(pCoords-interactionPos) < 1.2 then
                if not isFarming then
                    ESX.ShowHelpNotification('~y~Bitcoin~s~ \nAppuyez sur ~INPUT_CONTEXT~ pour miner.')
                end
                if not isFarming and IsControlJustReleased(0, 54) and IsPedOnFoot(PlayerPedId()) then
                    isFarming = true
                    TriggerServerEvent((_Config.Prefix..'%s'):format(_Config.Events.startHarvest))
                end
            elseif #(pCoords-interactionPos) < 3.0 and isFarming then
                isFarming = false
                TriggerServerEvent((_Config.Prefix..'%s'):format(_Config.Events.stopHarvest))
                if _Config.antiMoonwalk then
                    Wait(2800)
                end
            end
        end

        for _, sell in pairs(_Config.position.sell.interactionZone) do
            local pCoords, interactionPos = GetEntityCoords(PlayerPedId()), sell.pos

            if #(pCoords-interactionPos) < 1.0 then
                interval = 0
                ESX.ShowHelpNotification('~y~Bitcoin~s~ \nAppuyez sur ~INPUT_CONTEXT~ pour intéragir avec l\'acheteur')
                if IsControlJustReleased(0, 54) and IsPedOnFoot(PlayerPedId()) then
                    PlayAmbientSpeech1(npc, "GENERIC_HI", "SPEECH_PARAMS_FORCE_NORMAL_CLEAR")
                    Client:openSellMenu(bitcoin)
                end
            end
        end

        Wait(interval)
    end
end)
