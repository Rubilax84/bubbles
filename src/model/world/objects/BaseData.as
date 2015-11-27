/**
 * Created by Dryaglin on 24.10.2015.
 */
package model.world.objects
{

	import flash.geom.Point;
	import flash.utils.Dictionary;

	import utils.Helper;
	import utils.math.Vec2;

	public class BaseData
	{
		public var speed : Vec2;
		public var acceleration : Vec2;
		public var friction : Number = 0.04;
		public var position : Vec2;
		public var screenSize : Point;
		public var isUserObject : Boolean;
		public var state : int;
		public var collisionList : Dictionary;
		public var collisionsCount : uint;

		public function BaseData( x : Number, y : Number )
		{
			position = new Vec2( x, y );
			acceleration = new Vec2();
			screenSize = Helper.getScreenSize();
			collisionList = new Dictionary( true );
		}

		public function removeCollisionObject( data : BaseData ) : void
		{
			if ( data in collisionList )
			{
				delete  collisionList[data];
				collisionsCount--;

				data.state = BaseDataState.NORMAL;
			}
		}

		public function clearCollisions() : void
		{
			for ( var data : BaseData in collisionList )
			{
				data.state = BaseDataState.NORMAL;
			}

			collisionList = new Dictionary( true );
			collisionsCount = 0;
		}

		public function update() : void
		{

		}

		protected function move() : void
		{

		}

		public function handleContact( data : BaseData ) : void
		{

		}

		public function setPosition( x : Number, y : Number ) : void
		{
			position.x = x;
			position.y = y;
		}
	}
}
