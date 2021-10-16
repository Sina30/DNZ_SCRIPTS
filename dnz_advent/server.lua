-- Register Events Server

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('dnz_advent:validateclaim')
AddEventHandler('dnz_advent:validateclaim', function()	
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.name
    local grade = xPlayer.job.grade
    local identifier = GetPlayerIdentifiers(_source)[1]
    local daytoday = os.date("%d")
    MySQL.Sync.execute("UPDATE users SET advent=@today WHERE identifier=@identifier", {['@identifier'] = identifier, ['@today'] = daytoday})
    MySQL.Async.fetchAll('SELECT advent FROM users WHERE identifier = @identifier', {['@identifier'] = identifier}, function(result)
        _claimed = result[1].advent
        _daytoday = daytoday
    TriggerClientEvent("bru:Return", _source, _claimed, _daytoday)
    end)
    if daytoday == "01" then 
        xPlayer.addInventoryItem("bread",1)
    elseif daytoday == "02" then
        xPlayer.addInventoryItem("bread",2)
    elseif daytoday == "03" then
        xPlayer.addInventoryItem("bread",3)
    elseif daytoday == "04" then
        xPlayer.addInventoryItem("bread",4)
    elseif daytoday == "05" then
        xPlayer.addInventoryItem("bread",5)
    elseif daytoday == "06" then
        xPlayer.addInventoryItem("bread",6)
    elseif daytoday == "07" then
        xPlayer.addInventoryItem("bread",7)
    elseif daytoday == "08" then
        xPlayer.addInventoryItem("bread",8)
    elseif daytoday == "09" then
        xPlayer.addInventoryItem("bread",9)
    elseif daytoday == "10" then
        xPlayer.addInventoryItem("bread",10)
    elseif daytoday == "11" then
        xPlayer.addInventoryItem("bread",11)
    elseif daytoday == "12" then
        xPlayer.addInventoryItem("bread",12)
    elseif daytoday == "13" then
        xPlayer.addInventoryItem("bread",13)
    elseif daytoday == "14" then
        xPlayer.addInventoryItem("bread",14)
    elseif daytoday == "15" then
        xPlayer.addInventoryItem("bread",15)
    elseif daytoday == "16" then
        xPlayer.addInventoryItem("bread",16)
    elseif daytoday == "17" then
        xPlayer.addInventoryItem("bread",17)
    elseif daytoday == "18" then
        xPlayer.addInventoryItem("bread",18)
    elseif daytoday == "19" then
        xPlayer.addInventoryItem("bread",19)
    elseif daytoday == "20" then
        xPlayer.addInventoryItem("bread",20)
    elseif daytoday == "21" then
        xPlayer.addInventoryItem("bread",21)
    elseif daytoday == "22" then
        xPlayer.addInventoryItem("bread",22)
    elseif daytoday == "23" then
        xPlayer.addInventoryItem("bread",23)
    elseif daytoday == "24" then
        xPlayer.addInventoryItem("bread",24)
    end
end)

RegisterServerEvent('bruabfrage')
AddEventHandler('bruabfrage', function()
    local _source = source
	local identifier = GetPlayerIdentifiers(_source)[1]
    local daytoday = os.date("%d")
    MySQL.ready(function ()
		MySQL.Async.fetchAll('SELECT advent FROM users WHERE identifier = @identifier', {['@identifier'] = identifier}, function(result)
            _claimed = result[1].advent
            _daytoday = daytoday
		TriggerClientEvent("bru:Return", _source, _claimed, _daytoday)
		end)
    end)
end)