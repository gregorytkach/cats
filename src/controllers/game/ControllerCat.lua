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


function ControllerCat.onCreated(self, offsetY)
    
    local yOriginal = self._source.y
    
    self._source.y = self._source.y - offsetY
    
    local point =
    {
        x = self._source.x,
        y = yOriginal,
    }
    
    self._source:toBack()
    self:setPosition(point)
end


function ControllerCat.isInside(self, event)
    
    local isInsideHorizontal    = math.abs(event.x - self._source.x) < self._view:realWidth() * 0.5 
    local isInsideVertical      = math.abs(event.y - self._source.y) < self._view:realHeight() * 0.5
    
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
        
        if isInside  then
            
            local focusCat    =  self._managerGame:focusCat()
            if(focusCat == nil)then
                print('todo: fix bug')
            end
            
            local focusRow    = focusCat:row()
            local focusColumn = focusCat:column()
            
            local row    = self._entry:row()
            local column = self._entry:column()
            
            if (focusRow == row and focusColumn ~= column) or (focusRow ~= row and focusColumn == column) then
                
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
    self._cells         = self._managerGame:cells()
    
    self._enabled = true
    
end

function ControllerCat.update(self, updateType)
    
    
    if(updateType == EControllerUpdate.ECUT_CHANGE_POSITION)then 
        
        local row       = self._entry:row()
        local column    = self._entry:column()
        
        local cell      = self._cells[row][column]
        local cellView  = cell:controller():view():sourceView()
        
        self:setPosition(cellView)
        
    elseif(updateType == EControllerUpdate.ECUT_NEED_REMOVE)then 
        
        self._needRemove = true
        
    else
        assert(false)
    end
    
end

function ControllerCat.setPosition(self, point)
    
    local source = self._view:sourceView()
    
    ControllerCat._enabledTouches = false
    
    local tweenParams =
    {
        
        time        = Constants.CHANGE_CELL_TIME, --* (math.abs(source.x - point.x) / self._view:realWidth() + math.abs(source.y - point.y) / self._view:realHeight()) ,
        x           = point.x,
        y           = point.y,
        onComplete  = 
        function ()
            
            self._tweenMove = nil
            ControllerCat._enabledTouches = true
            
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