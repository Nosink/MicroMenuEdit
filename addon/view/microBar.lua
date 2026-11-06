local name, ns = ...

local enums = ns.enums

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
    frame:SetScale(ns.db.scale)
end


local function setPerformanceBarShown()
    local frame = _G["MainMenuMicroButton"]
    frame.MainMenuBarPerformanceBar:SetShown(ns.db.performanceBar)
end

local function onMicroButtonsLoaded(_, loadedFrames)
    frames = loadedFrames

    hookOnShow()
    setShown()
    setScale()
    setPerformanceBarShown()
end

ns.bus:RegisterEvent(name .. "_MICRO_BUTTONS_LOADED", onMicroButtonsLoaded)

local function onSettingsChanged(_, key)
    if not frames then return end
    if (key == "scale") then
        setScale()
    elseif (key == "performanceBar") then
        setPerformanceBarShown()
    else
        setShown()
    end
end

ns.bus:RegisterEvent(name .. "_SETTINGS_CHANGED", onSettingsChanged)
