--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:005cbc692a719126cab66e1004f7de81:2bb0a7051ce566d61b893602a8c953fc:f831e6898c0fd91086524f46faeb2240$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- idle_00_4x
            x=2,
            y=762,
            width=172,
            height=142,

            sourceX = 23,
            sourceY = 17,
            sourceWidth = 220,
            sourceHeight = 160
        },
        {
            -- idle_01_4x
            x=2,
            y=470,
            width=180,
            height=144,

            sourceX = 19,
            sourceY = 15,
            sourceWidth = 220,
            sourceHeight = 160
        },
        {
            -- idle_02_4x
            x=196,
            y=466,
            width=186,
            height=148,

            sourceX = 16,
            sourceY = 11,
            sourceWidth = 220,
            sourceHeight = 160
        },
        {
            -- idle_03_4x
            x=2,
            y=316,
            width=192,
            height=152,

            sourceX = 13,
            sourceY = 7,
            sourceWidth = 220,
            sourceHeight = 160
        },
        {
            -- idle_04_4x
            x=208,
            y=160,
            width=198,
            height=154,

            sourceX = 10,
            sourceY = 5,
            sourceWidth = 220,
            sourceHeight = 160
        },
        {
            -- idle_05_4x
            x=2,
            y=2,
            width=204,
            height=158,

            sourceX = 7,
            sourceY = 1,
            sourceWidth = 220,
            sourceHeight = 160
        },
        {
            -- idle_06_4x
            x=208,
            y=2,
            width=198,
            height=156,

            sourceX = 10,
            sourceY = 3,
            sourceWidth = 220,
            sourceHeight = 160
        },
        {
            -- idle_07_4x
            x=2,
            y=162,
            width=192,
            height=152,

            sourceX = 13,
            sourceY = 7,
            sourceWidth = 220,
            sourceHeight = 160
        },
        {
            -- idle_08_4x
            x=196,
            y=316,
            width=186,
            height=148,

            sourceX = 16,
            sourceY = 11,
            sourceWidth = 220,
            sourceHeight = 160
        },
        {
            -- idle_09_4x
            x=2,
            y=616,
            width=178,
            height=144,

            sourceX = 21,
            sourceY = 15,
            sourceWidth = 220,
            sourceHeight = 160
        },
    },
    
    sheetContentWidth = 512,
    sheetContentHeight = 1024
}

SheetInfo.frameIndex =
{

    ["idle_00_4x"] = 1,
    ["idle_01_4x"] = 2,
    ["idle_02_4x"] = 3,
    ["idle_03_4x"] = 4,
    ["idle_04_4x"] = 5,
    ["idle_05_4x"] = 6,
    ["idle_06_4x"] = 7,
    ["idle_07_4x"] = 8,
    ["idle_08_4x"] = 9,
    ["idle_09_4x"] = 10,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
