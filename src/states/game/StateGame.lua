require('game_cats.src.controllers.game.ControllerStateGame')
require('game_cats.src.controllers.game.ControllerUI')

StateGame = classWithSuper(StateBase, 'StateGame')

--
--Properties
--
function StateGame.getType(self)
    return  EStateType.EST_GAME
end

--
--Events
--

function StateGame.onCatCreated(self, cat)
    
    self._controllerState:controllerGrid():onCatCreated(cat)
    
end

--
-- Methods
--

--todo: use base methods
function StateGame.block(self)
    
    self._blockerPopups.alpha = 0.01
    
end

function StateGame.unblock(self)
    
    self._blockerPopups.alpha = 0
    
end


--Default initializer
function StateGame.init(self)
    StateBase.init(self)
    
    assert(GameInfo:instance():managerGame() ~= nil)
    
    self._managerGame = GameInfo:instance():managerGame()
    self._managerGame:registerCurrentState(self)
    
end

function StateGame.initLayerScene(self)
    StateBase.initLayerScene(self)
    
    self._controllerState = ControllerStateGame:new()
    self._layerScene:insert(self._controllerState:view():sourceView())
end

function StateGame.initLayerUI(self)
    StateBase.initLayerUI(self)
    
    
    self._controllerUI = ControllerUI:new()
    self._layerUI:insert(self._controllerUI:view():sourceView())
    
end

function StateGame.initLayerPopups(self)
    StateBase.initLayerPopups(self)
    
    self:registerPopup(ControllerPopupShop:new())
    self:registerPopup(ControllerPopupWin:new())
    self:registerPopup(ControllerPopupGameOver:new())
    self:registerPopup(ControllerPopupPause:new())
    
end

function StateGame.update(self, updateType)
    
    if(updateType == EControllerUpdateBase.ECUT_SCENE_ENTER)then
        
        self._managerGame:onGameStart()
        self._controllerState:controllerGrid():update(updateType)
        
    elseif(updateType == EControllerUpdateBase.ECUT_SCENE_EXIT)then
        
    elseif(updateType == EControllerUpdate.ECUT_NEED_REMOVE)then
        
        self._controllerState:controllerGrid():update(updateType)
    elseif(updateType == EControllerUpdate.ECUT_NEW_CATS) then
        
        self._controllerState:controllerGrid():update(updateType)
        
    elseif(updateType == EControllerUpdate.ECUT_TILES)then
        
        self._controllerState:controllerGrid():update(updateType)
        
    elseif(updateType == EControllerUpdateBase.ECUT_PLAYER_ENERGY)then
        --do nothing
    elseif(updateType == EControllerUpdate.ECUT_BONUS_DOG)then
        self._controllerState:controllerGrid():update(updateType)
    else
        assert(false, updateType)
    end
    
end


function StateGame.placeViews(self)
    
    StateBase.placeViews(self)
    
    self._controllerState:view():placeViews()
    self._controllerUI:view():placeViews()
    
    
end

function StateGame.cleanup(self)
    
    
    StateBase.cleanup(self)
end
