ViewTile = classWithSuper(ViewBase, 'ViewTile')



--
--Methods
--



function ViewTile.init(self, params)
    
    
    ViewBase.init(self, params)
    
    local managerResources = GameInfo:instance():managerResources()
    
    self._sourceView = display.newGroup()
    
    
    self._viewTile = self:createSprite(managerResources:getAsImage(EResourceType.ERT_STATE_GAME_VIEW_CELL_TILE))
    
end


function ViewTile.cleanup(self)
    
    
    self._viewTile:cleanup()
    self._viewTile = nil
    
    self._sourceView:removeSelf()
    self._sourceView = nil
    
    ViewBase.cleanup(self)
end

