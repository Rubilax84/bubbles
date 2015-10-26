/**
 * Created by Dryaglin on 26.10.2015.
 */
package controller
{
	import flash.ui.Keyboard;

	import model.world.GameWorld;

	import starling.events.Event;
	import starling.events.KeyboardEvent;

	import view.GameField;

	public class GameStateController
	{
		public static const NAME : String = 'GameStateController';

		private var gameField : GameField;
		private var gameWorld : GameWorld;

		public function GameStateController()
		{
			gameWorld = Facade.instance.dataStorage[GameWorld.NAME];
			gameField = Facade.instance.viewStorage[GameField.NAME];

			gameWorld.addEventListener( GameWorld.GAME_WORLD_CREATED, gameWorldCreatedHandler );
			gameWorld.addEventListener( GameWorld.GAME_OVER, gameWorld_gameOverHandler );
		}

		private function gameWorldCreatedHandler( event : Event ) : void
		{
			gameWorld.removeEventListener( GameWorld.GAME_WORLD_CREATED, gameWorldCreatedHandler );

			gameField.addEventListener( KeyboardEvent.KEY_UP, gameField_keyUpHandler );
		}

		private function gameField_keyUpHandler( event : KeyboardEvent ) : void
		{
			if ( event.keyCode == Keyboard.R )
			{
				reloadGame();
			}
		}

		public function reloadGame() : void
		{
			gameWorld.stop();
			gameWorld.create();
		}

		private function gameWorld_gameOverHandler( event : Event ) : void
		{
			gameWorld.stop();
			gameField.onGameOver();
		}
	}
}
