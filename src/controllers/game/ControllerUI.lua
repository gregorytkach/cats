require('game_cats.src.views.game.ViewUI')
require('game_cats.src.controllers.game.ControllerPurchases')
require('game_cats.src.controllers.game.ControllerProgress')


ControllerUI = classWithSuper(Controller, 'ControllerUI')

--
-- Properties
--

function ControllerUI.controllerProgress(self)
    
    return self._controllerProgress
    
end

--
--Events
--
function ControllerUI.onViewClicked(self, target, event)
    local result = Controller.onViewClicked(self, target, event)
    
    if(not result)then
        
        if(target == self._view:buttonExit())then
            
            GameInfo:instance():onGameEnd()
            GameInfo:instance():managerStates():setState(EStateType.EST_MAP)
            
        else
            assert(false)
        end
        
    end
    
    return result
end
--
-- Methods
--
function ControllerUI.init(self)
    local paramsView = 
    {
        controller = self
    }
    
    local paramsController = 
    {
        view = ViewUI:new(paramsView)
    }
    
    Controller.init(self, paramsController)
    
    self._managerGame = GameInfo:instance():managerGame()
    
    self._controllerPurchases = ControllerPurchases:new()
    self._view:setViewPurchases(self._controllerPurchases:view())
    
    
    self._controllerProgress = ControllerProgress:new()
    self._view:setViewProgress(self._controllerProgress:view())
    
    self:update(EControllerUpdate.ECUT_TURNS_COUNT)
end

function ControllerUI.update(self, updateType)
    
    if updateType == EControllerUpdateBase.ECUT_PLAYER_ENERGY then
        
    elseif(updateType == EControllerUpdate.ECUT_TURNS_COUNT)then
        
        self._view:setTurns(self._managerGame:turnsLeft())
        
    else
        assert(false)
    end
    
    
end

function ControllerUI.cleanup(self)
    
    self._view:cleanup()
    self._view = nil
    
    self._controllerPurchases:cleanup()
    self._controllerPurchases = nil
    
    Controller.cleanup(self)
end


