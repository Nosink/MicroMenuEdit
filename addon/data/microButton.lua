local name, ns = ...

local microButtonData = {}
microButtonData.__index = microButtonData

microButtonData.new = function(databaseKey, frame)
    local self = setmetatable({}, microButtonData)
    self.databaseKey = databaseKey
    self.frame = frame
    self.background = frame.Background
    self.portrait = frame.Portrait
    self.forceHide = true
    return self
end

ns.microButtonData = microButtonData
