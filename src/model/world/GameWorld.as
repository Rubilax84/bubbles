/**
 * Created by Dryaglin on 24.10.2015.
 */
package model.world
{

	import flash.utils.getTimer;

	import model.world.objects.CircleData;

	import starling.core.Starling;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.EventDispatcher;

	import utils.GlobalConstants;
	import utils.Helper;

	public class GameWorld extends EventDispatcher
	{
		public static const NAME : String = "GameWorld";
		public static const GAME_WORLD_CREATED : String = 'gameWorldCreated';
		public static const GAME_WORLD_ACTIVATED : String = 'gameWorldActivated';
		public static const GAME_WORLD_STOP : String = 'gameWorldStop';
		public static const GAME_WORLD_UPDATE : String = 'gameWorldUpdate';

		private var _worldObjectsList : Vector.<CircleData>;
		private var plasedItems : Vector.<CircleData>;
		private var config : Object;
		private var _userObject : CircleData;

		public function GameWorld()
		{
			_worldObjectsList = new <CircleData>[];
		}

		public function create() : void
		{
			config = Facade.instance.assetsManager.getObject( GlobalConstants.CONFIG_OBJECT_NAME );

			_worldObjectsList.length = 0;

			var circleRadius : int;

			for ( var i : int = 0; i < config.gameObjectsCount; i++ )
			{
				circleRadius = Helper.getRandomInt( config.circleSize.min, config.circleSize.max );
				_worldObjectsList.push( new CircleData( 0, 0, circleRadius, config.baseSpeed ) );
			}

			/*
			 * add user Circle
			 * */
			circleRadius = config.circleSize.user;
			_userObject = new CircleData( 0, 0, circleRadius, config.baseSpeed );
			_userObject.isUserObject = true;
			_worldObjectsList.push( _userObject );

			rearrange();

			dispatchEvent( new Event( GAME_WORLD_CREATED ) );

			activate();
		}

		public function rearrange() : void
		{
			var t : uint = getTimer();

			plasedItems = new <CircleData>[];
			_worldObjectsList.sort( Helper.sortItemsDescending );

			for ( var i : int = 0; i < _worldObjectsList.length; i++ )
			{
				var circleData : CircleData = _worldObjectsList[i];
				setRightPosition( circleData );

				plasedItems.push( circleData );
			}

			plasedItems = null;

			trace( '[ rearranging time: ', getTimer() - t, ']' );
		}

		private function setRightPosition( data : CircleData ) : void
		{
			data.x = Helper.getRandomInt( data.r, Starling.current.stage.stageWidth - data.r );
			data.y = Helper.getRandomInt( data.r, Starling.current.stage.stageHeight - data.r );

			for ( var i : int = 0; i < plasedItems.length; i++ )
			{
				var circleData : CircleData = plasedItems[i];

				if ( data.checkCollision( circleData ) )
				{
					setRightPosition( data );
					return;
				}
			}
		}

		public function activate() : void
		{
			Facade.instance.display.addEventListener( EnterFrameEvent.ENTER_FRAME, update );

			dispatchEvent( new Event( GAME_WORLD_ACTIVATED ) );
		}

		public function stop() : void
		{
			Facade.instance.display.removeEventListener( EnterFrameEvent.ENTER_FRAME, update );
		}

		private function update( event : EnterFrameEvent ) : void
		{
			removeObjects();
			updateObjects();
		}

		private function updateObjects() : void
		{
			var current : CircleData;
			for ( var i : int = 0; i < _worldObjectsList.length; i++ )
			{
				current = _worldObjectsList[i];

				current.move();
				current.checkWallCollision();
				current.checkTouching( _worldObjectsList );
			}
		}

		private function removeObjects() : void
		{
			var current : CircleData;
			for ( var k : int = 0; k < _worldObjectsList.length; k++ )
			{
				current = _worldObjectsList[k];

				if ( current.r <= config.circleSize.removeSize )
				{
					_worldObjectsList.splice( _worldObjectsList.indexOf( current ), 1 );
				}
			}
		}

		public function get worldObjectsList() : Vector.<CircleData>
		{
			return _worldObjectsList;
		}

		public function get userObject() : CircleData
		{
			return _userObject;
		}
	}
}
