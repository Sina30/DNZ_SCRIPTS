


-- Register Events Server
ESX = nil
local spielerID = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)



local function convert( chars, dist, inv )
	return string.char( ( string.byte( chars ) - 32 + ( inv and -dist or dist ) ) % 95 + 32 )
 end
 
 local function crypt(str,k,inv)
	local enc= "";
	for i=1,#str do
	   if(#str-k[5] >= i or not inv)then
		  for inc=0,3 do
			 if(i%4 == inc)then
				enc = enc .. convert(string.sub(str,i,i),k[inc+1],inv);
				break;
			 end
		  end
	   end
	end
	if(not inv)then
	   for i=1,k[5] do
		  enc = enc .. string.char(math.random(32,126));
	   end
	end
	return enc;
 end


-- Register Events Server
RegisterServerEvent('dnz_loginsystem:validatelogin')
AddEventHandler('dnz_loginsystem:validatelogin', function(username, password)

	local identifier = GetPlayerIdentifiers(source)[1]
	local enc1 = {29, 58, 93, 28 ,27};
	local str = password;
	local crypted = crypt(str,enc1)
	local result = MySQL.Sync.fetchAll("SELECT username FROM dnz_players WHERE identifier = @identifier", { ['@identifier'] = identifier})	-- get only matched login with password in table players
	local Player = result[1]
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	--MySQL.Async.fetchAll('SELECT password, username, identifier FROM dnz_players WHERE identifier = @identifier', {['@identifier'] = identifier}, function(result)

	MySQL.Async.fetchAll('SELECT password, identifier, gebannt FROM dnz_players WHERE username = @username', {['@username'] = username}, function(result)
		local cryptedpwdb = crypt(result[1].password,enc1,true)
		local registrationsid = result[1].identifier
		local isBanned = result[1].gebannt
		
				if password == cryptedpwdb then
						if registrationsid == identifier then
							if isBanned > 0 then
								TriggerClientEvent('dnz_loginsystem:wronglogin', spielerID, "gebannt") 
								--banned
							else
								local ValidMessage = "Willkommen, " .. username 		
								TriggerClientEvent('dnz_loginsystem:rightlogin', spielerID, ValidMessage) 
							end

						else 
							TriggerClientEvent('dnz_loginsystem:wronglogin', spielerID, "invalidaccount") 
							reportsystem('Serverlog','Invalider Account Login\n', 16711680 ,'ACHTUNG: Der Benutzer **' .. username .. '** wollte sich mit einem invaliden Steam Identifier anmelden\n**Account Erstellung:** ' .. registrationsid .. '\n **Versuchter Login:** ' .. identifier)
						end
				else
					local ErrorMessage = "InvalidLogin"
					TriggerClientEvent('dnz_loginsystem:wronglogin', spielerID, ErrorMessage) 
					reportsystem('Serverlog','Invalider Account Login\n', 16711680 ,'ACHTUNG: Der Steam Identifier "' .. identifier .. '" hat soebend für den Benutzer **' .. username .. '** hat ein falsches Passwort verwendet.')
				end
	end)
end)

RegisterServerEvent('loginabfragen')
AddEventHandler('loginabfragen', function()
    local _source = source
	local identifier = GetPlayerIdentifiers(_source)[1]
	spielerID = _source
    MySQL.ready(function ()
		MySQL.Async.fetchAll('SELECT register FROM users WHERE identifier = @identifier', {['@identifier'] = identifier}, function(result)
			_registriert = result[1].register
			TriggerClientEvent("dnz_loginsystem:antwort", _source, _registriert)
		
		end)
	end)
end)


RegisterServerEvent('dnz_loginsystem:registerbro')
AddEventHandler('dnz_loginsystem:registerbro', function(username, password	)	
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local identifier = GetPlayerIdentifiers(_source)[1]
	local steamname = GetPlayerName(_source)
    local result = MySQL.Sync.fetchAll("SELECT * FROM dnz_players WHERE username = @username", { ['@username'] = username } )	-- get only matched login with password in table players	
	local Player = result[1]

	local enc1 = {29, 58, 93, 28 ,27};
	local str = password;
	local crypted = crypt(str,enc1)

	
	if Player == nil then -- If resultat exist
		MySQL.Async.fetchAll("INSERT INTO dnz_players (identifier,steamname, username, password) VALUES (@identifier, @steamname, @username, @password)",
		{["@username"] = username, 
		["@identifier"] = identifier, 
		["@steamname"] = steamname,
		["@password"] = crypted},
		function (result)
			MySQL.Sync.execute("UPDATE users SET register = 1 WHERE identifier =@identifier", {['@identifier'] = identifier})
		end)
		local user = username
		local ValidMessage = user .. ", du hast dir erfolgreich einen Benutzeraccount erstellt!"
		TriggerClientEvent('dnz_loginsystem:rightreg', spielerID, ValidMessage) -- go to client even
	else -- otherwise
		local ErrorMessage = "vergeben"		
		TriggerClientEvent('dnz_loginsystem:wrongreg', spielerID, ErrorMessage) -- go to client even
	end	
end)


RegisterServerEvent('dnz_loginsystem:respondelizenz')
AddEventHandler('dnz_loginsystem:respondelizenz', function(serverip)	
	PerformHttpRequest("dnzscripts.000webhostapp.com", function(err, text, headers)
		if string.match(text, serverip) then
			print("^1[dnz_scripts]^0 Heartbeat für Server IP: " .. serverip .. " > ^2akzeptiert.")
			admincall('Serverlog','Valid\n', 38656 ,'**Server IP:** ```' .. serverip .. '```\n**Pluginname:**```' .. GetCurrentResourceName().. '```')
		else
			print("^1[dnz_scripts]^0 Heartbeat für Server IP: " .. serverip .. " > ^1nicht akzeptiert.")
			print("^1[dnz_scripts] ^0Script Sharing = Discord Ban")
			admincall('Serverlog','Invalid\n', 16711680 ,'**Server IP:**```' .. serverip .. '```\n**Pluginname:**```' .. GetCurrentResourceName() .. '```')
			nolicense()
		end
	end, 'GET', '')
end)

function nolicense ()
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		local xname = GetPlayerName(xPlayers[i])
        xPlayer.kick("🌙 dnz_scripts: Dieser Server hat keine valide Lizenz für das Login System.")
    end
end



RegisterServerEvent('registerabfrage')
AddEventHandler('registerabfrage', function()
    local _source = source
	local identifier = GetPlayerIdentifiers(_source)[1]
	local spielerID = source
	print(spielerID)
    MySQL.ready(function ()
		MySQL.Async.fetchAll('SELECT register FROM users WHERE identifier = @identifier', {['@identifier'] = identifier}, function(result)
			_registriert = result[1].register
		TriggerClientEvent("dnz_loginsystem:regantwort", _source, _registriert)
		end)
	end)
end)


function admincall (name,message,color,nachricht)
	local DiscordWebHook = "https://discordapp.com/api/webhooks/783141910323396608/Weqdo2T5h6EQIHDkYnxFA7LpNS02jp4CQgdiCr0yDg29KcGdq8YHFohu0RmOEQvZSPFq"
	-- Modify here your discordWebHook username = name, content = message,embeds = embeds

  local embeds = {
	  {
		  ["title"]=message,
		  ["type"]="rich",
		  ["color"] =color,
		  ["description"] = nachricht,
		  ["footer"]=  {
			  ["text"]= "dnz_discord - lizenzsystem",
		 },
	  }
  }
  
	if message == nil or message == '' then return FALSE end
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end



function reportsystem (name,message,color,nachricht)
	local DiscordWebHook = Config.ReportWebhook
	-- Modify here your discordWebHook username = name, content = message,embeds = embeds






  local embeds = {
	  {
		  ["title"]=message,
		  ["type"]="rich",
		  ["color"] =color,
		  ["description"] = nachricht,
		  ["footer"]=  {
			  ["text"]= "dnz_discord - Invalide Accounts",
		 },
	  }
  }
  
	if message == nil or message == '' then return FALSE end
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end
