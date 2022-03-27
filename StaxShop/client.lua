ESX = nil TriggerEvent(config.ESX, function(obj) ESX = obj end)
Citizen.CreateThread(function()
    blips()
end)
local List = config.Informations.List
local listmoney = config.Informations.listmoney
local money = config.Informations.ListePayement
local total = config.Informations.totalprix
local panieer = config.Informations.panier
function OpenMenuShop(Shop)
    ---- // ## Crée par Stax ## \\ ----
    local superette = RageUI.CreateMenu(config.Informations.TitreMenu, config.Informations.SousMenu)
    local panier = RageUI.CreateSubMenu(superette,config.Informations.TitreMenu, config.Informations.SousMenu1)
    local payer = RageUI.CreateSubMenu(panier,config.Informations.TitreMenu, config.Informations.SousMenu1)
    RageUI.Visible(superette, true)
    while superette do
        Citizen.Wait(0)
        RageUI.IsVisible(superette, function()
            RageUI.Separator(config.Informations.PrixTotal.."["..config.Informations.couleurvert..""..total.."~s~] $")
            RageUI.List(config.Informations.Button.categorie, config.Informations.ListeCategories, List, nil, {}, true, {
                onListChange = function(Index, Items)
                    List = Index;
                end,
            })
            if List == 1 then
                for k,v in ipairs(config.Shop.Nourritures) do 
                    RageUI.Button(v.label, nil, {RightLabel = (config.Informations.couleurvert.."%s$"):format(v.price)}, true, {
                        onSelected = function()
                            local number = Visual.KeyboardNumber(config.Informations.KeyBoard, "", 2)
                            if number == 0 or number == nil then
                                ESX.ShowNotification(config.Informations.Notification)
                            elseif number > v.maxitem then 
                                ESX.ShowNotification(config.Informations.Notification2..v.maxitem.." ~y~"..v.label.."")
                            else
                                total = total + v.price * number   
                                table.insert(panieer, {label = v.label, price = v.price, number = number})
                                ESX.ShowNotification(config.Informations.addpanier..number.." ~y~"..v.label.." dans votre panier")
                            end
                        end,
                    })
                end
            elseif List == 2 then
                for k,v in ipairs(config.Shop.Boissons) do 
                    RageUI.Button(v.label, nil, {RightLabel = (config.Informations.couleurvert.."%s$"):format(v.price)}, true, {
                        onSelected = function()
                            local number = Visual.KeyboardNumber(config.Informations.KeyBoard, "", 2)
                            if number == 0 or number == nil then
                                ESX.ShowNotification(config.Informations.Notification)
                            elseif number > v.maxitem then 
                                ESX.ShowNotification(config.Informations.Notification2..v.maxitem.." ~y~"..v.label.."")
                            else
                                total = total + v.price * number   
                                table.insert(panieer, {label = v.label, price = v.price, number = number})
                                ESX.ShowNotification(config.Informations.addpanier..number.." ~y~"..v.label.." dans votre panier")
                            end
                        end,
                    })
                end
            elseif List == 3 then
                for k,v in ipairs(config.Shop.Autres) do 
                    RageUI.Button(v.label, nil, {RightLabel = (config.Informations.couleurvert.."%s$"):format(v.price)}, true, {
                        onSelected = function()
                            local number = Visual.KeyboardNumber(config.Informations.KeyBoard, "", 2)
                            if number == 0 or number == nil then
                                ESX.ShowNotification(config.Informations.Notification)
                            elseif number > v.maxitem then 
                                ESX.ShowNotification(config.Informations.Notification2..v.maxitem.." ~y~"..v.label.."")
                            else
                                total = total + v.price * number   
                                table.insert(panieer, {label = v.label, price = v.price, number = number})
                                ESX.ShowNotification(config.Informations.addpanier..number.." ~y~"..v.label.." dans votre panier")
                            end
                        end,
                    })
                end
            end
            RageUI.Button(config.Informations.Button.acceder,nil,{},true,{
            },panier)
        end)
    RageUI.IsVisible(panier,function()
        if total == 0 then
            RageUI.Separator("")
            RageUI.Separator(config.Informations.Button.separator)
            RageUI.Separator("")
            return
        end
        RageUI.Separator(config.Informations.PrixTotal..":"..config.Informations.couleurvert..""..total.."~s~ $") 
        RageUI.Separator(config.Informations.Button.separator1)
        for k,v in pairs(panieer) do
            RageUI.Button(v.label.." (x"..v.number..")", nil, {RightLabel = config.Informations.couleurvert..""..v.price*v.number.."~s~ $"}, true, {
                onSelected = function()
                    local suppr = Visual.KeyboardText(config.Informations.Notification3, "", 3)
                    if suppr:lower() == "non" or suppr:upper() == "NON" or suppr == nil then
                        ESX.ShowNotification(config.Informations.Notification4)
                    elseif suppr:lower() == "oui" or suppr:upper() == "OUI" then
                        total = total - v.price * v.number
                        v.number = v.number - v.number
                        if v.number == 0 then
                            table.remove(panieer, k)
                        end
                    end
                end,
            })
        end
        RageUI.Button(config.Informations.couleurvert..config.Informations.Button.acheter,nil,{},true,{
        },payer)
        RageUI.Button(config.Informations.Button.vider, nil, {}, true, {
            onSelected = function()
                total = 0
                panieer = {}
            end,
        })
    end)
    RageUI.IsVisible(payer,function()
        RageUI.Button(config.Informations.Button.payer, nil, {}, true, {
            onSelected = function()
                for k,v in pairs(panieer) do
                    TriggerServerEvent("Stax:Buy", Shop,"money", v.item, total, v.label, v.number)
                end
                panieer = {}
                total = 0
                RageUI.GoBack()  
            end,
        })
        RageUI.Button(config.Informations.Button.payer2, nil, {}, true, {
            onSelected = function()
                for k,v in pairs(panieer) do
                    TriggerServerEvent("Stax:Buy", Shop,"bank", v.item, total, v.label, v.number)
                end
                panieer = {}
                total = 0  
                RageUI.GoBack()   
                ---- // ## Crée par Stax ## \\ ----       
            end,
        })
    end)
        if not RageUI.Visible(superette) and not RageUI.Visible(panier) and not RageUI.Visible(payer) then 
            ---- // ## Crée par Stax ## \\ ----
            superette = RMenu:DeleteType("superette",true, FreezeEntityPosition(PlayerPedId(),false))
            panier = RMenu:DeleteType("panier", true)
            payer = RMenu:DeleteType("payer", true)
        end
    end
