local name, ns = ...

local enums = ns.enums
local microButtonData = ns.microButtonData

local function onVariablesLoaded()
    local microMenu = _G["MicroMenu"]

    local frames = {
        microButtonData.new("borderArt", microMenu.BorderArt),
        microButtonData.new("backgroundArt", microMenu.BackgroundArt)
    }

    for button, databaseKey in pairs(enums.MicroButtons) do
        local uiButton = _G[button .. "MicroButton"]
        uiButton.databaseKey = databaseKey
        table.insert(frames, microButtonData.new(databaseKey, uiButton))
    end

    ns.bus:TriggerEvent(name .. "_MICRO_BUTTONS_LOADED", frames)
end

ns.bus:RegisterEvent(name .. "_VARIABLES_LOADED", onVariablesLoaded)
