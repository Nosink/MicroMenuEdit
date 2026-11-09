local name, ns = ...

local L = ns.L


SLASH_MICROMENUEDIT1 = "/micromenuedit"
SLASH_MICROMENUEDIT2 = "/mme"

local function openSettings()
    if not Settings or not Settings.OpenToCategory or not ns.settingsCategory then
        return
    end

    if InCombatLockdown() then
        ns.settingsOpenPending = true
        return
    end

    Settings.OpenToCategory(ns.settingsCategory:GetID())
end

ns.bus:RegisterEvent("PLAYER_REGEN_ENABLED", function()
    if ns.settingsOpenPending then
        ns.settingsOpenPending = nil
        openSettings()
    end
end)

local function displayCommandHelp()
    print(string.format(
        "|c%s%s:|r %s |cff00ff00" ..
        SLASH_MICROMENUEDIT1 .. " |r %s |cff00ff00" .. SLASH_MICROMENUEDIT2 .. "|r %s.",
        "ffffd200", name, L["COMMAND_USE"], L["COMMAND_OR"], L["COMMAND_DESCRIPTION"]))
end


local function getVersion()
    return C_AddOns.GetAddOnMetadata(name, "Version")
end

SlashCmdList.MICROMENUEDIT = function(message)
    message = (message or ""):match("^%s*(.-)%s*$"):lower()

    if message == "" or message == "config" or message == "options" or message == "settings" then
        return openSettings()
    elseif (message == "v" or message == "version") then
        print(string.format("|c%s%s:|r %s %s", "ffffd200", name, L["COMMAND_VERSION"], getVersion()))
    else
        displayCommandHelp()
    end
end
