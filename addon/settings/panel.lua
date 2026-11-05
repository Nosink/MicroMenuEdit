local name, ns = ...

local L = ns.L

local builder = ns.builder

-- Frame
builder:CreateOptionsPanel()

-- Title
builder:CreateTitle(L["LKEY_OPTIONS_TITLE"])

-- Options
local microMenuSection = builder:CreateSection(L["OPTIONS_MICRO_MENU"])
microMenuSection:AddCheckBox(L["MICRO_MENU_BORDER_ART"], "borderArt")
microMenuSection:AddCheckBox(L["MICRO_MENU_BACKGROUND_ART"], "backgroundArt")
microMenuSection:AddCheckBox(L["MICRO_MENU_CHARACTER"], "characterInfo")
microMenuSection:AddCheckBox(L["MICRO_MENU_PROFESSIONS"], "professions")
microMenuSection:AddCheckBox(L["MICRO_MENU_SPELLBOOK"], "spellbook")
microMenuSection:AddCheckBox(L["MICRO_MENU_TALENTS"], "talents")
microMenuSection:AddCheckBox(L["MICRO_MENU_QUEST_LOG"], "questLog")
microMenuSection:AddCheckBox(L["MICRO_MENU_LEGACY"], "legacy")
microMenuSection:AddCheckBox(L["MICRO_MENU_GUILD_AND_INFORMATION"], "guildAndInformation")
microMenuSection:AddCheckBox(L["MICRO_MENU_GROUP_FINDER"], "groupFinder")
microMenuSection:AddCheckBox(L["MICRO_MENU_ACCOUNT_COLLECTIONS"], "accountCollections")
microMenuSection:AddCheckBox(L["MICRO_MENU_SHOP"], "shop")
microMenuSection:AddCheckBox(L["MICRO_MENU_GAME_MENU"], "gameMenu")

local fadeSection = builder:CreateSection(L["LKEY_OPTIONS_FADE_TITLE"])
fadeSection:AddCheckBox(L["LKEY_OPTIONS_FADE_CB"], "fade")
fadeSection:AddEditBox(L["LKEY_OPTIONS_FADE_DURATION_EB"], "fadeDuration",
    builder.settings.editBox:NewSettings({
        width = 50, isNumeric = true, allowDecimals = true, validator = builder.inRangeValidator(0, 5)
    }, fadeSection.anchor))
fadeSection:AddSlider(L["LKEY_OPTIONS_FADE_OUT_OPACITY_SLIDER"], "fadeOutOpacity", {
    values = { min = 0, max = 1, step = 0.01 }, width = 150
})
fadeSection:AddSlider(L["LKEY_OPTIONS_FADE_IN_OPACITY_SLIDER"], "fadeInOpacity", {
    values = { min = 0, max = 1, step = 0.01 }, width = 150
})

-- Register
builder:Register()

local function onShow()
    if not ns.db then return end
    builder:Fetch()
end

ns.bus:HookScript(builder.optionsPanel, "OnShow", onShow)
ns.bus:RegisterEvent(name .. "_SETTINGS_CHANGED", onShow)
ns.bus:RegisterEvent(name .. "_VARIABLES_LOADED", onShow)
