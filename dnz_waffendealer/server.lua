ESX               = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



RegisterServerEvent('dnz_waffendealer:abfrage')
AddEventHandler('dnz_waffendealer:abfrage', function()
            local _source = source
            local xPlayer  = ESX.GetPlayerFromId(_source)
            local _pistolenteil = xPlayer.getInventoryItem('pistolenteil').count
            local _heavypistolenteil = xPlayer.getInventoryItem('heavypistolenteil').count
            local _revolverteil = xPlayer.getInventoryItem('revolverteil').count
            if xPlayer ~= nil then
                TriggerClientEvent('dnz_waffendealer:antwort', source, _pistolenteil, _heavypistolenteil, _revolverteil )
            end
end)



RegisterServerEvent('dnz_waffendealer:pistole')
AddEventHandler('dnz_waffendealer:pistole', function()
            local _source = source
            local xPlayer  = ESX.GetPlayerFromId(_source)
            local _pistolenteil = xPlayer.getInventoryItem('pistolenteil').count
            local _heavypistolenteil = xPlayer.getInventoryItem('heavypistolenteil').count
            local _revolverteil = xPlayer.getInventoryItem('revolverteil').count
            
            if xPlayer ~= nil then
                if _pistolenteil > 49 then
                    xPlayer.removeInventoryItem('pistolenteil', 50)
                    xPlayer.addWeapon('weapon_pistol', 250)
                else
                    --ACHTUNG MODDER
                end
            end
end)


RegisterServerEvent('dnz_waffendealer:heavypistole')
AddEventHandler('dnz_waffendealer:heavypistole', function()
            local _source = source
            local xPlayer  = ESX.GetPlayerFromId(_source)
            local _pistolenteil = xPlayer.getInventoryItem('pistolenteil').count
            local _heavypistolenteil = xPlayer.getInventoryItem('heavypistolenteil').count
            local _revolverteil = xPlayer.getInventoryItem('revolverteil').count
            
            if xPlayer ~= nil then
                if _heavypistolenteil > 49 then
                    xPlayer.removeInventoryItem('heavypistolenteil', 100)
                    xPlayer.addWeapon('weapon_heavypistol', 250)
                else
                    --ACHTUNG MODDER
                end
            end
end)



RegisterServerEvent('dnz_waffendealer:revolver')
AddEventHandler('dnz_waffendealer:revolver', function()
            local _source = source
            local xPlayer  = ESX.GetPlayerFromId(_source)
            local _pistolenteil = xPlayer.getInventoryItem('pistolenteil').count
            local _heavypistolenteil = xPlayer.getInventoryItem('heavypistolenteil').count
            local _revolverteil = xPlayer.getInventoryItem('revolverteil').count
            
            print(_pistolenteil)
            if xPlayer ~= nil then
                if _revolverteil > 49 then
                    xPlayer.removeInventoryItem('revolverteil', 150)
                    xPlayer.addWeapon('weapon_revolver', 250)
                else
                    --ACHTUNG MODDER
                end
            end
end)



local wieoft = 1


RegisterNetEvent("dnz_waffendealer:dnzstart")
AddEventHandler("dnz_waffendealer:dnzstart", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
	local name = GetPlayerName(source)
        if xPlayer ~= nil then
            if xPlayer.job.name == 'waffendealer' then
                if xPlayer.getInventoryItem('waffenmaterialien').count < Config.MaxWaffenMats then
                    xPlayer.addInventoryItem('waffenmaterialien', Config.MatsPerPickup)
                    TriggerClientEvent('esx:showNotification', source, 'Du hast ' .. Config.MatsPerPickup ..' ~b~Materialien erhalten.')
                    if Config.Webhook == true then
                    joblog('Job Log','Der Spieler ' .. name .. '  hat gerade ' .. Config.MatsPerPickup .. ' Materialien erhalten',16711680)
                    end
                end
            else
                TriggerClientEvent('esx:showNotification', source, 'Das können nur Waffendealer.')
            end

        end
    end)

    
