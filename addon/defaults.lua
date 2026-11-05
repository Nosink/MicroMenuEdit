local _, ns = ...

local defaults = {
    microMenu = true,

    borderArt = true,
    backgroundArt = true,

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
}

local defaultsPC = {
}

ns.database.Register(defaults, defaultsPC)
