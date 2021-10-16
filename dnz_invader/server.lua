ESX               = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



RegisterServerEvent('dnz_invader:sendtoall')
AddEventHandler('dnz_invader:sendtoall', function(datatext)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local account = xPlayer.getMoney()
    local werbungspreis = 500
    if xPlayer ~= nil then
        if account > werbungspreis then
            xPlayer.removeMoney(werbungspreis)
            print("^0[^3dnz^0] ^1LifeInvader: ^0", datatext)
            TriggerClientEvent('chat:addMessage', -1, { args = {"^1[LifeInvader] ^0", datatext }, color = { 128, 128, 128 } })
            TriggerClientEvent('esx:showNotification', source, '~r~[LifeInvader]~w~ Vielen Dank, du hast ~g~$' .. werbungspreis .. '~w~ bezahlt.')
        else
            TriggerClientEvent('esx:showNotification', source, 'Du benötigst dafür ~g~$' .. werbungspreis .. '~w~.')
        end
    end
end)