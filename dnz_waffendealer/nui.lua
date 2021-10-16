local display = false

local PlayerData                = {}
ESX                             = nil
local firstspawn = false
local blip1 = {}
local blips = false
local blipActive = false
local mineActive = false
local dnzweiterActive = false
local dnzendeActive = false
local impacts = 0
local timer = 0
local locations = {
    { ['x'] = -179.83,  ['y'] = 6154.13,  ['z'] = 31.06},
}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)


RegisterNetEvent('dnz_waffendealer:antwort')
AddEventHandler('dnz_waffendealer:antwort', function( _pistolenteil, _heavypistolenteil, _revolverteil)
    pistolenteil = _pistolenteil
    heavypistolenteil = _heavypistolenteil
    revolverteil = _revolverteil
    SendNUIMessage({
        type = "test",
        pistolenteil = pistolenteil,
        heavypistolenteil = heavypistolenteil,
        revolverteil = revolverteil
    })
end)

RegisterCommand("waffendealer", function(source, args)
    SetDisplay(not display)
end)

RegisterNUICallback("exit", function(data)
    SetDisplay(false)
end)

RegisterNUICallback("main", function(data)
    chat(data.text, {0,255,0})
    SetDisplay(false)
end)

RegisterNUICallback("error", function(data)
    chat(data.error, {255,0,0})
    SetDisplay(false)
end)

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end

Citizen.CreateThread(function()
    while display do
        Citizen.Wait(0)
        DisableControlAction(0, 1, display) -- LookLeftRight
        DisableControlAction(0, 2, display) -- LookUpDown
        DisableControlAction(0, 142, display) -- MeleeAttackAlternate
        DisableControlAction(0, 18, display) -- Enter
        DisableControlAction(0, 322, display) -- ESC
        DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
    end
end)




RegisterNUICallback('pistole', function(data)
    TriggerServerEvent('dnz_waffendealer:pistole')
end)


RegisterNUICallback('heavypistole', function(data)
    TriggerServerEvent('dnz_waffendealer:heavypistole')
end)


RegisterNUICallback('revolver', function(data)
    TriggerServerEvent('dnz_waffendealer:revolver')
end)


RegisterNetEvent("dnz_waffendealer:dnzweiter")
AddEventHandler("dnz_waffendealer:dnzweiter", function()
    Washing()
end)

RegisterNetEvent("dnz_waffendealer:dnzende")
AddEventHandler("dnz_waffendealer:dnzende", function()
    Remelting()
end)

RegisterNetEvent('dnz_waffendealer:timer')
AddEventHandler('dnz_waffendealer:timer', function()
    local timer = 0
    local ped = PlayerPedId()
    
    Citizen.CreateThread(function()
		while timer > -1 do
			Citizen.Wait(150)

			if timer > -1 then
				timer = timer + 1
            end
            if timer == 100 then
                break
            end
		end
    end) 

Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1)

        
                if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.WashingX, Config.WashingY, Config.WashingZ, true) < 5 then
                    Draw3DText( Config.WashingX, Config.WashingY, Config.WashingZ+0.5 -1.400, ('Verarbeitung deiner Waffen Materialien ' .. timer .. '%'), 4, 0.1, 0.1)
                end
                if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.RemeltingX, Config.RemeltingY, Config.RemeltingZ, true) < 5 then
                    Draw3DText( Config.RemeltingX, Config.RemeltingY, Config.RemeltingZ+0.5 -1.400, ('Verarbeitung deiner Waffenteile ' .. timer .. '%'), 4, 0.1, 0.1)
                end
                if timer == 100 then
                    timer = 0
                    break
                end

        


    end
    end)
end)


