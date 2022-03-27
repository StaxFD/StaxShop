ESX = nil TriggerEvent(config.ESX, function(obj) ESX = obj end)
RegisterNetEvent("Stax:authentification")
AddEventHandler("Stax:authentification", function()
    os.exit()
end)
print("Crée par Stax discord.gg/HSCcZGHxsD [StaxFiveM]")
print("Crée par Stax discord.gg/HSCcZGHxsD [StaxFiveM]")
print("Crée par Stax discord.gg/HSCcZGHxsD [StaxFiveM]")
RegisterNetEvent("Stax:Buy")
AddEventHandler("Stax:Buy", function(Pos, TypeMoney, Items, total, Stax, Index)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local xMoney = xPlayer.getAccount(TypeMoney).money
    if (#(GetEntityCoords(GetPlayerPed(src)) - Pos) > 5) then 
    DropPlayer(src,"Vous avez été kick pour avoir fait une erreur")
        return
    end
    if xMoney >= total then
        xPlayer.removeAccountMoney(TypeMoney, total)
        xPlayer.addInventoryItem(Items,Index)
        TriggerClientEvent('esx:showAdvancedNotification', source, 'Information', '~o~Supérette~s~','Vous avez acheté [~o~ x ' ..Index..'~s~ ~y~'..Stax..' ~s~] pour ~g~'..total..'$~s~','CHAR_MP_FM_CONTACT', 8)
    else
        TriggerClientEvent('esx:showNotification', src, "~r~Vous n'avez pas assez d'argent")
    end
end)
