ESX               = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("dnz_script:aufheben")
AddEventHandler("dnz_script:aufheben", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            if Config.Scherebenotigt then
                if xPlayer.getInventoryItem('schere').count > 0 then
                        if xPlayer.getInventoryItem('weed').count < Config.Limit then
                            xPlayer.addInventoryItem('weed', Config.AnzahlPerSammeln)
                            TriggerClientEvent('esx:showNotification', source, Config.Weederhalten)
                            else
                            TriggerClientEvent('esx:showNotification', source, Config.ZuVielWeed)
                        end
                    else
                        xPlayer.addInventoryItem('weed', 1)
                        TriggerClientEvent('esx:showNotification', source, Config.KeineSchere)
                    end
            else
                if xPlayer.getInventoryItem('weed').count < Config.Limit then
                    xPlayer.addInventoryItem('weed', Config.AnzahlPerSammeln)
                    TriggerClientEvent('esx:showNotification', source, Config.Weederhalten)
                    else
                    TriggerClientEvent('esx:showNotification', source, Config.ZuVielWeed)
                end
            end
        end
    end)