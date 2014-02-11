require('game_cats.src.views.popups.pause.ViewPopupPause')

ControllerPopupPause = classWithSuper(ControllerPopup, 'ControllerPopupPause')

--
-- Properties
-- 

function ControllerPopupPause.getType(self)
    return EPopupType.EPT_PAUSE
end

--
-- Methods
--

function ControllerPopupPause.init(self)
    
    local paramsView =
    {
        controller = self
    }
    
    local paramsController =
    {
        view = ViewPopupPause:new(paramsView)
    }
    
    ControllerPopup.init(self, paramsController)
    
end

function ControllerPopupPause.cleanup(self)
    self._view:cleanup()
    self._view = nil
    
    ControllerPopup.cleanup(self)
end




