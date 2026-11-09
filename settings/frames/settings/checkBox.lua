local _, ns = ...

local builder = ns.builder

local settings = {}
settings.__index = settings

function settings:NewSettings(settings, anchor)
    settings = settings or {}

    local offset = settings.offset or builder.offset()
    local point = builder.point("TOPLEFT", anchor, "BOTTOMLEFT", offset.x, offset.y)

    local textSettings = settings.textSettings or
        ns.builder.settings.text:NewSettings({
            point = builder.point("LEFT", anchor, "RIGHT", 4, 0),
        }, anchor)

    return setmetatable({
        textSettings = settings.textSettings or textSettings,
        offset = offset,
        point = settings.point or point,
        frameType = "CheckButton",
        template = "InterfaceOptionsCheckButtonTemplate",

        SetAnchor = function(self, anchor)
            self.point = builder.point("LEFT", anchor, "RIGHT", self.offset.x, self.offset.y)
        end
    }, self)
end

ns.builder.settings = ns.builder.settings or {}
ns.builder.settings.checkBox = settings
