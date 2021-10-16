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
    chat("^1LifeInvader: ^0Du weißt ja jetzt wo du uns findest.", {0,255,0})
    SetDisplay(false)
end)

RegisterNUICallback("main", function(data)
    print(data.text, " sende")
    TriggerServerEvent("dnz_invader:sendtoall", data.text)
    SetDisplay(false)
end)

RegisterNUICallback("error", function(data)
    chat(data.error, {255,0,0})
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
            if GetDistanceBetweenCoords(GetEntityCoords(ped), -1082.35, -247.68, 37.76, true) < 2 then-- PED Position
                ESX.ShowHelpNotification("~r~[LifeInvader]\n~w~Drücke ~INPUT_CONTEXT~ um eine Werbung zu schalten")
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
        local npc = CreatePed(6, hash, -1083.18, -245.69, 36.76, 209.0, false, false) -- PED Position
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



-- -1083.18, -245.69, 37.76