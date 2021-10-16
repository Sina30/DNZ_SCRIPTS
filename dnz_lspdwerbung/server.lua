ESX               = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



RegisterServerEvent('dnz_lspdwerbung:sendtoall')
AddEventHandler('dnz_lspdwerbung:sendtoall', function(datatext)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.name
    local grade = xPlayer.job.grade
    if xPlayer ~= nil then
        if xPlayer.job.name == 'police' then
            if xPlayer.job.grade_label == 'Boss' then
                print("^0[^3dnz^0] ^5LSPD - Marketing: ^0", datatext)
                TriggerClientEvent('chat:addMessage', -1, { args = {"^5[LSPD Werbung] ^0", datatext }, color = { 128, 128, 128 } })
                TriggerClientEvent('esx:showNotification', source, '~b~[LSPD Marketing]~w~ Wir haben ihren Auftrag aufgegeben!')
                TriggerClientEvent("LSPDWerbungALL", -1, "~b~[LSPD] Werbung: ~w~" .. datatext)
            else
            end
        else
            -- Kein Cop, sollte eigentlich ein Modder sein wenn das hier getrigger wird.
            -- Evtl. Discord Webhook hier reinhauen!
        end
    end
end)