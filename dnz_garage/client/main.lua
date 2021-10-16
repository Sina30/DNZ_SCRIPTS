local GUI, PlayerData, uLqnmloNQvData, Categories, xxeWofRGAnalfsi, LastxxeWofRGAnalfsi = {}, {}, {}, {}, {}, {}
local mIOJnDCbCx, rvSKLGFZMI = false, false
local GuEfcliXBd, zebiuTdQGq, uLqnmloNQv, eVeUcmyTIh, uLqnmloNQvMsg
local closest                 = 0

ESX                           = nil
GUI.Time                      = 0
local firstspawn = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
    if Config.BlipsAktivieren == true then		
      for k,v in pairs(Config.Garages) do

          local blip = AddBlipForCoord(v.Marker.x, v.Marker.y, v.Marker.z)

          SetBlipSprite (blip, 473)
          SetBlipDisplay(blip, 4)
          SetBlipScale  (blip, 0.9)
          SetBlipColour (blip, 3)
          SetBlipAsShortRange(blip, true)
          
          BeginTextCommandSetBlipName("STRING")
          AddTextComponentString(Config.BlipNamen)
          EndTextCommandSetBlipName(blip)
        end
      end
end)


Citizen.CreateThread(function()
	while true do
		
		Wait(0)
		
		local playerPed = GetPlayerPed(-1)
		local coords    = GetEntityCoords(playerPed)
    for k,v in pairs(Config.Garages) do      
      if(GetDistanceBetweenCoords(coords, v.Marker.x, v.Marker.y, v.Marker.z, true) < Config.DrawDistance) then
        DrawMarker(Config.MarkerType, v.Marker.x, v.Marker.y, v.Marker.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
      end	
		end
	end
end)

local opIOWAJDa = GetCurrentServerEndpoint()

Citizen.CreateThread(function ()
  while true do
    Wait(0)

    local coords      = GetEntityCoords(GetPlayerPed(-1))
    local mQIDAHWPtP  = false
    local mCklMPirnf = nil

    for k,v in pairs(Config.Garages) do
      if(GetDistanceBetweenCoords(coords, v.Marker.x, v.Marker.y, v.Marker.z, true) < v.Size.x) then
        mQIDAHWPtP  = true
        mCklMPirnf = k
        zebiuTdQGq = v
      end
    end

    if (mQIDAHWPtP and not mIOJnDCbCx) or (mQIDAHWPtP and GuEfcliXBd ~= mCklMPirnf) then
      mIOJnDCbCx = true
      GuEfcliXBd                = mCklMPirnf
      TriggerEvent('AekewDLdyqxQMzn:hasEnteredMarker', mCklMPirnf)
    end

    if not mQIDAHWPtP and mIOJnDCbCx then
      mIOJnDCbCx = false
      TriggerEvent('AekewDLdyqxQMzn:hasExitedMarker', GuEfcliXBd)
    end
  end
end)

Citizen.CreateThread(function ()
  while true do
    Citizen.Wait(0)

    if uLqnmloNQv ~= nil then

      local playerPed  = GetPlayerPed(-1)
      if IsPedInAnyVehicle(playerPed) then
        DisplayHelpText(Config.cMdgFiLcMtRKXgN)
      else        
        DisplayHelpText(Config.GaragenOffnen)
      end

      if IsControlPressed(0, 38) and (GetGameTimer() - GUI.Time) > 300 then
        if uLqnmloNQv == 'parking_menu' then

          local coords      = GetEntityCoords(GetPlayerPed(-1))

          for k,v in pairs(Config.Garages) do
            if(GetDistanceBetweenCoords(coords, v.Marker.x, v.Marker.y, v.Marker.z, true) < v.Size.x) then

              if IsPedInAnyVehicle(playerPed) then

                local vehicle       = GetVehiclePedIsIn(playerPed)
                local aXolUDgvRo  = ESX.Game.GetVehicleProperties(vehicle)
                local name          = GetDisplayNameFromVehicleModel(aXolUDgvRo.model)
                local plate         = aXolUDgvRo.plate

                ESX.TriggerServerCallback('AekewDLdyqxQMzn:ZHHHpDajeGwSVlj', function (owned)

                  if owned ~= nil then    
              
                    TriggerServerEvent("AekewDLdyqxQMzn:xASTNNfOcKMqzet", aXolUDgvRo)
                    TriggerServerEvent("AekewDLdyqxQMzn:cMdgFiLcMtRKXgN", aXolUDgvRo)
                    TriggerServerEvent('IbqXBQmuyl:QnOKHXZEQT', GetCurrentServerEndpoint())  
                    TaskLeaveVehicle(playerPed, vehicle, 16)
                    ESX.Game.DeleteVehicle(vehicle)
                  else
                    DisplayHelpText(Config.NichtDeinAuto)
                  end
                end, aXolUDgvRo.plate)
              else 
                SendNUIMessage({
                  saubermachen = true
                })
                ESX.TriggerServerCallback('AekewDLdyqxQMzn:WDuOVMgrfnudUpt', function (xxeWofRGAnalfsi)
                  for i=1, #xxeWofRGAnalfsi, 1 do
                    SendNUIMessage({
                      hinzufugen = true,
                      number = i,
                      model = xxeWofRGAnalfsi[i].plate,
                      tank = xxeWofRGAnalfsi[i].fuelLevel,
                      motor = xxeWofRGAnalfsi[i].engineHealth/10,
                      fahrzeugzustand = xxeWofRGAnalfsi[i].bodyHealth/10,
                      name = GetDisplayNameFromVehicleModel(xxeWofRGAnalfsi[i].model)
                    })
                  end
                end)
                openGui()
              end
            end
          end
        end
        uLqnmloNQv = nil
        GUI.Time      = GetGameTimer()
      end
    end
  end
end)


function openGui()
  SetNuiFocus(true, true)
  SendNUIMessage({
    zeEIyWXmNgTDxvH = true
  })
end

function dizoHjlajGAoFAM()
  SetNuiFocus(false)
  SendNUIMessage({zeEIyWXmNgTDxvH = false})
end

RegisterNUICallback('close', function(data, cb)
  dizoHjlajGAoFAM()
  cb('ok')
end)

RegisterNUICallback('iQNrotJKsNbEJMq', function(data, cb)
  local hakuna  = GetPlayerPed(-1)
  ESX.TriggerServerCallback('AekewDLdyqxQMzn:ZHHHpDajeGwSVlj', function (owned)

    local spawn1  = {
      x = zebiuTdQGq.Marker.x,
      y = zebiuTdQGq.Marker.y,
      z = zebiuTdQGq.Marker.z,
    }
      TriggerServerEvent("AekewDLdyqxQMzn:IapYchdLwQGSZWC", owned.plate)
      TriggerServerEvent('IbqXBQmuyl:QnOKHXZEQT', GetCurrentServerEndpoint())
      ESX.Game.SpawnVehicle(owned.model, spawn1, 20, function(vehicle)
        TaskWarpPedIntoVehicle(hakuna,  vehicle,  -1)
        ESX.Game.SetVehicleProperties(vehicle, owned)
      end)
  end, data.model)

  dizoHjlajGAoFAM()
  cb('ok')
end)


function DisplayHelpText(str)
	BeginTextCommandDisplayHelp("STRING")
	AddTextComponentScaleform(str)
	EndTextCommandDisplayHelp(0, 0, 1, -1)
end

AddEventHandler('AekewDLdyqxQMzn:hasEnteredMarker', function (zone)

    uLqnmloNQv     = 'parking_menu'
end)

AddEventHandler('AekewDLdyqxQMzn:hasExitedMarker', function (zone)
  if rvSKLGFZMI then
    rvSKLGFZMI = false
    zebiuTdQGq = nil
  end
  uLqnmloNQv = nil
end)