RegisterNetEvent('dnz_waffendealer:createblips')
AddEventHandler('dnz_waffendealer:createblips', function()
    Citizen.CreateThread(function()
        while true do 
            Citizen.Wait(1)
                if blips == true and blipActive == false then
                    blip1 = AddBlipForCoord(-179.83, 6154.13, 31.06)
                    blip2 = AddBlipForCoord(Config.WashingX, Config.WashingY, Config.WashingZ)
                    blip3 = AddBlipForCoord(Config.RemeltingX, Config.RemeltingY, Config.RemeltingZ)
                    blip4 = AddBlipForCoord(Config.SellX, Config.SellY, Config.SellZ)
                    SetBlipSprite(blip1, 110)
                    SetBlipColour(blip1, 45)
                    SetBlipAsShortRange(blip1, true)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString("Materialien")
                    EndTextCommandSetBlipName(blip1)   
                    SetBlipSprite(blip2, 110)
                    SetBlipColour(blip2, 45)
                    SetBlipAsShortRange(blip2, true)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString("Materialien Verarbeitung")
                    EndTextCommandSetBlipName(blip2)   
                    SetBlipSprite(blip3, 110)
                    SetBlipColour(blip3, 45)
                    SetBlipAsShortRange(blip3, true)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString("Waffenschmiede")
                    EndTextCommandSetBlipName(blip3)
                    SetBlipSprite(blip4, 110)
                    SetBlipColour(blip4, 45)
                    SetBlipAsShortRange(blip4, true)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString("Waffenteile tauschen")
                    EndTextCommandSetBlipName(blip4)    
                    blipActive = true
                elseif blips == false and blipActive == false then
                    RemoveBlip(blip1)
                    RemoveBlip(blip2)
                    RemoveBlip(blip3)
                end
        end
    end)
end)



Citizen.CreateThread(function()
    blip1 = AddBlipForCoord(Config.CloakroomX, Config.CloakroomY, Config.CloakroomZ)
    SetBlipSprite(blip1, 110)
    SetBlipColour(blip1, 45)
    SetBlipAsShortRange(blip1, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Waffenherstellung")
    EndTextCommandSetBlipName(blip1)
end)


Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        Citizen.Wait(1)
            if not IsEntityDead( ped ) then
                if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.CloakroomX, Config.CloakroomY, Config.CloakroomZ, true) < 25 and ESX.PlayerData.job and ESX.PlayerData.job.name == 'waffendealer' then
                    DrawMarker(20, Config.CloakroomX, Config.CloakroomY, Config.CloakroomZ, 0, 0, 0, 0, 0, 90.0, 1.0, 1.0, 1.0, 0, 155, 253, 155, 0, 0, 2, 0, 0, 0, 0)
                        if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.CloakroomX, Config.CloakroomY, Config.CloakroomZ, true) < 1 then
                            ESX.ShowHelpNotification(' ~INPUT_CONTEXT~ um mit der Waffen Produktion zu starten')
                                if IsControlJustReleased(1, 51) then
                                    Cloakroom() 
                                end
                            end
                        end
                    end
                end
            end)

Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        Citizen.Wait(1)
            for i=1, #locations, 1 do
            if GetDistanceBetweenCoords(GetEntityCoords(ped), locations[i].x, locations[i].y, locations[i].z, true) < 25 and mineActive == false and ESX.PlayerData.job and ESX.PlayerData.job.name == 'waffendealer' then
                DrawMarker(20, locations[i].x, locations[i].y, locations[i].z, 0, 0, 0, 0, 0, 100.0, 1.0, 1.0, 1.0, 0, 155, 253, 155, 0, 0, 2, 0, 0, 0, 0)
                    if GetDistanceBetweenCoords(GetEntityCoords(ped), locations[i].x, locations[i].y, locations[i].z, true) < 1 then
                        ESX.ShowHelpNotification("~INPUT_CONTEXT~ um Waffen Materialien aufzuheben")
                            if IsControlJustReleased(1, 51) then
                                Animation()
                                mineActive = true
                            end
                        end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        Citizen.Wait(1)
        if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.WashingX, Config.WashingY, Config.WashingZ, true) < 25 and dnzweiterActive == false and ESX.PlayerData.job and ESX.PlayerData.job.name == 'waffendealer' then
            DrawMarker(20, Config.WashingX, Config.WashingY, Config.WashingZ, 0, 0, 0, 0, 0, 55.0, 1.0, 1.0, 1.0, 0, 155, 253, 155, 0, 0, 2, 0, 0, 0, 0)
                if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.WashingX, Config.WashingY, Config.WashingZ, true) < 1 then
                    ESX.ShowHelpNotification("~INPUT_CONTEXT~ um deine Waffen Materialien zu verarbeiten")
                        if IsControlJustReleased(1, 51) then
                            TriggerServerEvent("dnz_waffendealer:dnzweiter")
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        Citizen.Wait(1)
        if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.RemeltingX, Config.RemeltingY, Config.RemeltingZ, true) < 25 and dnzendeActive == false and ESX.PlayerData.job and ESX.PlayerData.job.name == 'waffendealer' then
            DrawMarker(20, Config.RemeltingX, Config.RemeltingY, Config.RemeltingZ, 0, 0, 0, 0, 0, 55.0, 1.0, 1.0, 1.0, 0, 155, 253, 155, 0, 0, 2, 0, 0, 0, 0)
                if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.RemeltingX, Config.RemeltingY, Config.RemeltingZ, true) < 1 then
                    ESX.ShowHelpNotification("~INPUT_CONTEXT~ um deine Teile zusammen zu kleben")
                        if IsControlJustReleased(1, 51) then
                          TriggerServerEvent("dnz_waffendealer:dnzende")  
                    end
                end
            end
        end
