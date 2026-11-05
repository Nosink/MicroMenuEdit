local name, ns = ...

local frames = nil
local function toggleMicroButtons()
    if not frames then return end

    for _, frame in ipairs(frames) do
        if frame.forceHide then
            ns.bus:HookScript(frame, "OnShow", function(self)
                if ns.db[self.databaseKey] then
                    self:Show()
                else
                    self:Hide()
                end
            end)
        end
        if ns.db[frame.databaseKey] then
            frame:Show()
        else
            frame:Hide()
        end
    end
end

local function hookFadeEvents()
    if not frames then return end

    for _, frame in ipairs(frames) do
        ns.bus:HookScript(frame, "OnEnter", function(self)
            self:SetAlpha(ns.db.fadeInOpacity)
        end)
        ns.bus:HookScript(frame, "OnLeave", function(self)
            self:SetAlpha(ns.db.fadeOutOpacity)
        end)
    end
end

local function onMicroButtonsLoaded(_, loadedFrames)
    frames = loadedFrames
    toggleMicroButtons()
    hookFadeEvents()
end

ns.bus:RegisterEvent(name .. "_MICRO_BUTTONS_LOADED", onMicroButtonsLoaded)

local function onSettingsChanged(_, _)
    if not frames then return end
    toggleMicroButtons()
end

ns.bus:RegisterEvent(name .. "_SETTINGS_CHANGED", onSettingsChanged)
