local display = false
local PlayerData                = {}
ESX                             = nil
local firstspawn = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterCommand("exit", function(data)
    SetDisplay(false)
end)

Citizen.CreateThread(function ()
	while true do
        Citizen.Wait(0)
        DrawMarker(24, 1637.68, 2598.255, -52.421284, 0, 0, 0, 0, 0, 0, 1.0001,1.0001,1.0001, 244, 78, 78, 155, 0, 0, 0, 0, 0, 0, 0)-- Verarbeiter Position
                if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),  1637.68, 2598.255, -52.421284, true) < 1 then
                    if (IsControlJustReleased(1, 51)) then
                        SetDisplay(not display)
                    end
                end
        end
end)

Citizen.CreateThread(function ()
	while true do
        Citizen.Wait(300)
            if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),  1637.68, 2598.255, -52.421284, true) < 1 then-- Verarbeiter Position
                TriggerServerEvent('dnz_haze_arbeiter:abfrage')
            end
        end
end)

RegisterNUICallback('sammeln', function(data)
    TriggerServerEvent('dnz_haze_arbeiter:go')
end)

RegisterNetEvent('dnz_haze_arbeiter:antwort')
AddEventHandler('dnz_haze_arbeiter:antwort', function(_meinebaggies, _meinweed)
    meinebaggies = _meinebaggies
    meinweed = _meinweed
    SendNUIMessage({
        type = "test",
        meinebaggies = meinebaggies,
        meinweed = meinweed,
    })
end)

RegisterNUICallback("error", function(data)
    SetDisplay(false)
end)


RegisterNUICallback("exit", function(data)
    SetDisplay(false)
end)

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end

Citizen.CreateThread(function()
    while display do
        Citizen.Wait(0)
        DisableControlAction(0, 1, display) -- LookLeftRight
        DisableControlAction(0, 2, display) -- LookUpDown
        DisableControlAction(0, 142, display) -- MeleeAttackAlternate
        DisableControlAction(0, 18, display) -- Enter
        DisableControlAction(0, 322, display) -- ESC
        DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
    end
end)









Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        Citizen.Wait(1)
            if GetDistanceBetweenCoords(GetEntityCoords(ped), 1637.392, 2606.295, -52.42, true) < 2 then-- PED Position
                ESX.ShowHelpNotification("~INPUT_CONTEXT~ falls du dem typen Drogen anbieten willst")
                    if IsControlJustReleased(1, 51) then
                        Jeweler()                          
            end
        end
    end
 end)
    


 Citizen.CreateThread(function()
    local hash = GetHashKey("cs_movpremmale")

    if not HasModelLoaded(hash) then
        RequestModel(hash)
        Citizen.Wait(100)
    end

    while not HasModelLoaded(hash) do
        Citizen.Wait(0)
    end

    if firstspawn == false then
        local npc = CreatePed(6, hash, 1637.392, 2606.295, -53.42, 265.0, false, false) -- PED Position
        SetEntityInvincible(npc, true)
        FreezeEntityPosition(npc, true)
        SetPedDiesWhenInjured(npc, false)
        SetPedCanRagdollFromPlayerImpact(npc, false)
        SetPedCanRagdoll(npc, false)
        SetEntityAsMissionEntity(npc, true, true)
        SetEntityDynamic(npc, true)
		SetBlockingOfNonTemporaryEvents(npc, true)
    end
end)


function Jeweler()
    local elements = {
		{label = '500$ - 50 Weed',   value = 'weed'},
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'jeweler_actions', {
        title    = 'Hast du gutes Ott für mich?',
        align    = 'top-left',
        elements = elements
    }, function(data, menu)
        if data.current.value == 'weed' then
            menu.close()
            TriggerServerEvent("dnz_haze_arbeiter:weedsell")
        end
    end)
end

function Animation()
    Citizen.CreateThread(function()
        while impacts < 5 do
            Citizen.Wait(1)
		local ped = PlayerPedId()	
                RequestAnimDict("anim@move_m@trash")
                Citizen.Wait(100)
                TaskPlayAnim((ped), 'anim@move_m@trash', 'pickup', 8.0, 8.0, -1, 80, 0, 0, 0, 0)
                SetEntityHeading(ped, 270.0)
                Citizen.Wait(2500)
                ClearPedTasks(ped)
                impacts = impacts+1
                if impacts == 5 then
                    DetachEntity(pickaxe, 1, true)
                    DeleteEntity(pickaxe)
                    DeleteObject(pickaxe)
                    mineActive = false
                    impacts = 0
                    TriggerServerEvent("xi_codein:givestone")
                    break
                end        
        end
    end)
end