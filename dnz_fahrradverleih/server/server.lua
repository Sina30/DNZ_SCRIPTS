ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('esx:playerLoaded', function(source)
  local xPlayer = ESX.GetPlayerFromId(source) 
end)

RegisterServerEvent('dnz_fahrradshop:genuggeld')
AddEventHandler('dnz_fahrradshop:genuggeld', function()
 	local _source = source
 	local xPlayer = ESX.GetPlayerFromId(source)
    local _meingeld = xPlayer.getMoney()

     if xPlayer ~= nil then 
        TriggerClientEvent('dnz_fahrradshop:antwort', _source, _meingeld)
     end
 end)

 
RegisterServerEvent('dnz_fahrradshop:bezahlen')
AddEventHandler('dnz_fahrradshop:bezahlen', function(wieviel)
 	local _source = source
 	local xPlayer = ESX.GetPlayerFromId(source)
    local _meingeld = xPlayer.getMoney()

        if xPlayer ~= nil then 
            xPlayer.removeMoney(wieviel)
        end
 end)