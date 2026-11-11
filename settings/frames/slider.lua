local name, ns = ...

local function setSettings(slider, settings)
    slider.settings = settings
end

local function createSlider(section, settings)
    local slider = CreateFrame(settings.frameType, nil, section.optionsPanel, settings.template)
    slider:SetPoint(settings.point.point, settings.point.relativeTo, settings.point.relativePoint, settings.point.x,
        settings.point.y)
    setSettings(slider, settings)
    return slider
end

local function setValues(slider)
    slider:SetMinMaxValues(slider.settings.values.min, slider.settings.values.max)
    slider:SetValueStep(slider.settings.values.step)
    slider:SetObeyStepOnDrag(slider.settings.values.obeyStepOnDrag)
end

local function setValuesText(slider)
    slider.Low:SetText(tostring(slider.settings.values.min))
    slider.High:SetText(tostring(slider.settings.values.max))
end

local function setWidth(slider)
    slider:SetWidth(slider.settings.width)
end

local function setEvents(slider, key)
    slider:SetScript("OnValueChanged", function(self, value)
        ns.db[key] = value
        if (self.settings.onValueChanged) then self.settings.onValueChanged(value) end
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
    setValues(slider)
    setValuesText(slider)
    setWidth(slider)
    setEvents(slider, key)
    setFetch(slider, key)

    --settings.editBoxSettings:SetOnValueChanged(function(text)
    --    local value = tonumber(text)
    --    ns.db[key] = value
    --    slider:SetValue(value)
    --    return true
    --end)

    --settings.editBoxSettings:SetAnchor(slider)
    --local editBox = ns.builder.CreateEditBox(section, "EL TEXTO DEL EDTIBOX?", key, settings.editBoxSettings)
    --linkEditBoxToSlider(slider, editBox)

    return label, slider
end
