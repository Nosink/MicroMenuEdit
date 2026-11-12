local _, ns = ...

local builder = ns.builder

local settings = {}
settings.__index = settings

function settings:NewSettings(settings, anchor)
    settings = settings or {}

    local offset = settings.offset or builder.offset(6, -2)
    local point = settings.point or builder.point("LEFT", anchor, "RIGHT", offset.x, offset.y)
    local textSettings =
        ns.builder.settings.text:NewSettings({
            offset = { x = 0, y = -8 }
        }, anchor)

    return setmetatable({
        textSettings = settings.textSettings or textSettings,
        offset = offset,
        width = settings.width or 50,
        point = point,
        template = settings.template or "UIDropDownMenuTemplate",
        onValueChanged = settings.onValueChanged or function(_) end,

        SetAnchor = function(self, anchor)
            self.point = builder.point("LEFT", anchor, "RIGHT", self.offset.x, self.offset.y)
        end
    }, self)
end

ns.builder.settings = ns.builder.settings or {}
ns.builder.settings.dropDown = settings