RegisterNetEvent("dnz_waffendealer:dnzweiter")
AddEventHandler("dnz_waffendealer:dnzweiter", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
	local name = GetPlayerName(source)
        if xPlayer ~= nil then
            if xPlayer.job.name == 'waffendealer' then
                if xPlayer.getInventoryItem('waffenmaterialien').count > Config.MaterialzuTeilen - 1 then
                    TriggerClientEvent("dnz_waffendealer:dnzweiter", source)
                    Citizen.Wait(15900)
                    xPlayer.addInventoryItem('waffenteile', Config.WaffenteileErhalt)
                    xPlayer.removeInventoryItem("waffenmaterialien", Config.MaterialzuTeilen)
                    if Config.Webhook == true then
                    joblog('Job Log','Der Spieler ' .. name .. '  machte ' .. Config.MaterialzuTeilen .. ' Waffenmaterial zu ' .. Config.WaffenteileErhalt ..' Waffenteil',16711680)
                    end
                else
                    TriggerClientEvent('esx:showNotification', source, 'Du hast nicht genug ~b~Materialien.')
                end
            else
                TriggerClientEvent('esx:showNotification', source, 'Das können nur Waffendealer.')
            end
        end
    end)

RegisterNetEvent("dnz_waffendealer:dnzende")
AddEventHandler("dnz_waffendealer:dnzende", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    local randomChance = math.random(1, 100)
	local name = GetPlayerName(source)
        if xPlayer ~= nil then
            if xPlayer.job.name == 'waffendealer' then
                if xPlayer.getInventoryItem('waffenteile').count > 0 then
                    TriggerClientEvent("dnz_waffendealer:dnzende", source)
                    Citizen.Wait(15900)
                    if randomChance < 10 then
                        xPlayer.addInventoryItem("revolverteil", 1)
                        xPlayer.removeInventoryItem("waffenteile", 1)
                        TriggerClientEvent('esx:showNotification', _source, 'Du bekommst ~b~1 Revolver Teil ~w~für eines deiner Waffenteile.')
                        if Config.Webhook == true then
                        joblog('Job Log','Der Spieler ' .. name .. ' hat 1 Revolverteil für 1 Waffenteil bekommen',16711680)
                        end
                    elseif randomChance > 9 and randomChance < 45 then
                        xPlayer.addInventoryItem("heavypistolenteil", 1)
                        xPlayer.removeInventoryItem("waffenteile", 1)
                        TriggerClientEvent('esx:showNotification', _source, 'Du bekommst ~b~1 Heavy Pistolen Teil ~w~für eines deiner Waffenteile.')
                        if Config.Webhook == true then
                        joblog('Job Log','Der Spieler ' .. name .. '  hat 1 Heavy Pistolen Teil für 1 Waffenteil bekommen',16711680)
                        end
                    elseif randomChance > 44 and randomChance < 80 then
                        xPlayer.addInventoryItem("pistolenteil", 1)
                        xPlayer.removeInventoryItem("waffenteile", 1)
                        TriggerClientEvent('esx:showNotification', _source, 'Du bekommst ~b~1 Pistolen Teil ~w~für eines deiner Waffenteile.')
                        if Config.Webhook == true then
                        joblog('Job Log','Der Spieler ' .. name .. '  hat 1 Pistolenteil für 1 Waffenteil bekommen',16711680)
                        end
                    elseif randomChance > 79 then
                        TriggerClientEvent('esx:showNotification', _source, 'Fehler bei der Herstellung. Dein Teil wurde zerstört.')
                        xPlayer.removeInventoryItem("waffenteile", 1)
                    end
                elseif xPlayer.getInventoryItem('waffenteile').count < 1 then
                    TriggerClientEvent('esx:showNotification', source, 'Du hast nicht genug ~b~Waffen Teile.')
                end
            else
                TriggerClientEvent('esx:showNotification', source, 'Das können nur Waffendealer.')
            end
        end
    end)


	
	
function joblog (name,message,color)
    local DiscordWebHook = Config.JoblogWebhook
    local servername = Config.ServerName
  local embeds = {
	  {
		  ["title"]=message,
		  ["type"]="rich",
		  ["color"] =color,
		  ["footer"]=  {
			  ["text"]= servername,
		 },
	  }
  }
  
	if message == nil or message == '' then return FALSE end
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end