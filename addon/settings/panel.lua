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
    button.stop:SetShown(not enabled)
    if (not enabled) then button:SetPushed() else button:SetNormal() end
end

local function createMicroMenuButton(index, data)
    local button = CreateFrame("Button", nil, builder.optionsPanel, "MainMenuBarMicroButton")

    button.stop = button:CreateTexture("stop", "OVERLAY")
    button.stop:SetTexture("Interface\\Buttons\\UI-GroupLoot-Pass-Up")
    button.stop:SetBlendMode("BLEND")
    button.stop:SetAlpha(0.5)
    button.stop:SetPoint("CENTER", button, "CENTER", 0, 0)
    button.stop:SetSize(28, 28)
    button.stop:Hide()

    optionButtons[#optionButtons + 1] = button
    button.data = data
    button.microMenuKey = data.databaseKey
    button.textureName = data.textureName
    if data.textureName == "Portrait" then
        SetPortraitTexture(button, "player")
    else
        LoadMicroButtonTextures(button, data.textureName)
    end

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
        GameTooltip:SetText(tostring(self.data.tooltip))
        GameTooltip:Show()
    end)
    button:SetScript("OnLeave", GameTooltip_Hide)
    button.updateMicroMenuButton = updateMicroMenuButton
    updateMicroMenuButton(button)
end

local sortedButtons = {}
for _, data in pairs(enums.MicroButtons) do
    sortedButtons[data.position] = data
end

for index, data in ipairs(sortedButtons) do
    createMicroMenuButton(index, data)
end

local scaleSection = builder:CreateSection(L["LKEY_OPTIONS_SCALE_TITLE"], anchor, ns.builder.offset(0, -60))
scaleSection:AddSlider(L["LKEY_OPTIONS_SCALE_SLIDER"], "scale",
    { values = { min = 0.6, max = 2, step = 0.1 }, width = 150 })

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
