local display = false



Key = 38

local ESX = nil
local PlayerData                = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local menuEnabled = false 

function ToggleActionMenu()
	-- Make the menuEnabled variable not itself 
	-- e.g. not true = false, not false = true 
	menuEnabled = not menuEnabled

	if ( menuEnabled ) then 
		-- Focuses on the NUI, the second parameter toggles the 
		-- onscreen mouse cursor. 
		SetNuiFocus( true, true )

		-- Sends a message to the JavaScript side, telling it to 
		-- open the menu. 
		SendNUIMessage({
			showmenu = true 
		})
	else 
		-- Bring the focus back to the game
		SetNuiFocus( false )

		-- Sends a message to the JavaScript side, telling it to
		-- close the menu.
		SendNUIMessage({
			hidemenu = true 
		})
	end 
end

function TutorialFunction() -- Tutorial Menu and Majic ( DO NOT EDIT UNLESS YOU KNOW WHAT YOU ARE DOING )
    local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)
	local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    TriggerEvent('chat:clear')  --- Clear current chat
    TriggerEvent('chat:toggleChat') --- Toggle chat chat
    SetEntityVisible(playerPed, false, 0)
    createdCamera = cam --- Create Cam
    SetEntityVisible(playerPed, false, 0) --- Make Player Invisible
    SetEntityCoordsNoOffset(playerPed, -103.8, -921.06, 297.29, false, false, false, true) --- Teleport Infront of Maze Bank IN Air
    FreezeEntityPosition(playerPed, true) --- Freeze The Player There
    SetFocusEntity(playerPed) ---- Focus on the player (To Render the building)
    SetCamCoord(cam, -103.8, -921.06, 287.29) --- Set the camera there
    RenderScriptCams(1, 0, 0, 1, 1) --- Render Cams
    ESX.ShowHelpNotification('Willkommen auf ~r~DNZ Scripts~w~ \n')
    Citizen.Wait(250)
    Citizen.Wait(5000)
    ESX.ShowHelpNotification('Dein Text!')
    Citizen.Wait(6050)
    DoScreenFadeOut(800) --- Fade Out the screen
    Citizen.Wait(3000) --- Wait (3 Seconds)
    SetEntityCoordsNoOffset(playerPed, -249.46, -991.05, 45.23, false, false, false, true) --- Teleport Player Infront Job Center
    FreezeEntityPosition(playerPed, true) --- Freeze Player
    SetFocusEntity(playerPed) --- Focus on the player (To Render Building)
    Citizen.Wait(800) --- Wait 0.8 Seconds
    SetCamCoord(cam, -249.46, -991.05, 35.23) -- Set the Camera Infront of the Job Center
    RenderScriptCams(1, 0, 0, 1, 1) -- Render Cams
    DoScreenFadeIn(800) --- Fade In Showing the Screen
    Citizen.Wait(1000)
    ESX.ShowHelpNotification('~b~Das Arbeitsamt\n~w~Dein Text!')
    Citizen.Wait(5000)
    ESX.ShowNotification('Hier kannst du auch was anzeigen! :D')
    Citizen.Wait(8000)
    DoScreenFadeOut(800) --- Fade Out the screen
    Citizen.Wait(3000) --- Wait (3 Seconds)
    SetEntityCoordsNoOffset(playerPed, 205.83, -823.55, 45.42, false, false, false, true) --- Teleport Player Infront Legion Garage
    FreezeEntityPosition(playerPed, true) --- Freeze Player
    SetFocusEntity(playerPed) --- Focus on the player (To Render Building)
    Citizen.Wait(800) --- Wait 0.8 Seconds
    SetCamCoord(cam, 205.83, -823.55, 35.42) -- Set the Camera Infront of the Legion Garage
    RenderScriptCams(1, 0, 0, 1, 1) -- Render Cams
    DoScreenFadeIn(800) --- Fade In Showing the Screen
    Citizen.Wait(1000)
    ESX.ShowHelpNotification('~b~Meetinpoint Garage\n~w~Dein Text!')
    Citizen.Wait(5000)
    ESX.ShowHelpNotification('Dein Text!')
    Citizen.Wait(5000)
    ESX.ShowHelpNotification('~o~Hinweiß:\nDein Text!')
    Citizen.Wait(5000)
    DoScreenFadeOut(800) --- Fade Out the screen
    Citizen.Wait(3000) --- Wait (3 Seconds)
    SetEntityCoordsNoOffset(playerPed, 239.68, -1380.57, 33.74, false, false, false, true) --- Teleport Player Infront Grove Street
    FreezeEntityPosition(playerPed, true) --- Freeze Player
    SetFocusEntity(playerPed) --- Focus on the player (To Render Building)
    Citizen.Wait(800) --- Wait 0.8 Seconds
    SetCamCoord(cam, 229.34, -1382.64, 30.60) -- Set the Camera Infront of the Grove Street
    RenderScriptCams(1, 0, 0, 1, 1) -- Render Cams
    SetCamRot(cam, 0.0, 0.0, 110.0)
    DoScreenFadeIn(800) --- Fade In Showing the Screen
    Citizen.Wait(1000)
    ESX.ShowHelpNotification('~r~Die Fahrschule\n~w~Falls du einen Führerschein benötigst, findest du hier Fahrlehrer.')
    Citizen.Wait(8000)
    DoScreenFadeOut(800) --- Fade Out the screen
    Citizen.Wait(3000) --- Wait (3 Seconds)
    SetEntityCoordsNoOffset(playerPed, 6.44, -1140.07, 41.93, false, false, false, true) --- Teleport Player Infront Ammunation
    FreezeEntityPosition(playerPed, true) --- Freeze Player
    SetFocusEntity(playerPed) --- Focus on the player (To Render Building)
    Citizen.Wait(800) --- Wait 0.8 Seconds
    SetCamCoord(cam, 6.44, -1140.07, 31.93) -- Set the Camera Infront of the Ammunation
    RenderScriptCams(1, 0, 0, 1, 1) -- Render Cams
    SetCamRot(cam, 0.0, 0.0, 0.0)
    DoScreenFadeIn(800) --- Fade In Showing the Screen
    Citizen.Wait(1000)
    ESX.ShowHelpNotification('~b~Waffenlizenz\n~w~ Dein Text!')
    Citizen.Wait(9000)
    ESX.ShowHelpNotification('Dein Text!')
    Citizen.Wait(8000)
    DoScreenFadeOut(800) --- Fade Out the screen
    Citizen.Wait(3000) --- Wait (3 Seconds)
    SetEntityCoordsNoOffset(playerPed, -461.33, -335.68, 45.5, false, false, false, true) --- Teleport Player Hospital
    FreezeEntityPosition(playerPed, true) --- Freeze Player
    SetFocusEntity(playerPed) --- Focus on the player (To Render Building)
    Citizen.Wait(800) --- Wait 0.8 Seconds
    SetCamCoord(cam, -461.33, -335.68, 35.5) -- Set the Camera Infront of the Hospital
    RenderScriptCams(1, 0, 0, 1, 1) -- Render Cams
    SetCamRot(cam, 0.0, 0.0, -90.0)
    DoScreenFadeIn(800) --- Fade In Showing the Screen
    Citizen.Wait(1000)
    ESX.ShowHelpNotification('~r~Das Krankenhaus\n~w~Wenn du hier aufwachst, hast du alles vergessen.')
    Citizen.Wait(9000)
    ESX.ShowHelpNotification('Wir wünschen dir viel Spass mit ~r~Scripts by dnz~w~')
    SetEntityCoordsNoOffset(playerPed, -1037.16, -2737.07, 19.55, false, false, false, true) --- Teleport Player Back to start
    FreezeEntityPosition(playerPed, true) --- Freeze The Player There
    SetEntityVisible(playerPed, true, 0) --- set visable
    FreezeEntityPosition(playerPed, false) -- unfreeze
    DestroyCam(createdCamera, 0)
    DestroyCam(createdCamera, 0)
    RenderScriptCams(0, 0, 1, 1, 1)
    createdCamera = 0
    ClearTimecycleModifier("scanline_cam_cheap")
    SetFocusEntity(GetPlayerPed(PlayerId()))
    SetEntityVisible(playerPed, true, 0)
    spawn_effect("bmx")
