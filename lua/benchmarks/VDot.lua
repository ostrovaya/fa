---@diagnostic disable: deprecated
-- UpvaluedEngineVDotOnLocals
-- UpvaluedLuaVDotOnLocals

-- UpvaluedEngineVDotOnLocals 0.023129 +~- 0.001431
-- UpvaluedLuaVDotOnLocals    0.000429 +~- 0.000136

ModuleName = "VDot"

function UpvaluedEngineVDotOnLocals(loop)
    local ax = Random()*1000
    local ay = Random()*1000
    local az = Random()*1000
    local a = Vector(ax, ay, az)
    local bx = Random()*1000
    local by = Random()*1000
    local bz = Random()*1000
    local b = Vector(bx, by, bz)

    local VDot = VDot

    local start = GetSystemTimeSecondsOnlyForProfileUse()

    for k=1, loop do
        local dot = VDot(a, b)
    end

    return GetSystemTimeSecondsOnlyForProfileUse() - start
end

function UpvaluedLuaVDotOnLocals(loop)
    local ax = Random()*1000
    local ay = Random()*1000
    local az = Random()*1000

    local bx = Random()*1000
    local by = Random()*1000
    local bz = Random()*1000

    local start = GetSystemTimeSecondsOnlyForProfileUse()

    for k=1, loop do
        local dot = ax * bx + ay * by + az * bz
    end

    return GetSystemTimeSecondsOnlyForProfileUse() - start
end