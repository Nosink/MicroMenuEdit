local name, ns = ...

local frames = nil
local function toggleMicroButtons()
    if not frames then return end

    for _, frame in ipairs(frames) do
        if ns.db[frame.key] then
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

ns.bus:RegisterEvent(name .. "_REQUEST_MICRO_BUTTONS_FRIST_SET", onMicroButtonsLoaded)

local function onSettingsChanged(_, _)
    if not frames then return end
    toggleMicroButtons()
end

ns.bus:RegisterEvent(name .. "_SETTINGS_CHANGED", onSettingsChanged)
