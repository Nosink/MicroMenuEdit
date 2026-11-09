local name, ns = ...

local function createCheckBox(section, settings)
    local checkBox = CreateFrame(settings.frameType, nil, section.optionsPanel, settings.template)
    checkBox:SetPoint(settings.point.point, settings.point.relativeTo, settings.point.relativePoint, settings.point.x,
        settings.point.y)
    return checkBox
end

local function triggerSettingsChanged(key, value)
    ns.db[key] = value
    ns.bus:TriggerEvent(name .. "_SETTINGS_CHANGED", key)
end

local function setOnClick(checkBox, key)
    checkBox:SetScript("OnClick", function(self)
        local value = self:GetChecked()
        triggerSettingsChanged(key, value)
    end)
end

local function setFetch(checkBox, key)
    checkBox.Fetch = function(self)
        self:SetChecked(ns.db[key])
    end
end

function ns.builder.CreateCheckBox(section, text, key, settings)
    local checkBox = createCheckBox(section, settings)
    settings.textSettings:SetAnchor(checkBox)

    ns.builder.ConfigureText(checkBox.Text, text, settings.textSettings)

    setOnClick(checkBox, key)
    setFetch(checkBox, key)

    return checkBox, checkBox
end
