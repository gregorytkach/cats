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
--    while i < params.stars_count do
--        
--        local viewStar = self:createSprite(managerResources:getAsImage(EResourceType.ERT_STATE_MAP_ICON_STAR))
--        
--        table.insert(self._viewStars, viewStar) 
--        
--        i = i + 1
--    end
    self._circle = display.newCircle(0, 0, self._button:realHeight() / 2)
    
    --self._circle =
    self._button:sourceView().isVisible = false
    
    self._sourceView:insert(self._circle)
    self._circle:addEventListener('touch', self)
    
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

function ViewMapItem.cleanup(self)
    
    for i, viewStar in ipairs(self._viewStars)do
        viewStar:cleanup() 
    end
    
    self._viewStars = nil
    
    self._button:cleanup()
    self._button = nil
    
    ViewBase.cleanup(self)
end



