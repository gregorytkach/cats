require('game_cats.src.views.map.ViewStateMap')
require('game_cats.src.controllers.map.ControllerMapItem')

ControllerStateMap = classWithSuper(Controller, 'ControllerStateMap')

--
-- Properties
--

--
--Events
--
function ControllerStateMap.onViewClicked(self, target, event)
    local result = Controller.onViewClicked(self, target, event)
    
    if(not result)then
        
    end
    
    return result
end
--
-- Methods
--
function ControllerStateMap.init(self)
    
    local paramsView = 
    {
        controller = self
    }
    
    local paramsController = 
    {
        view = ViewStateMap:new(paramsView)
    }
    
    Controller.init(self, paramsController)
    
    self._items = {}
    
    local levelContainer        = GameInfo:instance():managerLevels():levelContainers()[1]
    local levels                = levelContainer:levels()
    
    local currentLevel          = levelContainer:firstIncompleteLevel()
    
    for i, level in ipairs(levels)do
        
        local paramsController = 
        {
            entry       = level,
            isCurrent   = currentLevel == level
        }
        
        local controller = ControllerMapItem:new(paramsController)
        
        table.insert(self._items, controller)
        
        self._view:viewItems():addItem(controller:view())
    end
end

function ControllerStateMap.update(self, updateType)
    
    
end

function ControllerStateMap.cleanup(self)
    self._view:cleanup()
    self._view = nil
    
    Controller.cleanup(self)
end


