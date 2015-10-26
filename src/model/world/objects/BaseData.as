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
		private var _isUserObject : Boolean;
		protected var _x : Number;
		protected var _y : Number;
		protected var _position : Point;

		public var speed : Vec2;
		public var acceleration : Vec2;
		public var friction : Number = 0.04;

		protected var screenSize : Point;

		public function BaseData( x : Number, y : Number )
		{
			this._x = x;
			this._y = y;

			_position = new Point( x, y );
			acceleration = new Vec2();
			screenSize = Helper.getScreenSize();
		}

		public function get position() : Point
		{
			return _position;
		}

		public function get x() : Number
		{
			return _x;
		}

		public function set x( value : Number ) : void
		{
			_x = value;
			_position.x = _x;
		}

		public function get y() : Number
		{
			return _y;
		}

		public function set y( value : Number ) : void
		{
			_y = value;
			_position.y = _y;
		}

		public function get isUserObject() : Boolean
		{
			return _isUserObject;
		}

		public function set isUserObject( value : Boolean ) : void
		{
			_isUserObject = value;
		}
	}
}
