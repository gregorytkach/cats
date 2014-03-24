--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:9245ca4811e19b03243d31a5d4abedec:98f9f7c56517cd655d97a24c22c03a8d:f831e6898c0fd91086524f46faeb2240$
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
            -- dog_01
            x=650,
            y=248,
            width=606,
            height=234,

            sourceX = 0,
            sourceY = 36,
            sourceWidth = 700,
            sourceHeight = 270
        },
        {
            -- dog_02
            x=670,
            y=2,
            width=616,
            height=232,

            sourceX = 4,
            sourceY = 38,
            sourceWidth = 700,
            sourceHeight = 270
        },
        {
            -- dog_03
            x=1256,
            y=484,
            width=626,
            height=230,

            sourceX = 8,
            sourceY = 40,
            sourceWidth = 700,
            sourceHeight = 270
        },
        {
            -- dog_04
            x=686,
            y=730,
            width=638,
            height=230,

            sourceX = 12,
            sourceY = 40,
            sourceWidth = 700,
            sourceHeight = 270
        },
        {
            -- dog_05
            x=1258,
            y=236,
            width=654,
            height=228,

            sourceX = 18,
            sourceY = 42,
            sourceWidth = 700,
            sourceHeight = 270
        },
        {
            -- dog_06
            x=2,
            y=734,
            width=682,
            height=236,

            sourceX = 11,
            sourceY = 34,
            sourceWidth = 700,
            sourceHeight = 270
        },
        {
            -- dog_07
            x=2,
            y=2,
            width=666,
            height=244,

            sourceX = 6,
            sourceY = 26,
            sourceWidth = 700,
            sourceHeight = 270
        },
        {
            -- dog_08
            x=2,
            y=248,
            width=646,
            height=242,

            sourceX = 4,
            sourceY = 28,
            sourceWidth = 700,
            sourceHeight = 270
        },
        {
            -- dog_09
            x=2,
            y=492,
            width=632,
            height=240,

            sourceX = 2,
            sourceY = 30,
            sourceWidth = 700,
            sourceHeight = 270
        },
        {
            -- dog_10
            x=636,
            y=492,
            width=618,
            height=236,

            sourceX = 2,
            sourceY = 34,
            sourceWidth = 700,
            sourceHeight = 270
        },
    },
    
    sheetContentWidth = 2048,
    sheetContentHeight = 1024
}

SheetInfo.frameIndex =
{

    ["dog_01"] = 1,
    ["dog_02"] = 2,
    ["dog_03"] = 3,
    ["dog_04"] = 4,
    ["dog_05"] = 5,
    ["dog_06"] = 6,
    ["dog_07"] = 7,
    ["dog_08"] = 8,
    ["dog_09"] = 9,
    ["dog_10"] = 10,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
