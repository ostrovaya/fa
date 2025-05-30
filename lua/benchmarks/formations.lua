--**************************************************************************************************
--** Shared under the MIT license
--**************************************************************************************************

-- this benchmark depends on the file-function structure of lua/formations.lua and could break!

local CategorizeUnits = import("/lua/formations.lua").CategorizeUnits
local GetColSpot = import("/lua/formations.lua").GetColSpot

local MathMod = math.mod

local TableInsert = table.insert
local TableGetn = table.getn

local CreateUnit = CreateUnit
local Timer = GetSystemTimeSecondsOnlyForProfileUse

ModuleName = "Formations"
BenchmarkData = {
    CategorizeUnitsTest = "CategorizeUnits",
    GetColSpotTest = "GetColSpot"
}

local UnitsSelector = {
    "ura0401", -- soul ripper
    "uaa0303", -- asf
    "xal0203", -- blaze
    "url0105", -- engineer
    "uea0304", -- strat bomber
    "url0402", -- monkeylord
    "xsl0301", -- sacu
    "ues0302", -- summit
    "xss0203", -- t1 sub
}
local UnitsSelectorLength = TableGetn(UnitsSelector)
local UnitCount = 63

-- GetColSpot has some pattern to its inputs
--   but that information is hidden under another layer of profiling
function GetColSpotTest(loop)
    local random = Random
    local nums = {}

    for k = 1, 1000 do
        TableInsert(nums, random(1,128))
    end

    local start = Timer()

    for k = 1, loop do
        GetColSpot(nums[MathMod(k, 128) + 1], nums[128 - MathMod(k, 128) + 1])
    end

    local finish = Timer()

    return finish - start
end

function CategorizeUnitsTest(loop)
    local units = {}
    
    for i = 1, UnitCount do
        TableInsert(units, CreateUnit(UnitsSelector[MathMod(i, UnitsSelectorLength) + 1], 1, 0, 0, 0, 0, 0, 0, 0))
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