end

Citizen.CreateThread(function()
    while true do
        local playerPos = GetEntityCoords(PlayerPedId())
        local goSleep = 700
        for k,v in ipairs(config.Positions) do 
            local dst5 = GetDistanceBetweenCoords(playerPos, v.pos, true)
            if dst5 < 5.0 then
                goSleep = 0
                ---- // ## Crée par Stax ## \\ ----
                DrawMarker(config.typemarker, v.pos, 3.0, 5.0, 500.0, 1.0, 50.0, 0.0, config.taillemarker.x,config.taillemarker.y,config.taillemarker.z, config.colormarker.r, config.colormarker.g, config.colormarker.b, config.colormarker.a, false, false, 2, nil, nil, false)
                DrawMarker(config.typemarker2, v.pos, 3.0, 5.0, 500.0, 1.0, 50.0, 0.0, config.taillemarker2.x,config.taillemarker2.y,config.taillemarker2.z, config.colormarker.r, config.colormarker.g, config.colormarker.b, config.colormarker.a, false, false, 2, nil, nil, false)
                if dst5 < 1.2 then
                    helpNotif(config.notif)
                    if IsControlJustReleased(0, 38) then
                        FreezeEntityPosition(PlayerPedId(),true)
                        OpenMenuShop(v.pos)
                    end
                end
            end
        end
        Wait(goSleep)
    end
end)
function helpNotif(msg, thisFrame)
    ---- // ## Crée par Stax ## \\ ----
    AddTextEntry('HelpNotification', msg)
    DisplayHelpTextThisFrame('HelpNotification', false)
end
function blips()
    ---- // ## Crée par Stax ## \\ ----
    for _,v in pairs(config.Positions) do
        local Blips = AddBlipForCoord(v.pos)
        SetBlipSprite (Blips, v.BlipSprite)
        SetBlipDisplay(Blips, v.BlipDisplay)
        SetBlipScale  (Blips, v.BlipScale)
        SetBlipColour (Blips, v.BlipColor)
        SetBlipAsShortRange(Blips, v.afficherblip)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.BlipLabel)
        EndTextCommandSetBlipName(Blips)
    end
end