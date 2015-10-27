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
		private var _speed : Vec2;
		protected var _acceleration : Vec2;
		protected var friction : Number = 0.04;

		protected var _position : Point;
		protected var _screenSize : Point;

		private var _isUserObject : Boolean;

		public function BaseData( x : Number, y : Number )
		{
			_position = new Point( x, y );
			_acceleration = new Vec2();
			_screenSize = Helper.getScreenSize();
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

		public function get position() : Point
		{
			return _position;
		}

		public function setPosition( x : Number, y : Number ) : void
		{
			_position.x = x;
			_position.y = y;
		}

		public function get isUserObject() : Boolean
		{
			return _isUserObject;
		}

		public function set isUserObject( value : Boolean ) : void
		{
			_isUserObject = value;
		}

		public function set acceleration( value : Vec2 ) : void
		{
			_acceleration = value;
		}

		public function get acceleration() : Vec2
		{
			return _acceleration;
		}

		public function get speed() : Vec2
		{
			return _speed;
		}

		public function set speed( value : Vec2 ) : void
		{
			_speed = value;
		}
	}
}
