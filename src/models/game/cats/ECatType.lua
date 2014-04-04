ECatType =
{
    ["ECT_0"] = 0;
    ["ECT_1"]    = 1;
    ["ECT_2"]  = 2;
    ["ECT_3"]   = 3;
    
    ["ECT_COUNT"]  = 4;
    ["ECT_COLOR_BOMB"]  = 5;
    ["ECT_ROW_BOMB"]  = 6;
    ["ECT_COLUMN_BOMB"]  = 7;
}

function ECatType.randomType()
    return math.random(ECatType.ECT_COUNT) - 1
end
