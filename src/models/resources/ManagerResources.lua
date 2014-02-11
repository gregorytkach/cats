require('game_cats.src.models.resources.EResourceType')

ManagerResources = classWithSuper(ManagerResourcesBase, 'ManagerResources') 

--
--Methods
--

function ManagerResources.init(self)
    ManagerResourcesBase.init(self)
    
    --common
    self._resources[EResourceType.ERT_BUTTON_BUY]                           = "%scommon/button_buy/%s%s.png"
    self._resources[EResourceType.ERT_BUTTON_BLUE]                          = "%scommon/button_blue_long/%s%s.png"
    self._resources[EResourceType.ERT_BUTTON_GREEN]                         = "%scommon/button_green/%s%s.png"
    
    --state map
    
    self._resources[EResourceType.ERT_STATE_MAP_VIEW_STARS]                 = "%sstate_map/ui/view_stars/view_stars%s.png"
    
    self._resources[EResourceType.ERT_STATE_MAP_VIEW_ENERGY]                = "%sstate_map/ui/view_energy/view_energy%s.png"
    
    self._resources[EResourceType.ERT_STATE_MAP_BUTTON_ITEM]                = '%sstate_map/button_level/%s%s.png'
    self._resources[EResourceType.ERT_STATE_MAP_ICON_STAR]                  = '%sstate_map/button_level/icon_star/icon_star%s.png'
    
    self._resources[EResourceType.ERT_STATE_MAP_BUTTON_FREE_ENERGY]         = "%sstate_map/ui/view_free/button/%s%s.png"
    self._resources[EResourceType.ERT_STATE_MAP_BUTTON_SHOP]                = "%sstate_map/ui/button_shop/%s%s.png"
    self._resources[EResourceType.ERT_STATE_MAP_MAP_PART]                   = '%sstate_map/map/map_%s%s.jpg'
    
    --state game
    self._resources[EResourceType.ERT_STATE_GAME_VIEW_CELL_DEFAULT_0]       = "%sstate_game/cell/default_0/cell%s.jpg"
    self._resources[EResourceType.ERT_STATE_GAME_VIEW_CELL_DEFAULT_1]       = "%sstate_game/cell/default_1/cell%s.jpg"
    
    self._resources[EResourceType.ERT_STATE_GAME_VIEW_CAT]                  = "%sstate_game/cats/cat_%s/%s/cat_"
    
    self._resources[EResourceType.ERT_STATE_GAME_BUTTON_PAUSE]              = "%sstate_game/ui/button_pause/%s%s.png"
    self._resources[EResourceType.ERT_STATE_GAME_VIEW_TURNS]                = "%sstate_game/ui/view_turns/view_turns%s.png"
    
    self._resources[EResourceType.ERT_STATE_GAME_BUTTON_REMOVE_9_CELLS]     = "%sstate_game/ui/view_purchases/button_remove_9_cells/%s%s.png"
    self._resources[EResourceType.ERT_STATE_GAME_BUTTON_REMOVE_BOTTOM_ROW]  = "%sstate_game/ui/view_purchases/button_remove_bottom_row/%s%s.png"
    self._resources[EResourceType.ERT_STATE_GAME_BUTTON_SHUFFLE]            = "%sstate_game/ui/view_purchases/button_shuffle/%s%s.png"
    
    self._resources[EResourceType.ERT_STATE_GAME_VIEW_BACKGROUND]           = "%sstate_game/ui/view_progress/background/background%s.png"
    self._resources[EResourceType.ERT_STATE_GAME_PROGRESS_BAR]              = "%sstate_game/ui/view_progress/progress_bar/progress_bar%s.png"
    self._resources[EResourceType.ERT_STATE_GAME_ICON_STAR]                 = "%sstate_game/ui/view_progress/icon_star/icon_star%s.png"
    
    --popup game over
    self._resources[EResourceType.ERT_POPUP_GAME_OVER_ANIMATION_CAT]        = '%spopup_game_over/animation/%s/cat_01.png'
    self._resources[EResourceType.ERT_POPUP_GAME_OVER_VIEW_ENERGY]          = '%spopup_game_over/view_energy/view_energy%s.png'
    
    --popup win
    self._resources[EResourceType.ERT_POPUP_WIN_ANIMATION_CAT]              = '%spopup_win/animation/%s/cat_01.png'
    self._resources[EResourceType.ERT_POPUP_WIN_VIEW_TILE]                  = '%spopup_win/view_tile/view_tile%s.png'
    
    --popup shop
    self._resources[EResourceType.ERT_POPUP_SHOP_BUTTON_TAB]                 = '%spopup_shop/button_tab/%s%s.png'
    self._resources[EResourceType.ERT_POPUP_SHOP_VIEW_ITEM]                  = '%spopup_shop/content/view_item/view_item%s.png'
    self._resources[EResourceType.ERT_ICON_ENERGY]                           = '%spopup_shop/content/energy/view_energy%s.png'
    
end

--
-- Popups
--

function ManagerResources.getPopupBackground(self, type)
    
    local result = ''
    
    if (type == EPopupType.EPT_SHOP) then
        result = '%spopup_shop/background/background%s.png'
    elseif (type == EPopupType.EPT_WIN) then
        result = '%spopup_win/background/background%s.png'
    elseif (type == EPopupType.EPT_GAME_OVER) then
        result = '%spopup_game_over/background/background%s.png'
    elseif (type == EPopupType.EPT_BONUS) then
        result = '%spopup_bonus/background/background%s.png'
    elseif(type == EPopupType.EPT_PAUSE)then
        result = '%spopup_pause/background/background%s.png'
    elseif(type == EPopupType.EPT_SHOP)then
        result = '%spopup_shop/background/background%s.png'
    else
        assert(false)
    end
    
    result = string.format(result, application.assets_dir, application.scaleSuffix)
    
    return result
    
end

--
--Game
--


function ManagerResources.getStateBackground(self, value)
    local result = ''
    
    if (value == EStateType.EST_GAME) then
        result = '%sstate_game/background/background%s.jpg'
    elseif(value == EStateType.EST_MAP)then
        result = '%sstate_map/map/map_1%s.jpg'
    else
        assert(false)
    end
    
    result = string.format(result, application.assets_dir, application.scaleSuffix)
    
    return result
end

function ManagerResources.initAnimations(self)
    ManagerResourcesBase.initAnimations(self)
    
end