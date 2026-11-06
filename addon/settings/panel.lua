local name, ns = ...

local L = ns.L

local enums = ns.enums
local builder = ns.builder

-- Frame
builder:CreateOptionsPanel()

-- Title
builder:CreateTitle(L["LKEY_OPTIONS_TITLE"])

-- Options
local microMenuSection = builder:CreateSection(L["OPTIONS_MICRO_MENU"])
microMenuSection:AddCheckBox(L["MICRO_MENU_BORDER_ART"], "background")

local anchor = microMenuSection.anchor
local optionButtons = {}

local function updateMicroMenuButton(button)
    if not ns.db then return end

    local enabled = ns.db[button.microMenuKey]
    button:SetAlpha(enabled and 1 or 0.5)
end

for index, textureName in ipairs(ns.microButtonOrder) do
    local key = ns.enums.MicroButtons[textureName]
    local button = CreateFrame("Button", nil, builder.optionsPanel, "MainMenuBarMicroButton")
    optionButtons[#optionButtons + 1] = button
    button.microMenuKey = key
    button.textureName = textureName
    button:SetSize(31, 40)
    button:SetPoint("TOPLEFT", microMenuSection.anchor, "BOTTOMLEFT", (index - 1) * 31, -10)
    button:SetScript("OnClick", function(self)
        if not ns.db then return end
        ns.db[self.microMenuKey] = not ns.db[self.microMenuKey]
        updateMicroMenuButton(self)
        ns.bus:TriggerEvent(name .. "_SETTINGS_CHANGED", self.microMenuKey, ns.db[self.microMenuKey])
    end)
    button:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:SetText(tostring(key))
        GameTooltip:Show()
    end)
    button:SetScript("OnLeave", GameTooltip_Hide)
    button.updateMicroMenuButton = updateMicroMenuButton
    updateMicroMenuButton(button)
end
microMenuSection:setAnchor(optionButtons[#optionButtons])

local scaleSection = builder:CreateSection(L["LKEY_OPTIONS_SCALE_TITLE"],
    anchor,
    ns.builder.offset(0, -60))
scaleSection:AddSlider(L["LKEY_OPTIONS_SCALE_SLIDER"], "scale", {
    values = { min = 0.6, max = 2, step = 0.1 }, width = 150
})

-- Register
builder:Register()

local function onShow()
    if not ns.db then return end
    builder:Fetch()
    for _, button in ipairs(optionButtons) do
        updateMicroMenuButton(button)
    end
end

ns.bus:HookScript(builder.optionsPanel, "OnShow", onShow)
ns.bus:RegisterEvent(name .. "_SETTINGS_CHANGED", onShow)
ns.bus:RegisterEvent(name .. "_VARIABLES_LOADED", onShow)
