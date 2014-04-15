ViewProgress = classWithSuper(ViewBase, 'ViewProgress')

--
-- Properties
--


function ViewProgress.buttonBuy(self)
    return self._buttonBuy
end

--
-- Methods
--

function ViewProgress.init(self, params)
    
    ViewBase.init(self, params)
    
    self._sourceView = display.newGroup()
    
    local managerResources = GameInfo:instance():managerResources()
   
    self._viewBackground = self:createSprite(managerResources:getAsImage(EResourceType.ERT_STATE_GAME_VIEW_BACKGROUND))
    self._sourceView:insert(self._viewBackground:sourceView())
    
    self._viewProgressBar = self:createSprite(managerResources:getAsImage(EResourceType.ERT_STATE_GAME_PROGRESS_BAR))
    self._sourceView:insert(self._viewProgressBar:sourceView())
    self._viewProgressBar:sourceView().isVisible = false

    self._rectProgressBar = display.newRect(0, 0, self._viewProgressBar:realWidth(), self._viewProgressBar:realHeight() * 1.1)
    self._sourceView:insert(self._rectProgressBar)
    self._width = self._rectProgressBar.contentWidth 
    self._rectProgressBar:setFillColor(0, 0, 150)
    self._rectProgressBar.isVisible = false
    
    self._viewIconStars = {}
    
    self._viewIconStars[1] = self:createSprite(managerResources:getAsImage(EResourceType.ERT_STATE_GAME_ICON_STAR))
    self._viewIconStars[2] = self:createSprite(managerResources:getAsImage(EResourceType.ERT_STATE_GAME_ICON_STAR))
    self._viewIconStars[3] = self:createSprite(managerResources:getAsImage(EResourceType.ERT_STATE_GAME_ICON_STAR))
    
    self._partProgress = 0
    
end

function ViewProgress.placeViews(self)
    
    for i = #self._viewIconStars, 1, -1 do
        
        local iconStar = self._viewIconStars[i]
        
        iconStar:sourceView().y = - iconStar:realHeight() * 0.35
        
    end
    
    
    local offsetX = self._viewBackground:realWidth() * 0.34
    
    local positionX = - self._viewBackground:realWidth() * 0.35 * 0.95
    
    for i = 1, #self._viewIconStars, 1 do
                
        local iconStar = self._viewIconStars[i]
        iconStar:sourceView().x = positionX
        
        positionX = positionX + offsetX
        
    end
    
    local iconStar = self._viewIconStars[3]
    iconStar:sourceView().x = iconStar:sourceView().x + 0.1 * iconStar:realWidth()
    
    self._viewProgressBar:sourceView().y = self._viewBackground:realHeight() * 0.3
    self._rectProgressBar.y = self._viewProgressBar:sourceView().y
    
    ViewBase.placeViews(self)
       
end

function ViewProgress.progressSize(self, value)
    
    assert(value ~= nil)
    
    self:tryTweenProgressCleanup()
    
    local xScaleCoef = (1 - value) * self._width * self._scaleWidth / self._rectProgressBar.contentWidth 
    
    
    local tweenProgressParams =
    {
        xScale = xScaleCoef * self._rectProgressBar.xScale,
        time = math.abs(value - self._partProgress) * Constants.MAX_TIME_PROGRESS,
        x = self._viewProgressBar:realWidth() / self._scaleWidth * value / 2 ,
    }
    
    self._tweenProgress = transition.to(self._rectProgressBar, tweenProgressParams)
    self._rectProgressBar.isVisible = true
    self._viewProgressBar:sourceView().isVisible = true
    
    
    self._partProgress = value
    
end

function ViewProgress.tryTweenProgressCleanup(self)
    
    if self._tweenProgress ~= nil then
        
        transition.cancel(self._tweenProgress)
        self._tweenProgress = nil
        
    end
    
end

function ViewProgress.cleanup(self)
    
    self:tryTweenProgressCleanup()
    
    self._viewBackground:cleanup()
    self._viewBackground = nil
    
    for i = #self._viewIconStars, 1, -1 do
        
        local iconStar = self._viewIconStars[i]
        
        iconStar:cleanup()
        table.remove(self._viewIconStars, i)
        
    end
    
    
    ViewBase.cleanup(self)
    
end



