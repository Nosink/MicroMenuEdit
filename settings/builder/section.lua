local _, ns = ...

local section = {}
section.__index = section

function section:addControl(anchor, control)
    self.anchor = anchor
    self.builder.anchor = anchor
    self.builder:UpdateContentSize()
    self.controls[#self.controls + 1] = control
    return control
end

function section:AddFetch(fetch)
    self.controls[#self.controls + 1] = fetch
end

function section:AddCheckBox(text, key, settings)
    if not settings then settings = ns.builder.settings.checkBox:NewSettings({}, self.anchor) end
    return self:addControl(ns.builder.CreateCheckBox(self, text, key, settings))
end

function section:AddDropDown(text, key, options, settings)
    if not settings then settings = ns.builder.settings.dropDown:NewSettings({}, self.anchor) end
    return self:addControl(ns.builder.CreateDropDown(self, text, key, options, settings))
end

function section:AddText(text, settings)
    if not settings then settings = ns.builder.settings.text:NewSettings({}, self.anchor) end
    return self:addControl(ns.builder.CreateText(self, text, settings))
end

function section:AddEditBox(text, key, settings)
    if not settings then settings = ns.builder.settings.editBox:NewSettings({}, self.anchor) end
    return self:addControl(ns.builder.CreateEditBox(self, text, key, settings))
end

function section:AddSlider(text, key, settings)
    if not settings then settings = ns.builder.settings.slider:NewSettings({}, self.anchor) end
    return self:addControl(ns.builder.CreateSlider(self, text, key, settings))
end

function section:Fetch()
    for _, control in ipairs(self.controls) do
        if control.Fetch then control:Fetch() end
    end
end

function ns.builder:CreateSection(text, anchor, offset)
    local offset = offset or
        ns.builder.offset(0, -8)

    local title = self.optionsPanel.content:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", anchor or self.anchor, "BOTTOMLEFT", offset.x, offset.y)
    title:SetTextColor(1, 0.82, 0, 1)
    title:SetHeight(30)
    title:SetText(text)
    title:Show()

    local newSection = setmetatable({
        builder = self,
        optionsPanel = self.optionsPanel.content,
        anchor = title,
        controls = {},
    }, section)

    self.optionsPanel.sections[#self.optionsPanel.sections + 1] = newSection
    self.anchor = title
    return newSection
end
