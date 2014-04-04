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

function ViewCat.setBomb(self, isRow)
    
    assert(isRow ~= nil)
    self._isRow = isRow
    
    
    if isRow then
        self._sourceView:rotate(90)
    else
        self._sourceView.alpha = 0.35
    end
    
    
end

function ViewCat.init(self, params)
    
    assert(params.type  ~= nil)
    
    ViewBase.init(self, params)
    
    local managerResources = GameInfo:instance():managerResources()
    
    self._sourceView = display.newGroup()
    
    if params.type == ECatType.ECT_COLOR_BOMB then
                
        self._animation = self:createSprite(managerResources:getAsImage(EResourceType.ERT_STATE_GAME_COLOR_BOMB))
        self._sourceView:insert(self._animation:sourceView())
        self._isView = true
        self._animation:sourceView():scale(0.3, 0.3)
        
    else
        
        self._animation = managerResources:getAsAnimationWithParam(EResourceType.ERT_STATE_GAME_ANIMATION_CAT, params.type)
 
        local frame = math.random(1,  self._animation.numFrames)

        self._animation:setFrame(frame)

        self._animation:play()
        self._sourceView:insert(self._animation)
    end
    
    self._sourceView.isVisible = false
    
end


function ViewCat.cleanup(self)
    
    if self._isView then
    
        self._animation:cleanup()
        
    else
        
        self._animation:removeSelf()
        
    end
    self._animation = nil
    
    
    self._sourceView:removeSelf()
    self._sourceView = nil
    
    self._group = nil
    
    ViewBase.cleanup(self)
end