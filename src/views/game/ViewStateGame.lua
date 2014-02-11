
ViewStateGame = classWithSuper(ViewStateBase, 'ViewStateGame')


--
--Properties
--
function ViewStateGame.setViewGrid(self, value)
    
    assert(value ~= nil)
    
    self._viewGrid = value
    
    self._sourceView:insert(value:sourceView())
    
end


function ViewStateGame.getType(self)
    return EStateType.EST_GAME 
end

--
--Methods
--



function ViewStateGame.init(self, params)
    ViewStateBase.init(self, params)
    
    
    local bgParams =
    {
        image       = GameInfo:instance():managerResources():getStateBackground(self:getType()),
        scale   = EScaleType.EST_FILL_HEIGHT,
        controller  = self,
    }
    
    self._background = ViewSprite:new(bgParams)
    self._sourceView:insert(self._background:sourceView())
    --todo:implement
    -- self._viewStubs = ViewStubs:new(params)
    -- self._sourceView:insert(self._viewStubs:sourceView())
    
end

function ViewStateGame.placeViews(self)
    ViewStateBase.placeViews(self)
    
    self._viewGrid:placeViews()
    self._viewGrid:sourceView().x = display.contentCenterX
    self._viewGrid:sourceView().y = display.contentCenterY 
    
    --todo:implement
    -- self._viewStubs:sourceView().x = application.margin_right +  self._viewStubs:realWidth() / 2
    -- self._viewStubs:sourceView().y = application.margin_right +  self._viewStubs:realHeight() / 2
    
end

function ViewStateGame.cleanup(self)
    
    --todo:implement
    -- self._viewStubs:cleanup()
    -- self._viewStubs = nil
    
    ViewStateBase.cleanup(self)
end