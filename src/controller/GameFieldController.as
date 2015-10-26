/**
 * Created by Dryaglin on 25.10.2015.
 */
package controller
{

	import model.world.GameWorld;
	import model.world.objects.AtomData;

	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	import utils.math.Vec2;

	import view.GameField;

	public class GameFieldController
	{
		public static const NAME : String = 'GameFieldController';

		private var gameField : GameField;
		private var gameWorld : GameWorld;
		private var userAtom : AtomData;

		public function GameFieldController()
		{
			gameWorld = Facade.instance.dataStorage[GameWorld.NAME];
			gameWorld.addEventListener( GameWorld.GAME_WORLD_CREATED, gameWorldCreatedHandler );
			gameWorld.addEventListener( GameWorld.GAME_OVER, gameWorld_gameOverHandler);

			gameField = Facade.instance.viewStorage[GameField.NAME];

		}

		private function gameWorldCreatedHandler( event : Event ) : void
		{
			//gameWorld.removeEventListener( GameWorld.GAME_WORLD_CREATED, gameWorldCreatedHandler );

			userAtom = gameWorld.userObject;
			gameField.addEventListener( TouchEvent.TOUCH, touchHandler );
			gameField.addEventListener( EnterFrameEvent.ENTER_FRAME, enterFrameHandler );
		}

		private function touchHandler( event : TouchEvent ) : void
		{
			var touch : Touch = event.getTouch( gameField );

			if ( !touch ) return;

			if ( touch.phase == TouchPhase.BEGAN )//on finger down
			{
				var vec1 : Vec2 = new Vec2( userAtom.position.x, userAtom.position.y );
				var vec2 : Vec2 = new Vec2( touch.globalX, touch.globalY );

				var vec3 : Vec2 = vec1.clone();
				vec3.subSelf( vec2 );
				vec3.normalizeSelf();

				userAtom.acceleration = vec3.clone();

				trace( userAtom.acceleration );

				//userAtom.x = touch.globalX;
				//userAtom.y = touch.globalY;
			}
			else if ( touch.phase == TouchPhase.ENDED ) //on finger up
			{
				userAtom.acceleration = new Vec2();
			}
		}

		private function gameWorld_gameOverHandler( event : Event ) : void
		{
			gameField.removeEventListener( EnterFrameEvent.ENTER_FRAME, enterFrameHandler );
		}

		private function enterFrameHandler( event : EnterFrameEvent ) : void
		{
			gameField.updateField();
		}
	}
}
