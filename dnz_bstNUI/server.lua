ESX               = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



RegisterServerEvent('dnz_boost:getem')
AddEventHandler('dnz_boost:getem', function()
            local _source = source
            local xPlayer  = ESX.GetPlayerFromId(_source)
            if xPlayer ~= nil then
                -- soll nur eine spritze pro neustart geholt werden können?
                --(Füge das unter addinventoryitem hinzu) neustart =  1
                -- füge das unter ESX=nil ein, -->>>>   local neustart = 0
                -- if neustart > 0 then
                --  xPlayer.addInventoryItem("bstspritze", 1)
                -- else
                -- zeige dem spieler, das er bis neustart nichtmehr nichtmehr kann(chat, esx.shownotifcation)
                -- end
                print("triggered")
                xPlayer.addInventoryItem("bstspritze", 1)
            end
end)


