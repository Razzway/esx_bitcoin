---@author Razzway
---@version 1.0

quantity = {bitcoin = ''}

function Client:openSellMenu(bitcoin)
    local mainMenu = RageUI.CreateMenu('Revente', 'Tu souhaites revendre mon gars ?')

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while mainMenu do
        Wait(0)

        RageUI.IsVisible(mainMenu, function()
            FreezeEntityPosition(PlayerPedId(), true)
            RageUI.Line()
            RageUI.Button('~c~→~s~ Vendre du bitcoin', nil, {RightLabel = quantity.bitcoin}, true, {
                onSelected = function()
                    local qty = Client:input('Indiquez le nombre que vous souhaitez vendre :', '', 20)
                    if qty ~= '' then
                        quantity.bitcoin = qty
                        indicator = true
                    else
                        ESX.ShowNotification('~r~Il semblerait que vous n\'avez entré aucune valeur.')
                    end
                end
            })
            if indicator then
                local price = (quantity.bitcoin * _Config.sellingPrice)
                RageUI.Button('~c~→~s~ Prix de revente', nil, {RightLabel = price..'~g~$~s~'}, true, {})
                RageUI.Button('Confirmer la revente', ('Si tu confirmes la revente, je te passerai %s ~g~$~s~ en cash direct. Je t\'achète chaque btc pour %s ~g~$~s~ l\'unité !'):format(price, _Config.sellingPrice), {RightBadge = RageUI.BadgeStyle.Tick, Color = { HightLightColor = {39, 227, 45, 160}, BackgroundColor = {39, 227, 45, 160} }}, true, {
                    onSelected = function()
                        TriggerServerEvent((_Config.Prefix..'%s'):format(_Config.Events.sellBitcoin), quantity.bitcoin, price)
                    end
                })
            end
        end)

        if not RageUI.Visible(mainMenu) then
            mainMenu = RMenu:DeleteType('mainMenu', true)
            quantity.bitcoin = ''
            indicator = false
            FreezeEntityPosition(PlayerPedId(), false)
        end
    end
end