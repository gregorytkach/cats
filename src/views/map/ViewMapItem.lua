ViewMapItem = classWithSuper(ViewBase, 'ViewMapItem')

--
-- Events
--

function ViewMapItem.touch(self, event)
    if(event.phase == ETouchEvent.ETE_BEGAN)  then
        
        self._x = event.x
        self._y = event.y
        
    elseif(event.phase == ETouchEvent.ETE_MOVED)  then
        
        if self._x == nil then
            self._x = event.x
            self._y = event.y
        end
        
        self._sourceView.x = self._sourceView.x + event.x - self._x
        self._sourceView.y = self._sourceView.y + event.y - self._y
        
        self._x = event.x
        self._y = event.y
        
    elseif(event.phase == ETouchEvent.ETE_ENDED)  then
        
        print(self._sourceView.x..' '..self._sourceView.y)
        
    end
end

--
-- Properties
--

function ViewMapItem.button(self)
    return self._button
end

--
-- Methods
--

function ViewMapItem.init(self, params)
    ViewBase.init(self, params)
    
    assert(params.stars_count ~= nil)
    
    self._sourceView = display.newGroup()
    
    local managerResources = GameInfoBase:instance():managerResources()
    
    self._button = self:createButton(managerResources:getAsButton(EResourceType.ERT_STATE_MAP_BUTTON_ITEM))
    
    self._viewStars = {}
    
    local i = 0
    while i < params.stars_count do
        
        local viewStar = self:createSprite(managerResources:getAsImage(EResourceType.ERT_STATE_MAP_ICON_STAR))
        
        table.insert(self._viewStars, viewStar) 
--        viewStar.isVisible = false
        
        i = i + 1
    end
-- todo: for change position
--    self._circle = display.newCircle(0, 0, self._button:realWidth() / 2)
--    self._sourceView:insert(self._circle)
--    self._circle:addEventListener('touch', self)
--    self._button:sourceView().isVisible = false
end

function ViewMapItem.animateIcon(self, delay)
    local targetSource = self._sourceView
    
    local time = application.animation_duration
    
    local paramsTweenDown =
    {
        y           = targetSource.y,
        time        = time,
        onComplete  = 
        function() 
            self._tweenIcon = nil  
        end
    }
    
    local paramsTweenUp = 
    {
        y          = targetSource.y - 10,
        delay      = delay,
        time       = time,
        onComplete = 
        function() 
            self._tweenIcon = nil  
            
            self._tweenIcon = transition.to(targetSource, paramsTweenDown)
        end
    }
    
    self._tweenIcon = transition.to(targetSource, paramsTweenUp)
end

function ViewMapItem.placeViews(self)
    ViewBase.placeViews(self)
    
    local starsoffsetY = 10
    local starsOffsetX = 10
    
    if(#self._viewStars == 0)then
        
        --do nothing
        
    elseif(#self._viewStars == 1)then
        
        self._viewStars[1]:sourceView().x = 0
        self._viewStars[1]:sourceView().y = starsoffsetY
        
    elseif(#self._viewStars == 2)then
        
        self._viewStars[1]:sourceView().x = starsOffsetX
        self._viewStars[1]:sourceView().y = starsoffsetY
        
        self._viewStars[2]:sourceView().x = -starsOffsetX
        self._viewStars[2]:sourceView().y = starsoffsetY
        
    elseif(#self._viewStars == 3)then
        
        self._viewStars[1]:sourceView().x = starsOffsetX
        self._viewStars[1]:sourceView().y = starsoffsetY
        
        self._viewStars[2]:sourceView().x = -starsOffsetX
        self._viewStars[2]:sourceView().y = starsoffsetY
        
        self._viewStars[3]:sourceView().x = 0
        self._viewStars[3]:sourceView().y = starsoffsetY + 5
        
    end
    
    self._button:sourceView().x = 0
    self._button:sourceView().y = 0
end

function ViewMapItem.getParamsTweenShow(self, time, callback)
    
    if(time == nil)then
        time = application.animation_duration * 2
    end
    
    local result = 
    {
        time        = time,
        xScale      = 1,
        yScale      = 1,
        transition  = GameInfo:instance():managerStates():easingProvider().easeOutBounce,
        onComplete  = 
        function()
            if(callback ~= nil)then
                callback()
            end
        end
    }
    
    return result
end

function ViewMapItem.getParamsTweenHide(self, time, callback)
    
    if(time == nil)then
        time = application.animation_duration * 2
    end
    
    local result = 
    {
        time        = time,
        xScale      = 0.01,
        yScale      = 0.01,
        transition  = GameInfo:instance():managerStates():easingProvider().easeInBounce,
        onComplete  = 
        function()
            if(callback ~= nil)then
                callback()
            end
        end
    }
    
    return result
end

function ViewMapItem.cleanup(self)
    
    for i, viewStar in ipairs(self._viewStars)do
        viewStar:cleanup() 
    end
    
    self._viewStars = nil
    
    self._button:cleanup()
    self._button = nil
    
    ViewBase.cleanup(self)
end



