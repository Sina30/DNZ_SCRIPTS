local display = false


TriggerServerEvent("bruabfrage")
local claimed = 0
local rechnen = 0
RegisterNetEvent("bru:Return")
AddEventHandler("bru:Return", function(_claimed, _daytoday)
    claimed = _claimed
    rechnen = _daytoday

    SendNUIMessage({
        type = "checkadvent",
        claimed = _claimed,
        daytoday = _daytoday,
    })
    print(_claimed, _daytoday)
end)

AddEventHandler("playerSpawned", function()
  TriggerServerEvent('bruabfrage')
  TriggerServerEvent('bru:Return')
end)



RegisterCommand("advent", function(source, args)
        SetDisplay(not display)
end)

--very important cb 
RegisterNUICallback("exit", function(data)
    SetDisplay(false)
end)

-- this cb is used as the main route to transfer data back 
-- and also where we hanld the data sent from js
RegisterNUICallback("main", function(data)
    chat(data.text, {0,255,0})
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
        -- https://runtime.fivem.net/doc/natives/#_0xFE99B66D079CF6BC
        --[[ 
            inputGroup -- integer , 
	        control --integer , 
            disable -- boolean 
        ]]
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



RegisterNUICallback("i1", function(data)
    SetDisplay(false)
    TriggerServerEvent("dnz_advent:validateclaim")
end)

RegisterNUICallback("i2", function(data)
    SetDisplay(false)
    TriggerServerEvent("dnz_advent:validateclaim")
end)

RegisterNUICallback("i3", function(data)
    SetDisplay(false)
    TriggerServerEvent("dnz_advent:validateclaim")
end)

RegisterNUICallback("i4", function(data)
    SetDisplay(false)
    TriggerServerEvent("dnz_advent:validateclaim")
end)

RegisterNUICallback("i5", function(data)
    SetDisplay(false)
    TriggerServerEvent("dnz_advent:validateclaim")
end)

RegisterNUICallback("i6", function(data)
    SetDisplay(false)
    TriggerServerEvent("dnz_advent:validateclaim")
end)

RegisterNUICallback("i7", function(data)
    SetDisplay(false)
    TriggerServerEvent("dnz_advent:validateclaim")
end)

RegisterNUICallback("i8", function(data)
    SetDisplay(false)
    TriggerServerEvent("dnz_advent:validateclaim")
end)

RegisterNUICallback("i9", function(data)
    SetDisplay(false)
    TriggerServerEvent("dnz_advent:validateclaim")
end)

RegisterNUICallback("i10", function(data)
    SetDisplay(false)
    TriggerServerEvent("dnz_advent:validateclaim")
end)

RegisterNUICallback("i11", function(data)
    SetDisplay(false)
    TriggerServerEvent("dnz_advent:validateclaim")
end)

RegisterNUICallback("i12", function(data)
    SetDisplay(false)
    TriggerServerEvent("dnz_advent:validateclaim")
end)

RegisterNUICallback("i13", function(data)
    SetDisplay(false)
    TriggerServerEvent("dnz_advent:validateclaim")
end)

RegisterNUICallback("i14", function(data)
    SetDisplay(false)
    TriggerServerEvent("dnz_advent:validateclaim")
end)

RegisterNUICallback("i15", function(data)
    SetDisplay(false)
    TriggerServerEvent("dnz_advent:validateclaim")
end)

RegisterNUICallback("i16", function(data)
    SetDisplay(false)
    TriggerServerEvent("dnz_advent:validateclaim")
end)

RegisterNUICallback("i17", function(data)
    SetDisplay(false)
    TriggerServerEvent("dnz_advent:validateclaim")
end)

RegisterNUICallback("i18", function(data)
    SetDisplay(false)
    TriggerServerEvent("dnz_advent:validateclaim")
end)

RegisterNUICallback("i19", function(data)
    SetDisplay(false)
    TriggerServerEvent("dnz_advent:validateclaim")
end)

RegisterNUICallback("i20", function(data)
    SetDisplay(false)
    TriggerServerEvent("dnz_advent:validateclaim")
end)

RegisterNUICallback("i21", function(data)
    SetDisplay(false)
    TriggerServerEvent("dnz_advent:validateclaim")
end)

RegisterNUICallback("i22", function(data)
    SetDisplay(false)
    TriggerServerEvent("dnz_advent:validateclaim")
end)

RegisterNUICallback("i23", function(data)
    SetDisplay(false)
    TriggerServerEvent("dnz_advent:validateclaim")
end)

RegisterNUICallback("i24", function(data)
    SetDisplay(false)
    TriggerServerEvent("dnz_advent:validateclaim")
end)

