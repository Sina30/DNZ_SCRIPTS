local dnz_loginsystem = true
ESX                           = nil

Citizen.CreateThread(function ()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
  end
end)

local serverip --[[ string ]] = GetCurrentServerEndpoint()

TriggerServerEvent("loginabfragen")


local registriert = 0

RegisterNetEvent("dnz_loginsystem:antwort")
AddEventHandler("dnz_loginsystem:antwort", function(_registriert)
	registriert = _registriert
end)


AddEventHandler("playerSpawned", function()
	  TriggerServerEvent('dnz_loginsystem:antwort')
	  EnableGuiLogin(true)
end)

function EnableGuiLogin( StatusGui )
	dnz_loginsystem = StatusGui
	SetNuiFocus(StatusGui, StatusGui)
	DisplayRadar(false) 
    SendNUIMessage({
        type = "EnableGuiLogin",
        StatusJs = StatusGui
	})
end

AddEventHandler('onClientResourceStart', function (resourceName)
	if(GetCurrentResourceName() ~= resourceName) then
	  return
	end
	StartPlayerSwitch(PlayerPedId(), PlayerPedId(), 1050, 1)
end)

RegisterNetEvent('dnz_loginsystem:wronglogin')
AddEventHandler('dnz_loginsystem:wronglogin', function( ErrorMessage )
	if ErrorMessage == "InvalidLogin" then
		SendNUIMessage({
			type = "errorcode",
			errortyp = "1"
		})
	elseif ErrorMessage == "nichts" then
		SendNUIMessage({
			type = "errortyp",
			errortyp = 2
		})
	elseif ErrorMessage == "gebannt" then
		SendNUIMessage({
			type = "errorcode",
			errortyp = 7
		})
	elseif ErrorMessage == "invalidaccount" then
		SendNUIMessage({
			type = "errorcode",
			errortyp = 6
		})
	end

end)



AddEventHandler('dnz_loginsystem:rightlogin', function( ValidMessage )
	
	local text =  ValidMessage	
	DisplayNotification(text)	
	EnableGuiLogin(false) 
	DisplayRadar(true)
	StopPlayerSwitch()
end)
RegisterNetEvent('dnz_loginsystem:rightlogin') 


RegisterNUICallback('dnz_loginsystem:LoginServer', function(data)
	print(source)
	local username = data.username
	local password = data.password

	TriggerServerEvent('dnz_loginsystem:validatelogin', username, password) 
end)


-- Call error login
RegisterNUICallback('dnz_loginsystem:LoginErrorServer', function()
	local text = '<b>~r~Fehler: ~w~</b> Es hat keinen Sinn nichts einzugeben!'	
	DisplayNotification(text)		
end)


-- Init Player
Citizen.CreateThread(function()
    while true do
        if dnz_loginsystem then
			EnableGuiLogin(true) -- required to lunch Nui		
		end		
        Citizen.Wait(0)
    end
end)


-- 
function DisplayNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(true, false)
end



TriggerServerEvent("registerabfrage")

local registriert = 0

RegisterNetEvent("dnz_loginsystem:regantwort")
AddEventHandler("dnz_loginsystem:regantwort", function(_registriert)
	registriert = _registriert
	if registriert > 0 then
		SendNUIMessage({
			type = "errorcode",
			errortyp = "4"
		})
	else
		SendNUIMessage({
			type = "errorcode",
			errortyp = "5"
		})
	end
end)


RegisterNetEvent('dnz_loginsystem:wrongreg') 
AddEventHandler('dnz_loginsystem:wrongreg', function( ErrorMessage )
	if ErrorMessage == "vergeben" then
		SendNUIMessage({
			type = "errorcode",
			errortyp = "3"
		})
	end
end)



RegisterNetEvent('dnz_loginsystem:rightreg') 
AddEventHandler('dnz_loginsystem:rightreg', function( ValidMessage )
	
	local text = '<b>~g~Willkommen ~w~</b> ' .. ValidMessage	
	DisplayNotification(text)	
	EnableGuiLogin(false) 
	DisplayRadar(true)
	StopPlayerSwitch()
end)

RegisterNUICallback('dnz_loginsystem:register', function(data)
	local username = data.username
	local password = data.password
	TriggerServerEvent('dnz_loginsystem:registerbro', username, password)
	
end)

AddEventHandler('onClientResourceStart', function (resourceName)
	if(GetCurrentResourceName() ~= resourceName) then
	  return
	end
	StartPlayerSwitch(PlayerPedId(), PlayerPedId(), 1050, 1)
end)

