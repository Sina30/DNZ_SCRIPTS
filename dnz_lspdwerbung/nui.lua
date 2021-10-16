local PlayerData                = {}
ESX                             = nil
local display = false
local firstspawn = false

Citizen.CreateThread(function()
    while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(0)
    end
end)  

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)


RequestIpl("facelobby")

RegisterNUICallback("exit", function(data)
    chat("^5LSPD - Marketing: ^0Du weißt ja jetzt wo du uns findest.", {0,255,0})
    SetDisplay(false)
end)

RegisterNUICallback("main", function(data)
    TriggerServerEvent("dnz_lspdwerbung:sendtoall", data.text)
    SetDisplay(false)
end)

RegisterNUICallback("error", function(data)
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


RegisterNetEvent('LSPDWerbungALL')
AddEventHandler('LSPDWerbungALL',function(message)
    function notifyAll(msg)
        SetNotificationTextEntry("STRING")

        AddTextComponentString(msg)

        DrawNotification(0, 0, 0, -1) 
    end
    notifyAll(message)   
end)

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

function chat(str, color)
    TriggerEvent(
        'chat:addMessage',
        {
            color = color,
            multiline = true,
            args = {str}
        }
    )
end



Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        Citizen.Wait(1)
            if GetDistanceBetweenCoords(GetEntityCoords(ped),  Config.StandX ,Config.StandY ,Config.StandZ, true) < 2 and ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then-- PED Position
                ESX.ShowHelpNotification("~b~[LSPD - Marketing]\n~w~Drücke ~INPUT_CONTEXT~ um eine Werbung zu schalten")
                    if IsControlJustReleased(1, 51) then
                        SetDisplay(not display)
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
        local npc = CreatePed(6, hash,  Config.StandX ,Config.StandY ,Config.StandZ-1, 47.0, false, false) -- PED Position
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
