require('game_cats.src.controllers.map.ControllerUIMap')
require('game_cats.src.controllers.map.ControllerStateMap')

StateMap = classWithSuper(StateBase, 'StateMap')

--
--Properties
--
function StateMap.getType(self)
    return  EStateType.EST_MAP
end

--
--Events
--

--
-- Methods
--

--Default initializer
function StateMap.init(self)
    StateBase.init(self)
    
end

function StateMap.initLayerScene(self)
    StateBase.initLayerScene(self)
    
    self._controllerState = ControllerStateMap:new()
    self._layerScene:insert(self._controllerState:view():sourceView())
    
end

function StateMap.initLayerUI(self)
    StateBase.initLayerUI(self)
    
    self._controllerUI = ControllerUIMap:new()
    self._layerUI:insert(self._controllerUI:view():sourceView())
    
end

function StateMap.initLayerPopups(self)
    StateBase.initLayerPopups(self)
    
    self:registerPopup(ControllerPopupShop:new())
    
end

function StateMap.update(self, updateType)
    
    if(updateType == EControllerUpdateBase.ECUT_SCENE_ENTER)then
        
        self:showPopup(EPopupType.EPT_SHOP)
        
    elseif(updateType == EControllerUpdateBase.ECUT_SCENE_EXIT)then
        
        
    elseif(updateType == EControllerUpdateBase.ECUT_PLAYER_ENERGY)then
        --todo: update controller ui
        
        self._controllerUI:update(updateType)
    else
        assert(false)
    end
    
end


function StateMap.placeViews(self)
    StateBase.placeViews(self)
    
    self._controllerState:view():placeViews()
    
    self._controllerUI:view():placeViews()
    
    local popupWidthMax = (application.content.width - display.screenOriginX * 2) - 10
    
    self:setMaxPopupWidth(popupWidthMax)
end

function StateMap.cleanup(self)
    
    self._controllerState:cleanup()
    self._controllerState = nil
    
    self._controllerUI:cleanup()
    self._controllerUI = nil
    
    StateBase.cleanup(self)
end
