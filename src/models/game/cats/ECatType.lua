ECatType =
{
    ["ECT_YELLOW"] = 0;
    ["ECT_RED"]    = 1;
    ["ECT_GREEN"]  = 2;
    ["ECT_BLUE"]   = 3;
    
    ["ECT_COUNT"]  = 4;
}

function ECatType.randomType()
    return math.random(ECatType.ECT_COUNT) - 1
end
