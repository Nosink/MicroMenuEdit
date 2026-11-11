local name, ns = ...

local function createSlider(section, settings)
    local slider = CreateFrame(settings.frameType, nil, section.optionsPanel, settings.template)
    slider:SetPoint(settings.point.point, settings.point.relativeTo, settings.point.relativePoint, settings.point.x,
        settings.point.y)
    return slider
end

local function setValues(slider, settings)
    slider:SetMinMaxValues(settings.values.min, settings.values.max)
    slider:SetValueStep(settings.values.step)
    slider:SetObeyStepOnDrag(settings.values.obeyStepOnDrag)
end

local function setValuesText(slider, settings)
    slider.Low:SetText(tostring(settings.values.min))
    slider.High:SetText(tostring(settings.values.max))
end

local function setWidth(slider, settings)
    slider:SetWidth(settings.width)
end

local function setEvents(slider, key)
    slider:SetScript("OnValueChanged", function(self, value)
        ns.db[key] = value
        self:SetEditBoxText(value)
        ns.bus:TriggerEvent(name .. "_SETTINGS_CHANGED", key)
    end)
end

local function setFetch(slider, key)
    slider.Fetch = function(self)
        local value = ns.db[key]
        self:SetValue(value)
        self:SetEditBoxText(value)
    end
end

local function linkEditBoxToSlider(slider, editBox)
    slider.editBox = editBox
    slider.SetEditBoxText = function(self, value)
        local step = self:GetValueStep()
        local stepText = tostring(step)
        local decimalPoint = stepText:find("%.")

        if (decimalPoint) then
            value = string.format("%." .. decimalPoint .. "f", value)
        end
        self.editBox:SetText(value)
    end

    editBox.slider = slider
    editBox.SetSliderValue = function(self, value)
        self.slider:SetValue(value)
    end
end

function ns.builder.CreateSlider(section, text, key, settings)
    local _, label = ns.builder.CreateText(section, text, settings.textSettings)
    settings:SetAnchor(label)

    local slider = createSlider(section, settings)
    setValues(slider, settings)
    setValuesText(slider, settings)
    setWidth(slider, settings)
    setEvents(slider, key)
    setFetch(slider, key)

    settings:SetAnchor(slider)
    local editBox = ns.builder.CreateEditBoxFrame(section, key, settings.editBoxSettings, function(text)
        local value = tonumber(text)
        ns.db[key] = value
        slider:SetValue(value)
        return true
    end)
    linkEditBoxToSlider(slider, editBox)

    return label, slider
end
