Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)

local mainMenu = RageUI.CreateMenu("", "Wipe")
local confirmation = RageUI.CreateSubMenu(mainMenu, "", "Confirmation")
local open = false

mainMenu.Closed = function() open = false end

function Wipe()
    if not open then open = true RageUI.Visible(mainMenu, true) 
        Citizen.CreateThread(function()
            while open do
                RageUI.IsVisible(mainMenu, function()
                    for k,v in pairs(GetActivePlayers()) do
                        RageUI.Button(GetPlayerServerId(v).." ~b~- ~s~"..GetPlayerName(v), nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                idjoueur = GetPlayerServerId(v)
                                nomjoueur = GetPlayerName(v)
                            end
                        }, confirmation)
                    end
                end)
                RageUI.IsVisible(confirmation, function()
                    RageUI.Button("Oui", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            TriggerServerEvent('wipe:wipe', idjoueur, nomjoueur)
                        end
                    })
                    RageUI.Button("Non", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            RageUI.GoBack()
                        end
                    })
                end)
            Wait(0)
            end
        end)
    end
end

RegisterCommand('wipe', function()
    ESX.TriggerServerCallback('wipe:groupedujoueur', function(group)
        if group == 'superadmin' or group == 'admin' or group == 'mod' then
            Wipe()
        end
    end)
end)