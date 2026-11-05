local name, ns = ...

local frames = nil
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

local function onMicroButtonsLoaded(_, loadedFrames)
    frames = loadedFrames
    toggleMicroButtons()
end

ns.bus:RegisterEvent(name .. "_MICRO_BUTTONS_LOADED", onMicroButtonsLoaded)

local function onSettingsChanged(_, _)
    if not frames then return end
    toggleMicroButtons()
end

ns.bus:RegisterEvent(name .. "_SETTINGS_CHANGED", onSettingsChanged)