end)

Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        Citizen.Wait(1)
            if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.SellX, Config.SellY, Config.SellZ, true) < 2 and ESX.PlayerData.job and ESX.PlayerData.job.name == 'waffendealer' then
                ESX.ShowHelpNotification("~INPUT_CONTEXT~ um zu sehen ob sie deine Teile abnehmen würde")
                    if IsControlJustReleased(1, 51) then
                        SetDisplay(not display)                         
            end
        end
    end
 end)


 
Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        Citizen.Wait(300)
            if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.SellX, Config.SellY, Config.SellZ, true) < 2 and ESX.PlayerData.job and ESX.PlayerData.job.name == 'waffendealer' then
                TriggerServerEvent('dnz_waffendealer:abfrage')
        end
    end
 end)


Citizen.CreateThread(function()
    local hash = GetHashKey("ig_natalia")

    if not HasModelLoaded(hash) then
        RequestModel(hash)
        Citizen.Wait(100)
    end

    while not HasModelLoaded(hash) do
        Citizen.Wait(0)
    end

    if firstspawn == false then
        local npc = CreatePed(6, hash, Config.SellX, Config.SellY, Config.SellZ, 267.0, false, false)
        SetEntityInvincible(npc, true)
        FreezeEntityPosition(npc, true)
        SetPedDiesWhenInjured(npc, false)
        SetPedCanRagdollFromPlayerImpact(npc, false)
        SetPedCanRagdoll(npc, false)
        SetEntityAsMissionEntity(npc, true, true)
        SetEntityDynamic(npc, true)
		SetBlockingOfNonTemporaryEvents(npc, true)
    end
end)

function Cloakroom()
    local elements = {
        {label = 'Waffen Route: Starten',   value = 'cloakroom2'},
        {label = 'Waffen Route: Beenden',      value = 'cloakroom1'},
        {label = 'Beenden',      value = 'bye'},

    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'miner_actions', {
        title    = 'WAFFENDEALER',
        align    = 'top-left',
        elements = elements
    }, function(data, menu)
        if data.current.value == 'cloakroom1' then
            menu.close()
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                TriggerEvent('skinchanger:loadSkin', skin)
            end)  
            blips = false
            blipActive = false
            TriggerEvent("dnz_waffendealer:createblips")
        elseif data.current.value == 'cloakroom2' then
            menu.close()
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                if skin.sex == 0 then
                    TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
                else
                    TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
                end
                blips = true
                TriggerEvent("dnz_waffendealer:createblips")
            end)
        elseif data.current.value == 'bye' then
            menu.close()
        elseif data.current.value == 'vehicle' then
            menu.close()
            RequestModel("rumpo3")
            Citizen.Wait(100)
            CreateVehicle("rumpo3", -283.49, 2533.76, 72.67, 0.0, true, true)
            ESX.ShowNotification("Du hast dir ein Auto fur deine Minenarbeit geliehen.")
        end
    end)
