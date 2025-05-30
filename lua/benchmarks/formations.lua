--**************************************************************************************************
--** Shared under the MIT license
--**************************************************************************************************

-- this benchmark depends on the file-function structure of lua/formations.lua and could break!

local CategorizeUnits = import("/lua/formations.lua").CategorizeUnits

local MathMod = math.mod

local TableInsert = table.insert
local TableGetn = table.getn

local CreateUnit = CreateUnit

local Timer = GetSystemTimeSecondsOnlyForProfileUse

ModuleName = "Formations"
BenchmarkData = {
    CategorizeUnitsTest = "CategorizeUnits",
}

local UnitsSelector = {
    [0] = "uaa0303", -- asf
    [1] = "xal0203", -- blaze
    [2] = "url0105", -- engineer
    [3] = "ura0401", -- soul ripper
    [4] = "uea0304", -- strat bomber
    [5] = "url0402", -- monkeylord
    [6] = "xsl0301", -- sacu
    -- excludes sea + sub units explicitly
}
local UnitsSelectorLength = TableGetn(UnitsSelector)
local UnitCount = 63

function CategorizeUnitsTest(loop)
    local units = {}
    for i = 1, UnitCount do
        TableInsert(units, CreateUnit(UnitsSelector[MathMod(i, UnitsSelectorLength)], 1, 0, 0, 0, 0, 0, 0, 0))
    end

    local start = Timer()

    for _ = 1, loop do
        CategorizeUnits(units)
    end

    local finish = Timer()

    for i = 1, TableGetn(units) do
        units[i]:Destroy()
        units[i] = nil
    end

    return finish - start
end
