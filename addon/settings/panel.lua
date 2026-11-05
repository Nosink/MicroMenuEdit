local name, ns = ...

local L = ns.L

local builder = ns.builder

-- Frame
builder:CreateOptionsPanel()

-- Title
builder:CreateTitle(L["LKEY_OPTIONS_TITLE"])

-- Options
local microMenuSection = builder:CreateSection(L["OPTIONS_MICRO_MENU"])
microMenuSection:AddCheckBox(L["MICRO_MENU_CHARACTER"], "characterInfo")
microMenuSection:AddCheckBox(L["MICRO_MENU_PROFESSIONS"], "professions")
microMenuSection:AddCheckBox(L["MICRO_MENU_SPELLBOOK"], "spellbook")
microMenuSection:AddCheckBox(L["MICRO_MENU_TALENTS"], "talents")
microMenuSection:AddCheckBox(L["MICRO_MENU_QUEST_LOG"], "questLog")
microMenuSection:AddCheckBox(L["MICRO_MENU_GUILD_AND_INFORMATION"], "guildAndInformation")
microMenuSection:AddCheckBox(L["MICRO_MENU_GROUP_FINDER"], "groupFinder")
microMenuSection:AddCheckBox(L["MICRO_MENU_ACCOUNT_COLLECTIONS"], "accountCollections")
microMenuSection:AddCheckBox(L["MICRO_MENU_SHOP"], "shop")
microMenuSection:AddCheckBox(L["MICRO_MENU_GAME_MENU"], "gameMenu")

-- Register
builder:Register()

local function onShow()
    if not ns.db then return end
    builder:Fetch()
end

ns.bus:HookScript(builder.optionsPanel, "OnShow", onShow)
ns.bus:RegisterEvent(name .. "_SETTINGS_CHANGED", onShow)
ns.bus:RegisterEvent(name .. "_VARIABLES_LOADED", onShow)
