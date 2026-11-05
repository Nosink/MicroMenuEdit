local name, ns = ...

local frames = nil

local function toggleMicroButtons()
    if frames then return end

    for _, frame in ipairs(frames) do
        if frame then
            if frame.key and ns.db[frame.key] then
                frame:Show()
            else
                frame:Hide()
            end
        end
    end
end

local function onPlayerEnteringWorld()
    if frames then return end

    local characterMicroButton = _G["CharacterMicroButton"]
    characterMicroButton.key = "characterInfo"
    local professionsMicroButton = _G["SpellbookMicroButton"]
    professionsMicroButton.key = "professions"
    local spellbookMicroButton = _G["SpellbookMicroButton"]
    spellbookMicroButton.key = "spellbook"
    local talentsMicroButton = _G["TalentMicroButton"]
    talentsMicroButton.key = "talents"
    local questLogMicroButton = _G["QuestLogMicroButton"]
    questLogMicroButton.key = "questLog"
    local guildMicroButton = _G["GuildMicroButton"]
    guildMicroButton.key = "guildAndInformation"
    local lfgMicroButton = _G["LFDMicroButton"]
    lfgMicroButton.key = "groupFinder"
    local collectionsMicroButton = _G["CollectionsMicroButton"]
    collectionsMicroButton.key = "accountCollections"
    local shopMicroButton = _G["StoreMicroButton"]
    shopMicroButton.key = "shop"
    local gameMenuMicroButton = _G["MainMenuMicroButton"]
    gameMenuMicroButton.key = "gameMenu"

    frames = {
        characterMicroButton,
        professionsMicroButton,
        spellbookMicroButton,
        talentsMicroButton,
        questLogMicroButton,
        guildMicroButton,
        lfgMicroButton,
        collectionsMicroButton,
        shopMicroButton,
        gameMenuMicroButton
    }

    toggleMicroButtons()
end

ns.bus:RegisterEvent(name .. "_PLAYER_ENTERING_WORLD", onPlayerEnteringWorld)

local function onSettingsChanged(_, _)
    if not frames then return end

    toggleMicroButtons()
end

ns.bus:RegisterEvent(name .. "_SETTINGS_CHANGED", onSettingsChanged)
