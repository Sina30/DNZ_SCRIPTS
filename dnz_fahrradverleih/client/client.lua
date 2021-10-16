local display = false
local spielermoney = 0
local firstspawn = false
local isinrent = 0
ESX                           = nil


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNUICallback("exit", function(data)
    SetDisplay(false)
end)

RegisterNetEvent('dnz_fahrradshop:antwort')
AddEventHandler('dnz_fahrradshop:antwort', function(_meingeld)
    spielermoney = _meingeld
end)

RegisterNUICallback("bmx", function(data)
    TriggerServerEvent("dnz_fahrradshop:genuggeld")
    local playerPed = GetPlayerPed(-1)

    if spielermoney > Config.BMX then
        TriggerServerEvent("dnz_fahrradshop:bezahlen", Config.BMX, "bmx")
        TriggerEvent('esx:spawnVehicle', "bmx")
        --TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
        DisplayHelpText("Du hast dir erfolgreich ein Fahrrad gekauft.")
    else
        DisplayHelpText("Dafür hast du ~r~zu wenig~w~ Geld.")
    end
    
end)    

RegisterNUICallback("main", function(data)
    TriggerServerEvent("dnz_fahrradshop:genuggeld")
    local playerPed = GetPlayerPed(-1)
    local rechnung = data.bezahlen
    local bike = data.fahrrad
    local renttime = data.bezahlen/9
    if spielermoney > data.bezahlen  then
        if isinrent < 2 then 
            TriggerServerEvent("dnz_fahrradshop:bezahlen", data.bezahlen)
            TriggerEvent('esx:spawnVehicle', bike)
            isinrent = isinrent + 1
            SetDisplay(false)
            Citizen.Wait(100)
            local vehicle = GetVehiclePedIsIn(playerPed, false)
            print(vehicle)
            ShowAboveRadarMessage("Du hast dir ein ~g~" .. string.upper(bike) .. "~w~ für ~g~" .. renttime .. "~w~ minuten ausgeliehen. Rechnung: ~g~$" .. rechnung)
            Citizen.Wait(renttime*60000) --renttime
            DisplayHelpText("Dein Mietvertrag für dein " .. string.upper(bike) .. " läuft in ~r~1 Minute~w~ aus!")
            Citizen.Wait(60000)
            SetEntityAsMissionEntity(vehicle, true, true)
            DeleteVehicle(vehicle)
            DisplayHelpText("Dein Mietvertrag für dein " .. string.upper(bike) .. " ist ~r~ausgelaufen~w~!")
            isinrent = isinrent - 1
        else
            ShowAboveRadarMessage("Wir vermieten maximal 2 Fahrräder ~r~pro Person")
            SetDisplay(false)
        end

    else
        ShowAboveRadarMessage("Dafür hast du ~r~zu wenig~w~ Geld")
        SetDisplay(false)
    end
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

function DisplayHelpText(str)
	BeginTextCommandDisplayHelp("STRING")
	AddTextComponentScaleform(str)
	EndTextCommandDisplayHelp(0, 0, 1, -1)
end

Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        Citizen.Wait(1)
            if GetDistanceBetweenCoords(GetEntityCoords(ped),  Config.VerleihX, Config.VerleihY , Config.VerleihZ, true) < 2 then
                    if IsControlJustReleased(1, 51) then
                        TriggerServerEvent("dnz_fahrradshop:genuggeld")
                        SetDisplay(not display)                      
                    end
            end
        end
 end)
    

Citizen.CreateThread(function()
    local hash = GetHashKey("u_m_y_baygor")
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        Citizen.Wait(100)
    end
    while not HasModelLoaded(hash) do
        Citizen.Wait(0)
    end
    if firstspawn == false then
        local npc = CreatePed(6, hash, Config.VerleihX, Config.VerleihY , Config.VerleihZ, Config.PedHeading, false, false)
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
      
Citizen.CreateThread(function()
    local blip = AddBlipForCoord(Config.Blip.Blip.Pos)
    local blipname = Config.Blip.Blip.Name

	SetBlipSprite (blip, 493)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 1.0)
	SetBlipAsShortRange(blip, true)
    SetBlipColour(blip ,31 )
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(blipname)
	EndTextCommandSetBlipName(blip)
end)

function ShowAboveRadarMessage(message)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(message)
	DrawNotification(0,1)
end