end

function Jeweler()
    local elements = {
		{label = '50 Teile -> Pistole',   value = 'pistole'},
		{label = '100 Teile -> Heavy Pistole',   value = 'heavypistol'},
        {label = '150 Teile -> Revolver',   value = 'revolver'},
        {label = 'Beenden',      value = 'bye'},
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'jeweler_actions', {
        title    = 'Waffenhandel',
        align    = 'top-left',
        elements = elements
    }, function(data, menu)
        if data.current.value == 'pistole' then
            menu.close()
            TriggerServerEvent("dnz_waffendealer:pistole")
        elseif data.current.value == 'revolver' then
            menu.close()
            TriggerServerEvent("dnz_waffendealer:revolver")
        elseif data.current.value == 'bye' then
            menu.close()
		elseif data.current.value == 'heavypistol' then
            menu.close()
            TriggerServerEvent("dnz_waffendealer:heavypistole")
        end
    end)
end

function Animation()
    Citizen.CreateThread(function()
        while impacts < 5 do
            Citizen.Wait(1)
		local ped = PlayerPedId()	
                RequestAnimDict("amb@prop_human_bum_bin@idle_a")
                Citizen.Wait(100)
                TaskPlayAnim((ped), 'amb@prop_human_bum_bin@idle_a', 'idle_a', 8.0, 8.0, -1, 80, 0, 0, 0, 0)
                SetEntityHeading(ped, 137.0)
                if impacts == 0 then

                end  
                Citizen.Wait(2500)
                ClearPedTasks(ped)
                impacts = impacts+1
                if impacts == 5 then
                    mineActive = false
                    impacts = 0
                    TriggerServerEvent("dnz_waffendealer:dnzstart")
                    break
                end        
        end
    end)
end

function Washing()
    local ped = PlayerPedId()
    RequestAnimDict("amb@prop_human_bum_bin@idle_a")
    dnzweiterActive = true
    Citizen.Wait(100)
    FreezeEntityPosition(ped, true)
    TaskPlayAnim((ped), 'amb@prop_human_bum_bin@idle_a', 'idle_a', 8.0, 8.0, -1, 81, 0, 0, 0, 0)
    TriggerEvent("dnz_waffendealer:timer")
    Citizen.Wait(15900)
    ClearPedTasks(ped)
    FreezeEntityPosition(ped, false)
    dnzweiterActive = false
end

function Remelting()
    local ped = PlayerPedId()
    RequestAnimDict("amb@prop_human_bum_bin@idle_a")
    dnzendeActive = true
    Citizen.Wait(100)
    FreezeEntityPosition(ped, true)
    TaskPlayAnim((ped), 'amb@prop_human_bum_bin@idle_a', 'idle_a', 8.0, 8.0, -1, 81, 0, 0, 0, 0)
    TriggerEvent("dnz_waffendealer:timer")
    Citizen.Wait(15900)
    ClearPedTasks(ped)
    FreezeEntityPosition(ped, false)
    dnzendeActive = false
end

function Draw3DText(x,y,z,textInput,fontId,scaleX,scaleY)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)    
    local scale = (1/dist)*20
    local fov = (1/GetGameplayCamFov())*100 
    SetTextScale(0.35, 0.35)
    SetTextFont(fontId)
    SetTextProportional(0)
    SetTextColour(255, 255, 255, 215)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+2, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()   
end