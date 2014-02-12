ViewCell = classWithSuper(ViewBase, 'ViewCell')



--
--Methods
--

function ViewCell.init(self, params)
    
    assert(params.type ~= nil)
    assert(params.default ~= nil)
    
    ViewBase.init(self, params)
    
    local managerResources = GameInfo:instance():managerResources()
    
    self._sourceView = display.newGroup()
    
    self._viewDefault = self:createSprite(managerResources:getAsImage(EResourceType["ERT_STATE_GAME_VIEW_CELL_DEFAULT_"..params.default]))
    self._sourceView:insert(self._viewDefault:sourceView())
    
end


function ViewCell.cleanup(self)
    
    self._viewDefault:cleanup()
    self._viewDefault = nil
    
    self._sourceView:removeSelf()
    self._sourceView = nil
    
    ViewBase.cleanup(self)
end

