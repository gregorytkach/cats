require('game_cats.src.views.game.ViewProgress')
ControllerProgress = classWithSuper(Controller, 'ControllerProgress')

--
-- Properties
--

--
--Events
--
function ControllerProgress.onViewClicked(self, target, event)
    local result = Controller.onViewClicked(self, target, event)
    
    if(not result)then
        
    end
    
    return result
end
--
-- Methods
--
function ControllerProgress.init(self)
    
    local paramsView = 
    {
        controller = self
    }
    
    local paramsController = 
    {
        view = ViewProgress:new(paramsView)
    }
    
    Controller.init(self, paramsController)
end

function ControllerProgress.update(self, updateType)
    
    if(updateType == EControllerUpdateBase.ECUT_SCENE_ENTER)then
    elseif(updateType == EControllerUpdate.ECUT_SCORES)then
        
        local scores = GameInfo:instance():managerGame():scores()
        self:view():progressSize(scores / Constants.MAX_SCORES_COUNT)
        
    else
        assert(false)
    end
    
end

function ControllerProgress.cleanup(self)
    
    self._view:cleanup()
    self._view = nil
    
    Controller.cleanup(self)
end


