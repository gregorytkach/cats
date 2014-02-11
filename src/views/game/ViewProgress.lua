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
    
--    self._viewProgressBar = self:createSprite(managerResources:getAsImage(EResourceType.ERT_STATE_GAME_PROGRESS_BAR))
--    self._sourceView:insert(self._viewProgressBar:sourceView())

    
    self._viewIconStars = {}
    
    self._viewIconStars[1] = self:createSprite(managerResources:getAsImage(EResourceType.ERT_STATE_GAME_ICON_STAR))
    self._viewIconStars[2] = self:createSprite(managerResources:getAsImage(EResourceType.ERT_STATE_GAME_ICON_STAR))
    self._viewIconStars[3] = self:createSprite(managerResources:getAsImage(EResourceType.ERT_STATE_GAME_ICON_STAR))
    
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
    
    ViewBase.placeViews(self)
       
end

function ViewProgress.cleanup(self)
    
    self._viewBackground:cleanup()
    self._viewBackground = nil
    
    for i = #self._viewIconStars, 1, -1 do
        
        local iconStar = self._viewIconStars[i]
        
        iconStar:cleanup()
        table.remove(self._viewIconStars, i)
        
    end
    
    
    ViewBase.cleanup(self)
    
end



