ESX               = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



RegisterServerEvent('dnz_lsmdwerbung:sendtoall')
AddEventHandler('dnz_lsmdwerbung:sendtoall', function(datatext)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.name
    local grade = xPlayer.job.grade_label
    if xPlayer ~= nil then
        if xPlayer.job.name == 'ambulance' then
            if grade == 'Boss' then
                print("^0[^3dnz^0] ^1LSMD - Marketing: ^0", datatext)
                TriggerClientEvent('chat:addMessage', -1, { args = {"^1[LSMD Werbung] ^0", datatext }, color = { 128, 128, 128 } })
                TriggerClientEvent('esx:showNotification', source, '~r~[LSMD Marketing]~w~ Wir haben ihren Auftrag aufgegeben!')
                TriggerClientEvent("LSMDWerbungALL", -1, "~r~[LSMD] Werbung: ~w~" .. datatext)
            else
            end
        else
            -- Kein Cop, sollte eigentlich ein Modder sein wenn das hier getrigger wird.
            -- Evtl. Discord Webhook hier reinhauen!
        end
    end
end)