local boost = false

RegisterNetEvent('dnz_bst:boost')
AddEventHandler('dnz_bst:boost', function()
	local ped = PlayerPedId()
	SetEntityMaxHealth(ped, 400)
	boost = true
	SetEntityHealth(ped, 300)
end)




Citizen.CreateThread(function()
	while true do	
        Citizen.Wait(0)
		local ped1 = GetPlayerPed(-1)
		local highdamagerifles = 15
		local lowdamagepistols = 15
		if boost == true then
			CurrentWeather = 'OVERCAST'
			SetWeatherTypeOverTime(CurrentWeather, 15.0)
			if GetSelectedPedWeapon(ped1) == GetHashKey("WEAPON_SNSPISTOL") then
								
					SetPlayerWeaponDamageModifier(ped1, 3)
					
				elseif GetSelectedPedWeapon(ped1) == GetHashKey("WEAPON_ADVANCEDRIFLE") then
					SetPlayerWeaponDamageModifier(ped1, 3)
				
				end
			end
	end
end)