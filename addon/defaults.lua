local _, ns = ...

local defaults = {
    microMenu = true,

    background = true,

    characterInfo = true,
    professions = true,
    spellbook = true,
    talents = true,
    legacy = true,
    questLog = true,
    guildAndInformation = true,
    groupFinder = true,
    accountCollections = true,
    shop = true,
    gameMenu = true,
    performanceBar = true,

    scale = 0.8
}

local defaultsPC = {
}

ns.database.Register(defaults, defaultsPC)
