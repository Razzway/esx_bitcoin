---@author Razzway
---@version 1.0
---@class _Config
_Config = {
    getESX = 'esx:getSharedObject', --> Trigger de déclaration ESX (default : esx:getSharedObject)
    Prefix = 'esx_bitcoin', --> Prefix des events
    showBlips = true, --> Afficher ou non les blips sur la carte
    showPed = true, --> Afficher le ped de revente de bitcoin
    scenarioPed = true, --> Animation du ped
    scenarioName = 'WORLD_HUMAN_DRUG_DEALER', --> https://wiki.rage.mp/index.php?title=Scenarios
    antiMoonwalk = false, --> Activer/Désactiver l'anti moonwalk (Le moonwalk permet de récolter + vite)

    Marker = { --> https://docs.fivem.net/docs/game-references/markers/
        Type = 1,
        Size = {3.0, 3.0, 1.3},
        Color = {252, 186, 3},
        Rotation = 0.0,
    },

    Events = {
        startHarvest = ':startHarvest',
        stopHarvest = ':stopHarvest',
        sellBitcoin = ':sellBitcoin',
    },

    position = {
        farm = {
            infoBlip = { --> https://docs.fivem.net/docs/game-references/blips/
                Name = 'Récolte de bitcoin',
                Sprite = 490,
                Display = 4,
                Scale = 0.8,
                Color = 5,
                Range = true,
            },
            interactionZone = {
                {pos = vector3(1272.9, -1711.71, 54.77-0.5)},
            },
        },
        sell = {
            infoBlip = {
                Name = 'Vente de bitcoin',
                Sprite = 674,
                Display = 4,
                Scale = 0.8,
                Color = 5,
                Range = true,
            },
            interactionZone = {
                {pos = vector3(708.26, -966.00, 30.39), pedPos = vector3(708.19, -966.91, 30.39-1), heading = 14.20, pedModel = 'a_m_m_fatlatin_01'},
            },
        },
    },

    item = {label = 'Bitcoin', name = 'bitcoin'},
    maxNumber = 50, --> Maximum de bitcoin que l'on peut récolter et avoir sur soi.
    sellingPrice = 100, --> Prix de vente x1 bitcoin
}