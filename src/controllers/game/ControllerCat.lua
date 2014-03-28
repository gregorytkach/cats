require('game_cats.src.views.game.ViewCat')

ControllerCat = classWithSuper(Controller, 'ControllerCat')

--
--Static fields
--

ControllerCat._enabledTouches = true

--
--Properties
--

function ControllerCat.entry(self)
    return self._entry
end

function ControllerCat.needRemove(self)
    return self._needRemove
end

--
--Events
--


function ControllerCat.onCreated(self, offsetY, delay)
    
    local yOriginal = self._source.y
    
    self._source.y = self._source.y - offsetY
    
    local delay         =  delay
    local timeInterval  =  Constants.CHANGE_CELL_TIME / 2
    
    local tweenParams =
    {
        x           = self._source.x,
        y           = yOriginal,
        delay       = delay,
        time        = timeInterval,
        transition  = ControllerCat.easeOutBounce
    }
    
    self._source:toFront()
    self:setPosition(tweenParams)
    
end


function ControllerCat.isInside(self, event)
    
    local scaleWidth = self._stateGame:scaleWidth()
    
    local isInsideHorizontal    = math.abs(event.x - self._source.x * scaleWidth) < self._view:realWidth() * 0.5 * scaleWidth
    local isInsideVertical      = math.abs(event.y - self._source.y * scaleWidth) < self._view:realHeight() * 0.5 * scaleWidth
    
    return isInsideHorizontal and isInsideVertical
    
end

function ControllerCat.touch(self, event)
    
    local group = self._view:getGroup()
    
    local eventGroup = 
    {
        x = event.x - group.x,
        y = event.y - group.y
    }
    
    if(event.phase == ETouchEvent.ETE_BEGAN) and ControllerCat._enabledTouches then
        
        self._isInside = self:isInside(eventGroup)
        
        if self._isInside then
            
            self._managerGame:setFocusCat(self._entry)
            
        end
        
    elseif(event.phase == ETouchEvent.ETE_MOVED) and ControllerCat._enabledTouches then
        
        local isInside = self:isInside(eventGroup)
        local focusCat = self._managerGame:focusCat()
        
        if isInside and focusCat ~= nil  then
            
            local focusRow    = focusCat:row()
            local focusColumn = focusCat:column()
            
            local row    = self._entry:row()
            local column = self._entry:column()
            
            if (focusRow == row and math.abs(focusColumn - column) == 1) or (math.abs(focusRow - row) == 1 and focusColumn == column) then
                
                self._managerGame:tryChangeTo(self._entry) 
                
            end
            
        end
        
    elseif(event.phase == ETouchEvent.ETE_ENDED or event.phase == ETouchEvent.ETE_CANCELLED)then
        
        self._isInside = false
        
        if(self._managerGame:focusCat())then
            self._managerGame:setFocusCat(nil)
        end
        
    end
    
end


--
--Methods
--


function ControllerCat.init(self, params)
    
    assert(params       ~= nil)
    assert(params.entry ~= nil)
    
    self._entry  = params.entry
    
    self._entry:setController(self)
    
    local paramsView =
    {
        controller  = self,
        type        = self._entry:type()
    }
    
    local paramsController = 
    {
        view = ViewCat:new(paramsView),
    }
    
    Controller.init(self, paramsController)
    
    self._source        = self._view:sourceView()
    
    self._isInside      = false
    self._needRemove    = false
    
    
    --todo: addEventListener to group, not Runtime
    Runtime:addEventListener("touch", self)
    
    self._managerGame   = GameInfo:instance():managerGame()
    self._stateGame     = GameInfo:instance():managerStates():currentState()
    
    self._cells         = self._managerGame:cells()
    
    self._enabled = true
    
end

function ControllerCat.update(self, updateType)
    
    
    if(updateType == EControllerUpdate.ECUT_CHANGE_POSITION)then 
        
        local row       = self._entry:row()
        local column    = self._entry:column()
        
        local cell      = self._cells[row][column]
        local cellView  = cell:controller():view():sourceView()
        
        local tweenParams = 
        {
            delay   = 0,
            time    = Constants.CHANGE_CELL_TIME,
            x       = cellView.x,
            y       = cellView.y
        }
        
        self:setPosition(tweenParams)
        
    elseif(updateType == EControllerUpdate.ECUT_NEED_REMOVE)then 
        
        self._needRemove = true
        
    else
        assert(false)
    end
    
end

function ControllerCat.easeOutBounce(t, tMax, start, delta)
    return easing.linear(t, tMax, start, delta)
    --    return start + (delta * (t / tMax)) * (0.8 + 0.2 * t / tMax + 0.1 * math.sin((t - tMax) / 10))   -- ControllerCat.easeOutBounceRatio(t / tMax))
end

function ControllerCat.setPosition(self, tweenParams)
    
    local source = self._view:sourceView()
    
    if self._managerGame:timerPush() == nil then
        self._stateGame:block()
    end
    
    ControllerCat._enabledTouches = false
    
    local tweenParams =
    {
        delay       = tweenParams.delay,
        time        = tweenParams.time, --* (math.abs(source.x - point.x) / self._view:realWidth() + math.abs(source.y - point.y) / self._view:realHeight()) ,
        x           = tweenParams.x,
        y           = tweenParams.y,
        transition  = tweenParams.transition,
        onComplete  = 
        function ()
            
            self._tweenMove = nil
            
            if self._managerGame ~= nil and self._managerGame:timerPush() == nil  then
                self._stateGame:unblock()
            end
            
            ControllerCat._enabledTouches = true
            
            if self._managerGame ~= nil and self._entry:isLast() then
                
                self._managerGame:onCatsComplete()
                self._entry:setIsLast(false) 
                
            end
            
        end,
    }
    
    self._tweenMove = transition.to(source, tweenParams)  
    
end


function ControllerCat.cleanupTweenMove(self)
    
    if self._tweenMove ~= nil then
        transition.cancel(self._tweenMove)
        self._tweenMove = nil
    end
    
end


function ControllerCat.cleanup(self)
    
    self:cleanupTweenMove()
    
    Runtime:removeEventListener("touch", self)
    
    self._managerGame = nil
    self._group = nil
    
    self._view:cleanup()
    Controller.cleanup(self)
    
end
