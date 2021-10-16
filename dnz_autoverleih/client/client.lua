local display = false
local spielermoney = 0
local firstspawn = false
local isinrent = 0
ESX                           = nil
local locked = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


RegisterNUICallback("exit", function(data)
    SetDisplay(false)
end)

RegisterNetEvent('dnz_autoverleih:antwort')
AddEventHandler('dnz_autoverleih:antwort', function(_meingeld)
    spielermoney = _meingeld
end)


RegisterNetEvent('dnz_autoverleih:antwortrent')
AddEventHandler('dnz_autoverleih:antwortrent', function(_2016rs7, _baller6, _gt63samg, _blista, _brioso,_sultan,_seven70)
    rs7rent = _2016rs7
    baller6 = _baller6
    gt63samg =  _gt63samg
    blista = _blista
    brioso = _brioso
    sultan = _sultan
    seven70 = _seven70
end)

RegisterNUICallback("main", function(data)
    TriggerServerEvent("dnz_autoverleih:genuggeld")
    TriggerServerEvent("dnz_autoverleih:antwortrentabfragen")
    local playerPed = GetPlayerPed(-1)
    local rechnung = data.bezahlen
    local bike = data.fahrrad
    local renttime = data.bezahlen/1250    
    
    if spielermoney >= data.bezahlen  then
        if bike == "2016rs7" and rs7rent == true then
            ShowAboveRadarMessage("~r~[Mietwagen GmbH] ~w~ Der RS7 ist zurzeit auf den Straßen unterwegs.")
        elseif bike == "BALLER6" and baller6 == true then
            ShowAboveRadarMessage("~r~[Mietwagen GmbH] ~w~ Der Baller ist zurzeit auf den Straßen unterwegs.")
        elseif bike == "gt63samg" and gt63samg == true then
            ShowAboveRadarMessage("~r~[Mietwagen GmbH] ~w~ Der AMG GT 63 ist zurzeit auf den Straßen unterwegs.")
        elseif bike == "BLISTA" and blista == true then
            ShowAboveRadarMessage("~r~[Mietwagen GmbH] ~w~ Der Blista ist zurzeit auf den Straßen unterwegs.")
        elseif bike == "BRIOSO" and brioso == true then
            ShowAboveRadarMessage("~r~[Mietwagen GmbH] ~w~ Der Brioso ist zurzeit auf den Straßen unterwegs.")
        elseif bike == "SULTAN" and sultan == true then
            ShowAboveRadarMessage("~r~[Mietwagen GmbH] ~w~ Der Sultan ist zurzeit auf den Straßen unterwegs.")
        elseif bike == "SEVEN70" and seven70 == true then
            ShowAboveRadarMessage("~r~[Mietwagen GmbH] ~w~ Der Seven70 ist zurzeit auf den Straßen unterwegs.")
        else
            if isinrent < 1 then 
                SetEntityHeading(playerPed, Config.SpawnHeading)
                SetEntityCoords(playerPed, Config.SpawnAutoX, Config.SpawnAutoY, Config.SpawnAutoZ, false, false, false, true)
                TriggerServerEvent("dnz_autoverleih:bezahlen", data.bezahlen)
                print(data.bezahlen)
                TriggerEvent('esx:spawnVehicle', bike)
                isinrent = isinrent + 1
                TriggerServerEvent("dnz_autoverleih:rented", bike, true)
                SetDisplay(false)
                Citizen.Wait(500)
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                SetVehicleNumberPlateText(vehicle, Config.FahrzeugKennzeichen)
                ShowAboveRadarMessage("Du hast dir ein ~g~" .. string.upper(bike) .. "~w~ für ~g~" .. renttime .. "~w~ minuten ausgeliehen. Rechnung: ~g~$" .. rechnung)
                Citizen.Wait(renttime*50000) --renttime
                DisplayHelpText("Dein Mietvertrag für dein " .. string.upper(bike) .. " läuft ~r~bald~w~ aus!")
                Citizen.Wait(renttime*10000) --renttime
                DisplayHelpText("Dein Mietvertrag für dein " .. string.upper(bike) .. " läuft in ~r~1 Minute~w~ aus!")
                Citizen.Wait(60000)
                SetEntityAsMissionEntity(vehicle, true, true)
                DeleteVehicle(vehicle)
                DisplayHelpText("Dein Mietvertrag für dein " .. string.upper(bike) .. " ist ~r~ausgelaufen~w~!")
                TriggerServerEvent("dnz_autoverleih:rented", bike, false)
                isinrent = isinrent - 1
            else
                ShowAboveRadarMessage("Wir vermieten maximal 1 Fahrzeug ~r~pro Person")
                SetDisplay(false)
            end      
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
                        TriggerServerEvent("dnz_autoverleih:antwortrentabfragen")
                        TriggerServerEvent("dnz_autoverleih:genuggeld")
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

	SetBlipSprite (blip, 326)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 1.0)
	SetBlipAsShortRange(blip, true)
    SetBlipColour(blip ,0)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(blipname)
	EndTextCommandSetBlipName(blip)
end)




Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        if isinrent >= 1 then
            local ped = GetPlayerPed(-1)
            local vehicleped = GetLastDrivenVehicle(ped)
            local platetext = GetVehicleNumberPlateText(vehicleped)
            if IsControlPressed(0,57) then
                if string.match(platetext, Config.FahrzeugKennzeichen) then
                    if locked == true then                   
                        SetVehicleDoorsLocked(vehicleped, 0)
                        locked = false
                        print('unlocked')
                        ShowAboveRadarMessage("Du hast deinen Mietwagen ~g~aufgesperrt~w~")
                    else
                        SetVehicleDoorsLocked(vehicleped, 2)
                        locked = true
                        ShowAboveRadarMessage("Du hast deinen Mietwagen ~r~zugesperrt~w~")
                    end
                else
                end
            end
        end
    end
  end)


  function ShowAboveRadarMessage(message)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(message)
	DrawNotification(0,1)
end
