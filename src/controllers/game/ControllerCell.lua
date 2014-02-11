require('game_cats.src.views.game.ViewCell')

ControllerCell = classWithSuper(Controller, 'ControllerCell')

--
--Properties
--

function ControllerCell.entry(self)
    return self._entry
end

--
--Events
--


--
--Methods
--



function ControllerCell.init(self, params)
    
    assert(params       ~= nil)
    assert(params.entry ~= nil)
    
    self._entry  = params.entry
    
    local paramsView = 
    {
        controller  = self,
        type        = self._entry:type(),
        default     = params.default
    }
    
    local paramsController = 
    {
        view = ViewCell:new(paramsView),
    }
    
    Controller.init(self, paramsController)
    
    self._managerGame = GameInfo:instance():managerGame()
end

function ControllerCell.update(self, updateType)
    
    if(updateType == EControllerUpdateBase.ECUT_SCENE_ENTER)then
        
    else
        assert(false)
    end
    
end

function ControllerCell.cleanup(self)
    
    self._managerGame = nil
    
    Controller.cleanup(self)
    
end
