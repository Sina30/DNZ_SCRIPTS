ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('bstspritze', function(source)
	TriggerClientEvent('dnz_bst:boost', source)
end)

