local _, ns = ...

local builder = ns.builder

local settings = {}
settings.__index = settings

function settings:NewSettings(settings, anchor)
    settings = settings or {}

    local textSettings =
        ns.builder.settings.text:NewSettings({
            offset = { x = 0, y = -8 }
        }, anchor)

    local values = settings.values or {}

    local min = values.min or 0
    local max = values.max or 100
    local step = values.step or 1
    local obeyStepOnDrag = values.obeyStepOnDrag or true

    local offset = settings.offset or builder.offset(10)
    local point = settings.point or builder.point("TOPLEFT", anchor, "BOTTOMLEFT", offset.x, offset.y)

    local editBoxSettings =
        ns.builder.settings.editBox:NewSettings({
            allowDecimals = step < 1,
            isNumeric = true,
            validator = ns.builder.inRangeValidator(min, max),
            width = 45,
            height = 22,
            justify = ns.builder.justify("CENTER"),
        }, anchor)

    return setmetatable({
        textSettings = settings.textSettings or textSettings,
        offset = settings.offset or builder.offset(10),
        point = settings.point,
        editBoxSettings = settings.editBoxSettings or editBoxSettings,
        onValueChanged = settings.onValueChanged or function(_) end,
        values = {
            min = min,
            max = max,
            step = step,
            obeyStepOnDrag = obeyStepOnDrag,
        },
        width = settings.width or 100,
        frameType = settings.frameType or "Slider",
        template = settings.template or "OptionsSliderTemplate",

        SetAnchor = function(self, anchor)
            self.point = builder.point("LEFT", anchor, "RIGHT", self.offset.x, self.offset.y)
        end
    }, self)
end

ns.builder.settings = ns.builder.settings or {}
ns.builder.settings.slider = settings
