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
microMenuSection:AddCheckBox(L["MICRO_MENU_HIDE_PERFORMANCE_BAR"], "performanceBar")

local function createButton(builder, parent, index)
    local button = CreateFrame("Button", nil, builder.optionsPanel, "MainMenuBarMicroButton")
    button:SetPoint("TOPLEFT", parent.anchor, "BOTTOMLEFT", (index - 1) * 31, -10)
    return button
end

local function setData(button, data)
    button.tooltip = data.tooltip
    button.databaseKey = data.databaseKey
    button.textureName = data.textureName
end

local function updatePortrait(button)
    if button.portrait then
        SetPortraitTexture(button.portrait, "player", true)
        button.portrait:Show()
    end
end

local function setTextures(button)
    if button.textureName == "Portrait" then
        button.portrait = button:CreateTexture(nil, "OVERLAY")
        button.portrait:SetAlpha(1.0)
        button.portrait:SetPoint("CENTER", button, "CENTER")
        button.portrait:SetSize(24, 24)
        button.portraitMask = button:CreateMaskTexture()
        button.portraitMask:SetPoint("CENTER", button, "CENTER")
        button.portraitMask:SetSize(31, 40)
        button.portraitMask:SetTexture("Interface\\Buttons\\UI-Panel-Button-Up")
        button.portrait:AddMaskTexture(button.portraitMask)
        updatePortrait(button)
    else
        LoadMicroButtonTextures(button, button.textureName)
    end
end

local portraitButton

local function setEvents(button)
    button:SetScript("OnClick", function(self)
        if not ns.db then return end
        self:UpdateState()
        ns.db[self.databaseKey] = not ns.db[self.databaseKey]
        ns.bus:TriggerEvent(name .. "_SETTINGS_CHANGED", self.databaseKey, ns.db[self.databaseKey])
    end)

    button:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:SetText(tostring(self.tooltip))
        GameTooltip:Show()
    end)

    button:SetScript("OnLeave", GameTooltip_Hide)
end

local function setStates(button)
    button.UpdateState = function(self)
        if not ns.db then return end
        local isVisible = ns.db[self.databaseKey]
        if isVisible then
            self:SetNormalState()
        else
            self:SetPushedState()
        end
    end

    button.SetNormalState = function(self)
        self:SetAlpha(1.0)
        self:SetNormal()
    end

    button.SetPushedState = function(self)
        self:SetAlpha(0.5)
        self:SetPushed()
    end
end

local function setFetch(button)
    button.Fetch = function(self)
        if not ns.db then return end
        self:UpdateState()
    end
end

local function createMicroMenuButton(index, data)
    local button = createButton(builder, microMenuSection, index)

    setData(button, data)
    setTextures(button)
    if button.textureName == "Portrait" then
        portraitButton = button
    end
    setEvents(button)
    setStates(button)
    setFetch(button)

    microMenuSection:AddFetch(button)
end

local sortedMicroButtons = {}
for _, data in pairs(enums.MicroButtons) do
    sortedMicroButtons[data.position] = data
end

for index, data in ipairs(sortedMicroButtons) do
    createMicroMenuButton(index, data)
end

local scaleSection = builder:CreateSection(L["LKEY_OPTIONS_SCALE_TITLE"],
    microMenuSection.anchor,
    ns.builder.offset(0, -60))
scaleSection:AddSlider(L["LKEY_OPTIONS_SCALE_SLIDER"], "scale",
    { values = { min = 0.6, max = 2, step = 0.1 }, width = 150 })

-- Register
builder:Register()

local function onShow()
    if not ns.db then return end
    builder:Fetch()
    updatePortrait(portraitButton)
end

ns.bus:HookScript(builder.optionsPanel, "OnShow", onShow)
ns.bus:RegisterEvent(name .. "_SETTINGS_CHANGED", onShow)
ns.bus:RegisterEvent(name .. "_VARIABLES_LOADED", onShow)
