local name, ns = ...

local microButtonData = {}
microButtonData.__index = microButtonData

microButtonData.new = function(databaseKey, frame)
    local self = setmetatable({}, microButtonData)
    self.frame = frame
    self.forceHide = true
    self.databaseKey = databaseKey
    return self
end

ns.microButtonData = microButtonData
