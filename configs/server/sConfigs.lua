---@author Razzway
---@version 1.0
---@class _ServerConfig
_ServerConfig = {
    farmingTime = (2 * 2000), --> Temps entre récupération de chaque bitcoin

    enableLogs = true, -- Activer/Désactiver les logs discord
    param = {
        wehbook = '', --> Lien du wehbook
        name = 'Bitcoin - Logs', --> Nom du wehbook
        color = 15450635, --> Couleur du wehbook récolte
        colorSell = 586558, --> Couleur du wehbook vente
        colorAC = 15927354, --> Couleur du wehbook de triche
    },
}

--[[
    Exemple de couleur pour les logs (https://convertingcolors.com/) :
    - Rouge = 15927354
    - Bleu Marine = 2061822
    - Jaune = 15450635
    - Vert = 586558
    - Bleu Cyan = 578547
]]