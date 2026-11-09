local _, ns = ...

local L = ns.L

ns.RegisterEnum("MicroButtons", {
    Character = {
        position = 1,
        tooltip = L["BUTTON_TOOLTIP_CHARACTER"],
        databaseKey = "characterInfo",
        textureName = "Portrait",
    },
    Profession = {
        position = 2,
        tooltip = L["BUTTON_TOOLTIP_PROFESSIONS"],
        databaseKey = "professions",
        textureName = "Professions"
    },
    Spellbook = {
        position = 3,
        tooltip = L["BUTTON_TOOLTIP_SPELLBOOK"],
        databaseKey = "spellbook",
        textureName = "SpellbookAbilities"
    },
    Talent = {
        position = 4,
        tooltip = L["BUTTON_TOOLTIP_TALENT"],
        databaseKey = "talents",
        textureName = "SpecTalents"
    },
    Legacy = {
        position = 5,
        tooltip = L["BUTTON_TOOLTIP_LEGACY"],
        databaseKey = "legacy",
        textureName = "Legacy"
    },
    QuestLog = {
        position = 6,
        tooltip = L["BUTTON_TOOLTIP_QUEST_LOG"],
        databaseKey = "questLog",
        textureName = "QuestLog"
    },
    Guild = {
        position = 7,
        tooltip = L["BUTTON_TOOLTIP_GUILD"],
        databaseKey = "guildAndInformation",
        textureName = "GuildCommunities"
    },
    LFD = {
        position = 8,
        tooltip = L["BUTTON_TOOLTIP_LFD"],
        databaseKey = "groupFinder",
        textureName = "Groupfinder"
    },
    Collections = {
        position = 9,
        tooltip = L["BUTTON_TOOLTIP_COLLECTIONS"],
        databaseKey = "accountCollections",
        textureName = "Collections"
    },
    Store = {
        position = 10,
        tooltip = L["BUTTON_TOOLTIP_STORE"],
        databaseKey = "shop",
        textureName = "Shop"
    },
    MainMenu = {
        position = 11,
        tooltip = L["BUTTON_TOOLTIP_MAINMENU"],
        databaseKey = "gameMenu",
        textureName = "GameMenu"
    },
})
