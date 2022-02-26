---@author Razzway
---@version 1.0
---@class Server
Server = {} or {};
isHarvesting = {}

---@public
function Server:Harvest(source)
    SetTimeout(_ServerConfig.farmingTime, function()
        if isHarvesting[source] then
            local xPlayer = ESX.GetPlayerFromId(source)
            local PlayerInventory = xPlayer.getInventoryItem('bitcoin')

            if PlayerInventory.limit ~= -1 and PlayerInventory.count >= _Config.maxNumber then
                TriggerClientEvent('esx:showNotification', source, '~r~Inventaire complet.')
            else
                xPlayer.addInventoryItem('bitcoin', 1)
                Server:toDiscord(_ServerConfig.param.name, xPlayer.getName()..' a miné x1 bitcoin', _ServerConfig.param.color)
                Server:Harvest(source)
            end
        end
    end)
end

function Server:toDiscord(name, message, color)
    date_local1 = os.date('%Hh%M & %Ss', os.time())
    local date_local = date_local1
    local DiscordWebHook = _ServerConfig.param.wehbook

    local embeds = {
        {
            ["title"]= message,
            ["type"]="rich",
            ["color"] =color,
            ["footer"]=  {
                ["text"]= "Aujourd'hui à : " ..date_local.. "",
            },
        }
    }

    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

