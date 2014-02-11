LevelInfo = classWithSuper(LevelInfoBase, 'LevelInfo')

--
--Properties
--

function LevelInfo.columns(self)
    return self._columns
end

function LevelInfo.rows(self)
    return self._rows
end

function LevelInfo.turnsLimit(self)
    return self._turnsLimit
end

function LevelInfo.starsCount(self)
    return self._starsCount
end

function LevelInfo.starPoints1(self)
    return self._starPoints1
end

function LevelInfo.starPoints2(self)
    return self._starPoints2
end

function LevelInfo.starPoints3(self)
    return self._starPoints3
end

--
--Methods
--


function LevelInfo.init(self)
    LevelInfoBase.init(self)
end

function LevelInfo.deserialize(self, data)
    LevelInfoBase.deserialize(self, data)
    
    assert(data.columns         ~= nil)
    assert(data.rows            ~= nil)
    
    assert(data.turns_limit     ~= nil)
    
    assert(data.stars_count     ~= nil)
    assert(data.star_points_1   ~= nil)
    assert(data.star_points_2   ~= nil)
    assert(data.star_points_3   ~= nil)
    
    self._rows          = data.rows
    self._columns       = data.columns
    
    self._turnsLimit    = data.turns_limit
    
    self._starsCount    = data.stars_count
    
    self._starPoints1   = data.star_points_1
    self._starPoints2   = data.star_points_2
    self._starPoints3   = data.star_points_3
    
end

