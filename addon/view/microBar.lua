local name, ns = ...

local frames = nil

local function getMicroMenuFrame()
    return _G["MicroMenu"]
end

local function toggleMicroButtons()
    if not frames then return end

    for _, button in ipairs(frames) do
        local frame = button.frame
        if button.forceHide then
            ns.bus:HookScript(frame, "OnShow", function(self)
                if ns.db[button.databaseKey] then
                    self:Show()
                else
                    self:Hide()
                end
            end)
        end
        if ns.db[button.databaseKey] then
            frame:Show()
        else
            frame:Hide()
        end
    end
end

local function setScale()
    local frame = getMicroMenuFrame()
    print(frame:GetScale())
    print(ns.db.scale)
    frame:SetScale(tonumber(ns.db.scale))
    print(frame:GetScale())
end

local function onMicroButtonsLoaded(_, loadedFrames)
    frames = loadedFrames
    toggleMicroButtons()
    setScale()
end

ns.bus:RegisterEvent(name .. "_MICRO_BUTTONS_LOADED", onMicroButtonsLoaded)

local function onSettingsChanged(_, key)
    if not frames then return end
    if (key == "scale") then
        setScale()
    else
        toggleMicroButtons()
    end
end

ns.bus:RegisterEvent(name .. "_SETTINGS_CHANGED", onSettingsChanged)
