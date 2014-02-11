require('game_cats.src.states.game.StateGame')

local state = StateGame:new()

GameInfo:instance():managerStates():onCurrentStateCreated(state);

return state:sceneStoryboard()