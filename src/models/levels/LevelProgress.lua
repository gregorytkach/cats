LevelProgress = classWithSuper(LevelProgressBase, 'LevelProgress')

--
-- Properties
--

function LevelProgress.starsCount(self)
    return self._starsCount
end

--
-- Methods
--

function LevelProgress.init(self)
end

function LevelProgress.cleanup(self)
    Object.cleanup(self)
end


function LevelProgress.deserialize(self, data)
    LevelProgressBase.deserialize(self, data)
    
    assert(data.stars_count ~= nil)
    
    self._starsCount    = data.stars_count
    
end
