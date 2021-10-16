ESX               = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



RegisterServerEvent('dnz_haze_arbeiter:abfrage')
AddEventHandler('dnz_haze_arbeiter:abfrage', function()
            local _source = source
            local xPlayer  = ESX.GetPlayerFromId(_source)
            local _meinebaggies = xPlayer.getInventoryItem('baggies').count
            local _meinweed = xPlayer.getInventoryItem('weed').count
            if xPlayer ~= nil then
                TriggerClientEvent('dnz_haze_arbeiter:antwort', source, _meinebaggies, _meinweed)
            end
end)







RegisterServerEvent('dnz_haze_arbeiter:go')
AddEventHandler('dnz_haze_arbeiter:go', function()
    local _source = source
    local verarbeiten = 0
    local xPlayer  = ESX.GetPlayerFromId(_source)
            if xPlayer.getInventoryItem('baggies').count > 0 then 
                if xPlayer.getInventoryItem('weed').count > 2 then
                        xPlayer.removeInventoryItem('baggies', 1)
						xPlayer.removeInventoryItem('weed', 3)
                        Citizen.Wait(30000)
                        xPlayer.addInventoryItem('weedbag', 1)
                elseif xPlayer.getInventoryItem('weed').count < 1 then
                    TriggerClientEvent('esx:showNotification', source, 'Du hast nicht genug ~b~Weed.')
                end
            else
                TriggerClientEvent('esx:showNotification', source, 'Du hast keine Baggies.')
            end
    end)



    RegisterNetEvent("dnz_haze_arbeiter:weedsell")
AddEventHandler("dnz_haze_arbeiter:weedsell", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
		local name = GetPlayerName(source)
        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('weedbag').count > 4 then
                local weedprice = 500
                xPlayer.removeInventoryItem('weedbag', 50)
                xPlayer.addAccountMoney('black_money', weedprice)
                TriggerClientEvent('esx:showNotification', source, 'Du hast 5 Päckchen verkauft')
            elseif xPlayer.getInventoryItem('weedbag').count < 5 then
                TriggerClientEvent('esx:showNotification', source, 'Du hast kein Weed, willst du mich veraschen?')
            end
        end
    end)