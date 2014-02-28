ViewBonusDog = classWithSuper(ViewBase, 'ViewBonusDog')

--
--Properties
--

function ViewBonusDog.animation(self)
    return self._animation
end

--
--Methods
--



function ViewBonusDog.init(self, params)
    
    ViewBase.init(self, params)
    
    self._sourceView = display.newGroup()
    
    
    self._animation = GameInfo:instance():managerResources():getAsAnimation(EResourceType.ERT_STATE_GAME_ANIMATION_BONUS_DOG)
    self._sourceView:insert(self._animation)
    
  
end


function ViewBonusDog.cleanup(self)
    
    self._animation:cleanup()
    self._animation = nil
    
    self._sourceView:removeSelf()
    self._sourceView = nil
    
    ViewBase.cleanup(self)
end

