ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local _2016rs7 = false
local _baller6 = false
local _gt63samg = false
local _blista = false
local _brioso = false
local _sultan = false
local _seven70 = false

AddEventHandler('esx:playerLoaded', function(source)
  local xPlayer = ESX.GetPlayerFromId(source) 
end)

RegisterServerEvent('dnz_autoverleih:genuggeld')
AddEventHandler('dnz_autoverleih:genuggeld', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local _meingeld = xPlayer.getMoney()

     if xPlayer ~= nil then 
        TriggerClientEvent('dnz_autoverleih:antwort', _source, _meingeld)
     end
 end)

 
 RegisterServerEvent('dnz_autoverleih:bezahlen')
 AddEventHandler('dnz_autoverleih:bezahlen', function(wieviel)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
     local _meingeld = xPlayer.getMoney()
         if xPlayer ~= nil then 
             xPlayer.removeMoney(wieviel)
         end
  end)



RegisterServerEvent('dnz_autoverleih:antwortrentabfragen')
AddEventHandler('dnz_autoverleih:antwortrentabfragen', function()
 	local _source = source
 	local xPlayer = ESX.GetPlayerFromId(source)
    local _meingeld = xPlayer.getMoney()
     if xPlayer ~= nil then 
        TriggerClientEvent('dnz_autoverleih:antwortrent', _source, _2016rs7, _baller6, _gt63samg, _blista, _brioso,_sultan,_seven70)
     end
 end)


  

RegisterServerEvent('dnz_autoverleih:rented')
AddEventHandler('dnz_autoverleih:rented', function(auto, status)
    if auto == "2016rs7" then
       _2016rs7 = status
      elseif auto == "BALLER6" then
        _baller6 = status
      elseif auto == "gt63samg" then
        _gt63samg = status
      elseif auto == "BLISTA" then
        _blista = status
      elseif auto == "BRIOSO" then
        _brioso = status
      elseif auto == "SULTAN" then
        _sultan = status
      elseif auto == "SEVEN70" then
        _seven70 = status
    end
end)