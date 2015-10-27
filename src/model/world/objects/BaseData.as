/**
 * Created by Dryaglin on 24.10.2015.
 */
package model.world.objects
{

	import flash.geom.Point;

	import utils.Helper;
	import utils.math.Vec2;

	public class BaseData
	{
		public var speed : Vec2;
		public var acceleration : Vec2;
		public var friction : Number = 0.04;

		public var position : Point;
		public var screenSize : Point;

		public var isUserObject : Boolean;

		public function BaseData( x : Number, y : Number )
		{
			position = new Point( x, y );
			acceleration = new Vec2();
			screenSize = Helper.getScreenSize();
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
