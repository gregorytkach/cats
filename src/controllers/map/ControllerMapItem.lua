require('game_cats.src.views.map.ViewMapItem')
ControllerMapItem = classWithSuper(Controller, 'ControllerMapItem')

--
-- Properties
--

--
--Events
--

function ControllerMapItem.onViewClicked(self, target, event)
    local result = Controller.onViewClicked(self, target, event)
    
    if(not result)then
        if(target == self._view:button())then
            local paramsGame = 
            {
                currentLevel = self._entry
            }
            
            GameInfoBase:instance():onGameStart(ManagerGame:new(paramsGame))
            GameInfoBase:instance():managerStates():setState(EStateType.EST_GAME)
        end
    end
    
    return result
end

--
-- Methods
--
function ControllerMapItem.init(self, params)
    
    assert(params.entry         ~= nil)
    assert(params.isCurrent     ~= nil)
    
    self._isCurrent = params.isCurrent
    
    local paramsView = 
    {
        controller = self
    }
    
    local paramsController = 
    {
        view = ViewMapItem:new(paramsView)
    }
    
    Controller.init(self, paramsController)
    
    self._entry = params.entry
    
    if(self._isCurrent)then
        --todo: implement animation
    elseif(not self._entry:progress():isComplete())then
        self._view:button():setIsEnabled(false)
    end
end

function ControllerMapItem.update(self, updateType)
    
    
end

function ControllerMapItem.cleanup(self)
    self._view:cleanup()
    self._view = nil
    
    Controller.cleanup(self)
end


