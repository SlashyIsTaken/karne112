ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('karne112:gadiehulphalen')
AddEventHandler('karne112:gadiehulphalen', function(id, bericht, coords, naam)
    exports['okokNotify']:Alert("112 Melding", "<br><b>Omschrijving</b><br>"..bericht.."<br><br>Gemeld door: <i>"..naam.."</i><br><br>Druk op <b>Z</b> om je navigatie in te stellen!", 20000, 'warning')
    waitingforpress(coords.x, coords.y)
end)

RegisterCommand('karnelocatie', function()
    TriggerServerEvent('karne112:karnelocatie')
end)

RegisterCommand('karnenoodknop', function()
    TriggerServerEvent('karne112:karnenoodknop')
end)

RegisterNetEvent('karne112:komsnelniffo')
AddEventHandler('karne112:komsnelniffo', function(name, coords)
    exports['okokNotify']:Alert("Politie Locatie Gedeeld", "<br><b>EENHEDEN OPGELET</b><br><br>Collega <i>"..name.."</i> heeft zijn locatie gedeeld.<br><br>Druk op <b>Z</b> om je navigatie in te stellen.", 10000, 'warning')
    waitingforpress(coords.x, coords.y)
end)

RegisterNetEvent('karne112:helpmedanniffo')
AddEventHandler('karne112:helpmedanniffo', function(name, coords)
    exports['okokNotify']:Alert("NOODKNOP INGEDRUKT", "<br><b>EENHEDEN OPGELET</b><br><br>Collega <i>"..name.."</i> heeft zijn noodknop ingedrukt!<br><br>Druk op <b>Z</b> om je navigatie in te stellen.", 10000, 'error')
    waitingforpress(coords.x, coords.y)
end)

function waitingforpress(posx, posy)
    local timer = 1500
    while timer >= 1 do
        Citizen.Wait(1)
        if IsControlJustPressed(1, 48) then
            DeleteWaypoint()
            SetNewWaypoint(posx, posy)
        end
        timer = timer - 1
    end
end

TriggerEvent('chat:addSuggestion', '/112', 'Bel de hulpdiensten',
{ 
    { name = 'hulpdienst', help = "Naam van de hulpdienst. Vul politie, ambulance, of anwb in." },
    { name = 'bericht', help = "Vul hier kort en bondig, maar niet overhaast, je melding in." } 
})

RegisterKeyMapping('karnelocatie', 'Politie Locatie', 'keyboard', 'F9')
RegisterKeyMapping('karnenoodknop', 'Politie Noodknop', 'keyboard', 'F11')