end


RegisterNUICallback("exit", function(data)
    SetDisplay(false)
end)

Citizen.CreateThread(function ()
	while true do
        Citizen.Wait(0)
        DrawMarker(7, -1037.59, -2737.55, 20.16, 0, 0, 0, 0, 0, 0, 1.0001,1.0001,1.0001, 0, 232, 255, 155, 0, 0, 0, 0, 0, 0, 0)
        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),  -1037.59, -2737.55, 20.16, true) < 10 then
                Draw3DText(-1037.59, -2737.55, 20.56, '~g~[E]~w~ um deine Einreise zu starten')
                Draw3DText(-1037.59, -2737.55, 20.76, '~w~Scripts by dnz~r~')
                    if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),  -1037.59, -2737.55, 20.16, true) < 1 then
                        if (IsControlJustReleased(1, 51)) then
                            SetDisplay(not display)
                        end
                end
            end
        end
end)


RegisterNUICallback("main", function(data)
    SetDisplay(false)
    TutorialFunction()
end)

RegisterNUICallback("error", function(data)
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
        -- https://runtime.fivem.net/doc/natives/#_0xFE99B66D079CF6BC
        --[[ 
            inputGroup -- integer , 
	        control --integer , 
            disable -- boolean 
        ]]
        DisableControlAction(0, 1, display) -- LookLeftRight
        DisableControlAction(0, 2, display) -- LookUpDown
        DisableControlAction(0, 142, display) -- MeleeAttackAlternate
        DisableControlAction(0, 18, display) -- Enter
        DisableControlAction(0, 322, display) -- ESC
        DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
    end
end)

function spawn_effect(somecar) 
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	TriggerEvent('esx:spawnVehicle', somecar)
	DoScreenFadeIn(3000) 
end

function Draw3DText(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = 0.25
   
    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(1, 1, 0, 0, 255)
        SetTextEdge(0, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(2)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end
