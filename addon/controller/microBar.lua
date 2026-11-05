local name, ns = ...

local initialized = false

local function onMicroButtonsLoaded(_, frames)
    if initialized then return end

    for _, frame in ipairs(frames) do
        --frame:SetScript("OnShow", function(self)
        --    if ns.db[frame.key] then
        --        frame:Show()
        --    else
        --        frame:Hide()
        --    end
        --end)
    end

    initialized = true
    ns.bus:TriggerEvent(name .. "_REQUEST_MICRO_BUTTONS_FRIST_SET", frames)
end

ns.bus:RegisterEvent(name .. "_MICRO_BUTTONS_LOADED", onMicroButtonsLoaded)
