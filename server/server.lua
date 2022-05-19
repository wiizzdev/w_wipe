ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('wipe:groupedujoueur', function(source, wiizz)
	local group = ESX.GetPlayerFromId(source).getGroup()
	wiizz(group)
end)

RegisterNetEvent("wipe:wipe")
AddEventHandler("wipe:wipe", function(idjoueur, nomjoueur)
    local xPlayer = ESX.GetPlayerFromId(idjoueur)
    DropPlayer(idjoueur, "Vous avez été wipe du serveur. Vous avez donc été déconnecté")
    MySQL.Async.execute([[ 
        DELETE FROM users WHERE identifier = @identifier; ]], {
            ['@identifier'] = xPlayer.getIdentifier(idjoueur),
        }, function()
    end)
    --[[
        copier-coller les lignes 14 à 18 pour pouvoir wipe d'autres tables sql
    ]]--
end)