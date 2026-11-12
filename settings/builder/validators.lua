local _, ns = ...

function ns.builder.noValidator()
    return {
        validate = function(_) return true end,
        normalize = function(text) return text end
    }
end

function ns.builder.inRangeValidator(min, max)
    local function inValidFormat(number)
        local text = string.format("%.2f", number)
        text = text:gsub("0+$", "")
        return text:gsub("%.$", "")
    end

    return {
        validate = function(text)
            local number = tonumber(text)
            return number and number >= min and number <= max
        end,
        normalize = function(text)
            local number = tonumber(text)
            if not number then return inValidFormat(min) end
            if number < min then return inValidFormat(min) end
            if number > max then return inValidFormat(max) end
            return inValidFormat(number)
        end
    }
end
