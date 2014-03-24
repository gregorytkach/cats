--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:d04bbdf67e10031fa0a91bd0490c3c3d:1edf974b88529fe8e5fb4b95c3d6da7d:f831e6898c0fd91086524f46faeb2240$
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
            -- cat_01_4x
            x=82,
            y=224,
            width=78,
            height=70,

            sourceX = 11,
            sourceY = 10,
            sourceWidth = 100,
            sourceHeight = 80
        },
        {
            -- cat_02_4x
            x=172,
            y=222,
            width=80,
            height=70,

            sourceX = 10,
            sourceY = 10,
            sourceWidth = 100,
            sourceHeight = 80
        },
        {
            -- cat_03_4x
            x=172,
            y=150,
            width=82,
            height=70,

            sourceX = 9,
            sourceY = 10,
            sourceWidth = 100,
            sourceHeight = 80
        },
        {
            -- cat_04_4x
            x=2,
            y=148,
            width=84,
            height=70,

            sourceX = 9,
            sourceY = 10,
            sourceWidth = 100,
            sourceHeight = 80
        },
        {
            -- cat_05_4x
            x=88,
            y=150,
            width=82,
            height=72,

            sourceX = 10,
            sourceY = 7,
            sourceWidth = 100,
            sourceHeight = 80
        },
        {
            -- cat_06_4x
            x=98,
            y=76,
            width=88,
            height=72,

            sourceX = 6,
            sourceY = 5,
            sourceWidth = 100,
            sourceHeight = 80
        },
        {
            -- cat_07_4x
            x=104,
            y=2,
            width=98,
            height=72,

            sourceX = 0,
            sourceY = 3,
            sourceWidth = 100,
            sourceHeight = 80
        },
        {
            -- cat_08_4x
            x=2,
            y=2,
            width=100,
            height=70,

            sourceX = 0,
            sourceY = 3,
            sourceWidth = 100,
            sourceHeight = 80
        },
        {
            -- cat_09_4x
            x=2,
            y=74,
            width=94,
            height=72,

            sourceX = 2,
            sourceY = 4,
            sourceWidth = 100,
            sourceHeight = 80
        },
        {
            -- cat_10_4x
            x=2,
            y=220,
            width=78,
            height=72,

            sourceX = 11,
            sourceY = 6,
            sourceWidth = 100,
            sourceHeight = 80
        },
    },
    
    sheetContentWidth = 256,
    sheetContentHeight = 512
}

SheetInfo.frameIndex =
{

    ["cat_01_4x"] = 1,
    ["cat_02_4x"] = 2,
    ["cat_03_4x"] = 3,
    ["cat_04_4x"] = 4,
    ["cat_05_4x"] = 5,
    ["cat_06_4x"] = 6,
    ["cat_07_4x"] = 7,
    ["cat_08_4x"] = 8,
    ["cat_09_4x"] = 9,
    ["cat_10_4x"] = 10,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
