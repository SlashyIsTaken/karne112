ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function dikfeest(job, message, name, coords, src)
    local players = ESX.GetPlayers()
    local count = 0
    for i = 1, #players do
        local player = ESX.GetPlayerFromId(players[i])
        if player['job']['name'] == job then
            TriggerClientEvent('karne112:gadiehulphalen', players[i], players[i], message, coords, name)
            count = count + 1
        end
    end
    if count > 0 then 
        TriggerClientEvent('okokNotify:Alert', src, "Gelukt!", "De aangevraagde hulpdiensten zijn aanrijdend!", 5000, 'success')
    else
        TriggerClientEvent('okokNotify:Alert', src, "Helaas!", "Er is niemand van desbetreffende hulpdienst in de stad :(", 5000, 'error')
    end
end

RegisterCommand('112', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local name = xPlayer.getName()
    if args[1] ~= nil then
        local hulpdienst = table.remove(args, 1)
        if args[2] and args[3] then
            local message = table.concat(args, " ")
            if hulpdienst == 'politie' then
                dikfeest('police', message, name, coords, source)
            elseif hulpdienst == 'ambulance' then
                dikfeest('ambulance', message, name, coords, source)
            elseif hulpdienst == 'anwb' then
                dikfeest('mechanic', message, name, coords, source)
            else
                TriggerClientEvent('okokNotify:Alert', xPlayer.source, "Hmm...", "Ongeldige hulpdienst.", 5000, 'error')
            end
        else
            TriggerClientEvent('okokNotify:Alert', xPlayer.source, "Hmm...", "Erg uitgebreid ben je niet, of wel?", 5000, 'error')
        end
    else
        TriggerClientEvent('okokNotify:Alert', xPlayer.source, "Hmm...", "Allicht verstandig om iets in te vullen...", 5000, 'error')
    end
end, false)

RegisterServerEvent('karne112:karnelocatie')
AddEventHandler('karne112:karnelocatie', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local name = xPlayer.getName()
    
    if xPlayer['job']['name'] == 'police' then
        local players = ESX.GetPlayers()
        for i = 1, #players do
            local player = ESX.GetPlayerFromId(players[i])
            if player['job']['name'] == 'police' then
                TriggerClientEvent('karne112:komsnelniffo', players[i], name, coords)
            end
        end
    else
        TriggerClientEvent('okokNotify:Alert', xPlayer.source, "Hmm...", "Je bent niet bevoegd om dit uit te voeren...", 5000, 'error')
    end
end)

RegisterServerEvent('karne112:karnenoodknop')
AddEventHandler('karne112:karnenoodknop', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local name = xPlayer.getName()

    if xPlayer['job']['name'] == 'police' then
        local players = ESX.GetPlayers()
        for i = 1, #players do
            local player = ESX.GetPlayerFromId(players[i])
            if player['job']['name'] == 'police' then
                TriggerClientEvent('karne112:helpmedanniffo', players[i], name, coords)
            end
        end
    else
        TriggerClientEvent('okokNotify:Alert', xPlayer.source, "Hmm...", "Je bent niet bevoegd om dit uit te voeren...", 5000, 'error')
    end
end)