local name, ns = ...

local BASE_DEFAULT_PADDING = 5

local frames = nil

local function setSingleShown(frame, button)
    frame:SetShown(ns.db[button.databaseKey])
end

local function hookOnShow()
    if not frames then return end
    for _, button in ipairs(frames) do
        ns.bus:HookScript(button.frame, "OnShow", function(self) setSingleShown(self, button) end)
    end
end

local function setShown()
    if not frames then return end
    for _, button in ipairs(frames) do
        setSingleShown(button.frame, button)
    end
end

local function getMicroMenuFrame()
    return _G["MicroMenu"]
end

local function setScale()
    local frame = getMicroMenuFrame()
    frame:SetNormalScale(ns.db.scale)
end

local function setPerformanceBarShown()
    local frame = _G["MainMenuMicroButton"]
    frame.MainMenuBarPerformanceBar:SetShown(ns.db.performanceBar)
end

local function updateFramePadding()
    local frame = getMicroMenuFrame()
    frame.childXPadding = ns.db.padding - BASE_DEFAULT_PADDING
    frame.childYPadding = ns.db.padding - BASE_DEFAULT_PADDING
    frame:MarkDirty()
    frame:UpdateScale()
end

local function onMicroButtonsLoaded(_, loadedFrames)
    frames = loadedFrames

    hookOnShow()
    setShown()
    setScale()
    setPerformanceBarShown()
    updateFramePadding()
end

ns.bus:RegisterEvent(name .. "_MICRO_BUTTONS_LOADED", onMicroButtonsLoaded)

local function onSettingsChanged(_, key)
    if not frames then return end
    if (key == "scale") then
        setScale()
    elseif (key == "performanceBar") then
        setPerformanceBarShown()
    elseif (key == "padding") then
        updateFramePadding()
    else
        setShown()
    end
end

ns.bus:RegisterEvent(name .. "_SETTINGS_CHANGED", onSettingsChanged)
