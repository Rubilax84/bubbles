/**
 * Created by Dryaglin on 24.10.2015.
 */
package model.world
{

	import flash.utils.getTimer;

	import model.world.objects.AtomData;
	import model.world.objects.BaseDataState;

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
		public static const GAME_OVER : String = 'gameOver';

		private var _worldObjectsList : Vector.<AtomData>;
		private var placedItems : Vector.<AtomData>;
		private var config : Object;
		private var _userObject : AtomData;
		private var atomData : AtomData;
		private var worldWidth : Number;
		private var worldHeight : Number;

		public function GameWorld()
		{
			_worldObjectsList = new <AtomData>[];

			worldWidth = Starling.current.stage.stageWidth;
			worldHeight = Starling.current.stage.stageHeight;
		}

		public function create() : void
		{
			config = Facade.instance.assetsManager.getObject( GlobalConstants.CONFIG_OBJECT_NAME );

			_worldObjectsList.length = 0;

			var circleRadius : int;

			for ( var i : int = 0; i < config.gameObjectsCount; i++ )
			{
				circleRadius = Helper.getRandomInt( config.circleSize.min, config.circleSize.max );
				_worldObjectsList.push( new AtomData( 0, 0, circleRadius, config.baseSpeed ) );
			}

			/*
			 * add user Circle
			 * */
			circleRadius = config.circleSize.user;
			_userObject = new AtomData( 0, 0, circleRadius, config.baseSpeed );
			_userObject.isUserObject = true;
			_worldObjectsList.push( _userObject );

			rearrange();

			dispatchEventWith( GAME_WORLD_CREATED );

			activate();
		}

		public function rearrange() : void
		{
			var t : uint = getTimer();
			var circleData : AtomData;

			placedItems = new <AtomData>[];
			_worldObjectsList.sort( Helper.sortItemsDescending );

			for ( var i : int = 0; i < _worldObjectsList.length; i++ )
			{
				circleData = _worldObjectsList[i];
				setRightPosition( circleData );

				placedItems.push( circleData );
			}

			placedItems = null;

			trace( 'rearrange time:', getTimer() - t );
		}

		private function setRightPosition( data : AtomData ) : void
		{
			var x : Number = Helper.getRandomNumber( data.radius, worldWidth - data.radius );
			var y : Number = Helper.getRandomNumber( data.radius, worldHeight - data.radius );

			data.setPosition( x, y );

			for ( var i : int = 0; i < placedItems.length; i++ )
			{
				if ( collisionDetect( data, placedItems[i] ) )
				{
					setRightPosition( data );
					return;
				}
			}
		}

		private function update( event : EnterFrameEvent ) : void
		{
			return;
			//var t : uint = getTimer();
			_worldObjectsList.sort( Helper.sortItemsDescending );
			if ( userObject.state == BaseDataState.NORMAL && int( userObject.radius ) >= int( _worldObjectsList[0].radius ) )
			{
				dispatchEventWith( GAME_OVER );
				return;
			}

			/*
			 * start check collisions
			 * */
			var data : AtomData;
			var collisionDetected : Boolean;
			for each ( atomData in _worldObjectsList )
			{
				collisionDetected = false;

				for ( var i : int = 0; i < _worldObjectsList.length; i++ )
				{
					data = _worldObjectsList[i];

					if ( atomData == data ) continue;

					if ( atomData != data && collisionDetect( atomData, data ) )
					{
						atomData.handleContact( data );
						//data.handleContact( atomData );
						collisionDetected = true;
					}
					else if ( data in atomData.collisionList )
					{
						atomData.removeCollisionObject( data );
					}

				}

				if ( !collisionDetected )
				{
					atomData.clearCollisions();
					atomData.state = BaseDataState.NORMAL;
				}

			}

			/*
			 * update objects position and size
			 * */
			for each ( atomData  in _worldObjectsList )
			{
				//atomData.update();
			}

			removeObjects();

			//trace( 'update time:', getTimer() - t );
		}

		private function removeObjects() : void
		{
			var current : AtomData;
			for ( var k : int = 0; k < _worldObjectsList.length; k++ )
			{
				current = _worldObjectsList[k];

				if ( current.radius <= config.circleSize.removeSize )
				{
					_worldObjectsList.splice( _worldObjectsList.indexOf( current ), 1 );

					if ( current.isUserObject )
						dispatchEventWith( GAME_OVER );
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

		public static function collisionDetect( a : AtomData, b : AtomData ) : Boolean
		{
			var distance : Number = Math.sqrt( (b.position.x - a.position.x) * (b.position.x - a.position.x) + (b.position.y - a.position.y) * (b.position.y - a.position.y) );

			return distance <= a.radius + b.radius;
		}

		public function get worldObjectsList() : Vector.<AtomData>
		{
			return _worldObjectsList;
		}

		public function get userObject() : AtomData
		{
			return _userObject;
		}
	}
}
