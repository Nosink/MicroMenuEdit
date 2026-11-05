local name, ns = ...

local function onVariablesLoaded()
    local borderArt = _G["MicroMenu"].BorderArt
    borderArt.key = "borderArt"
    local backgroundArt = _G["MicroMenu"].BackgroundArt
    backgroundArt.key = "backgroundArt"
    local characterMicroButton = _G["CharacterMicroButton"]
    characterMicroButton.key = "characterInfo"
    local professionsMicroButton = _G["ProfessionMicroButton"]
    professionsMicroButton.key = "professions"
    local spellbookMicroButton = _G["SpellbookMicroButton"]
    spellbookMicroButton.key = "spellbook"
    local talentsMicroButton = _G["TalentMicroButton"]
    talentsMicroButton.key = "talents"
    local questLogMicroButton = _G["QuestLogMicroButton"]
    questLogMicroButton.key = "questLog"
    local guildMicroButton = _G["GuildMicroButton"]
    guildMicroButton.key = "guildAndInformation"
    local legacyMicroButton = _G["LegacyMicroButton"]
    legacyMicroButton.key = "legacy"
    local lfgMicroButton = _G["LFDMicroButton"]
    lfgMicroButton.key = "groupFinder"
    local collectionsMicroButton = _G["CollectionsMicroButton"]
    collectionsMicroButton.key = "accountCollections"
    local shopMicroButton = _G["StoreMicroButton"]
    shopMicroButton.key = "shop"
    local gameMenuMicroButton = _G["MainMenuMicroButton"]
    gameMenuMicroButton.key = "gameMenu"

    local frames = {
        borderArt,
        backgroundArt,
        characterMicroButton,
        professionsMicroButton,
        spellbookMicroButton,
        talentsMicroButton,
        questLogMicroButton,
        guildMicroButton,
        legacyMicroButton,
        lfgMicroButton,
        collectionsMicroButton,
        shopMicroButton,
        gameMenuMicroButton
    }

    ns.bus:TriggerEvent(name .. "_MICRO_BUTTONS_LOADED", frames)
end

ns.bus:RegisterEvent(name .. "_VARIABLES_LOADED", onVariablesLoaded)
