require('sdk.GameInfoBase')

require('game_cats.src.Constants')
require('game_cats.src.controllers.EControllerUpdate')
require('game_cats.src.views.EFontType')
require('game_cats.src.states.EStateType')
require('game_cats.src.models.levels.LevelInfo')


require('game_cats.src.controllers.popups.EPopupType')
require('game_cats.src.views.popups.base.ViewPopupCatsBase')

require('game_cats.src.models.players.PlayerInfo')
require("game_cats.src.models.resources.ManagerResources")
require("game_cats.src.models.ManagerParticles")
require("game_cats.src.models.sounds.ManagerSounds")
require('game_cats.src.models.string.ManagerString')
require('game_cats.src.models.game.ManagerGame')

require('game_cats.src.controllers.popups.game_over.ControllerPopupGameOver')
require('game_cats.src.controllers.popups.win.ControllerPopupWin')
require('game_cats.src.controllers.popups.pause.ControllerPopupPause')
require('game_cats.src.controllers.popups.shop.ControllerPopupShop')


GameInfo = classWithSuper(GameInfoBase, 'GameInfo') 
--
-- Properties
--

function GameInfo.init(self)
    
    application.assets_dir = 'game_cats/assets/'
    
    self._managerResources      = ManagerResources:new()
    self._managerFonts          = ManagerFontsBase:new()
    self._managerParticles      = ManagerParticles:new()
    self._managerStates         = ManagerStatesBase:new()
    self._managerString         = ManagerString:new()
    self._managerSounds         = ManagerSounds:new()
    self._managerPurchases      = ManagerPurchasesBase:new()
    self._managerBonus          = ManagerBonusEnergyBase:new(BonusInfoBase)
    self._managerPlayers        = ManagerPlayersBase:new(PlayerInfo)
    self._managerLevels         = ManagerLevelsBase:new(LevelInfo)
    
    
    GameInfoBase.init(self)
end

function GameInfo.registerStates(self)
    
    self._managerStates:registerState(EStateType.EST_GAME,     "game_cats.src.states.game.StateGameCreator")
    self._managerStates:registerState(EStateType.EST_MAP,      "game_cats.src.states.map.StateMapCreator")
    
end

function GameInfo.loadFonts(self)
    
    local fontsDir = application.assets_dir..'fonts/'
    
    local font0Pattern = string.format("%sfont_%i%s", fontsDir, EFontType.EFT_0, application.scaleSuffix)
    self._managerFonts:loadFont(EFontType.EFT_0, font0Pattern..'.fnt', font0Pattern..'.png', 20)
    
    local font1Pattern = string.format("%sfont_%i%s", fontsDir, EFontType.EFT_1, application.scaleSuffix)
    self._managerFonts:loadFont(EFontType.EFT_1, font1Pattern..'.fnt', font1Pattern..'.png', 22)
    
    local font2Pattern = string.format("%sfont_%i%s", fontsDir, EFontType.EFT_2, application.scaleSuffix)
    self._managerFonts:loadFont(EFontType.EFT_2, font2Pattern..'.fnt', font2Pattern..'.png', 22)
    
    GameInfoBase.loadFonts(self)
end