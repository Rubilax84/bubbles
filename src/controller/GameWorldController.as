/**
 * Created by Dryaglin on 24.10.2015.
 */
package controller
{
	import model.world.GameWorld;

	import starling.events.Event;

	import view.GameField;

	public class GameWorldController
	{
		public static const NAME : String = 'GameWorldController';
		private var gameWorld : GameWorld;

		public function GameWorldController()
		{
			gameWorld = Facade.instance.dataStorage[GameWorld.NAME];

			gameWorld.addEventListener( GameWorld.GAME_WORLD_CREATED, gameWorldCreatedHandler );
			gameWorld.addEventListener( GameWorld.GAME_WORLD_ACTIVATED, gameWorldActivatedHandler );
			gameWorld.addEventListener( GameWorld.GAME_WORLD_STOP, gameWorldStopedHandler );
			gameWorld.addEventListener( GameWorld.GAME_WORLD_UPDATE, gameWorldUpdateHandler );
		}

		private function gameWorldCreatedHandler( event : Event ) : void
		{
			//trace( '[', 'gameWorldCreatedHandler', ']' );

			(Facade.instance.viewStorage[GameField.NAME] as GameField).initialize();
		}

		private function gameWorldActivatedHandler( event : Event ) : void
		{
			//trace( '[', 'gameWorldActivatedHandler', ']' );
		}

		private function gameWorldStopedHandler( event : Event ) : void
		{
			//trace( '[', 'gameWorldStopedHandler', ']' );
		}

		private function gameWorldUpdateHandler( event : Event ) : void
		{
			(Facade.instance.viewStorage[GameField.NAME] as GameField).updateField();
		}
	}
}
