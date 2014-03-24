ViewCat = classWithSuper(ViewBase, 'ViewCat')
--
--Properties
--

function ViewCat.getGroup(self)
    
    return self._group
    
end

function ViewCat.setGroup(self, group)
    
    assert(group ~= nil)
    
    self._group = group
    
end

--
--Methods
--



function ViewCat.init(self, params)
    
    assert(params.type  ~= nil)
    
    ViewBase.init(self, params)
    
    local managerResources = GameInfo:instance():managerResources()
    
    self._sourceView = display.newGroup()
    
    
    self._animation = managerResources:getAsAnimationWithParam(EResourceType.ERT_STATE_GAME_ANIMATION_CAT, params.type)
    self._sourceView:insert(self._animation)
    
    local frame = math.random(1,  self._animation.numFrames)
    
    self._animation:setFrame(frame)
    
    self._animation:play()
end


function ViewCat.cleanup(self)
    
    self._animation:removeSelf()
    self._animation = nil
    
    self._sourceView:removeSelf()
    self._sourceView = nil
    
    self._group = nil
    
    ViewBase.cleanup(self)
end