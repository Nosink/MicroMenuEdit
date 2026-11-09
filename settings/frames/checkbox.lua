local name, ns = ...

local function createCheckBox(section, settings)
    local point = settings and settings.point or
        ns.builder.point("TOPLEFT", section.anchor, "BOTTOMLEFT", settings.offset.x, settings.offset.y)

    local checkBox = CreateFrame("CheckButton", nil, section.optionsPanel, "InterfaceOptionsCheckButtonTemplate")
    local fontString = checkBox:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    checkBox:SetPoint(point.point, point.relativeTo, point.relativePoint, point.x, point.y)
    return checkBox
end

local function setText(checkBox, text, settings)
    local point = settings and settings.textPoint or
        ns.builder.point("LEFT", checkBox, "RIGHT", 4)
    local color = settings and settings.textColor or
        ns.builder.color(1, 1, 1, 1)
    local size = settings and settings.size or
        12

    local file, _, flags = checkBox.Text:GetFont()
    checkBox.Text:SetPoint(point.point, point.relativeTo, point.relativePoint, point.x, point.y)
    checkBox.Text:SetFont(tostring(file), size, flags)
    checkBox.Text:SetTextColor(color.r, color.g, color.b, color.a)
    checkBox.Text:SetText(text)
end

local function triggerSettingsChanged(key, value)
    ns.db[key] = value
    ns.bus:TriggerEvent(name .. "_SETTINGS_CHANGED", key)
end

local function setOnClick(checkBox, key)
    checkBox:SetScript("OnClick", function(self)
        local value = self:GetChecked() or false
        triggerSettingsChanged(key, value)
    end)
end

local function setFetch(checkBox, key)
    checkBox.Fetch = function(self)
        self:SetChecked(ns.db[key] or false)
    end
end

function ns.builder.CreateCheckBox(section, text, key, settings)
    local checkBox = createCheckBox(section, settings)

    setText(checkBox, text, settings)
    setOnClick(checkBox, key)
    setFetch(checkBox, key)

    return checkBox, checkBox
end
