require('game_cats.src.views.popups.win.ViewPopupTask')

ControllerPopupWin = classWithSuper(ControllerPopup, 'ControllerPopupWin')

--
-- Properties
--

function ControllerPopupWin.getType(self)
    return EPopupType.EPT_WIN
end

--
-- Methods
--


function ControllerPopupWin.init(self)
    
    local paramsView =
    {
        controller = self
    }
    
    local paramsController =
    {
        view = ViewPopupTask:new(paramsView)
    }
    
    ControllerPopup.init(self, paramsController)
    
   
end

function ControllerPopupWin.cleanup(self)
    self._view:cleanup(self)
    self._view = nil
    
    ControllerPopup.cleanup(self)
end

