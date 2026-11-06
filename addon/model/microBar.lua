local name, ns = ...

local enums = ns.enums
local microButtonData = ns.microButtonData

local function getMicroMenuFrame()
    return _G["MicroMenu"]
end

local function onVariablesLoaded()
    local microMenu = getMicroMenuFrame()

    local microButtons = {
        microButtonData.new("background", microMenu.BorderArt or {}),
        microButtonData.new("background", microMenu.BackgroundArt or {})
    }

    for identifier, databaseKey in pairs(enums.MicroButtons) do
        local microButton = _G[identifier .. "MicroButton"]
        table.insert(microButtons, microButtonData.new(databaseKey, microButton))
    end

    ns.bus:TriggerEvent(name .. "_MICRO_BUTTONS_LOADED", microButtons)
end

ns.bus:RegisterEvent(name .. "_VARIABLES_LOADED", onVariablesLoaded)
