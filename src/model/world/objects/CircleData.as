/**
 * Created by Dryaglin on 24.10.2015.
 */
package model.world.objects
{

	import utils.Helper;
	import utils.math.Vec2;

	public class CircleData extends BaseData
	{
		public var r : Number;
		private var _d : Number;
		private var baseSpeed : Number = 0;

		public function CircleData( x : Number, y : Number, r : int, baseSpeed : Number )
		{
			super( x, y );

			this.r = r;
			this._d = r * 2;
			this.baseSpeed = baseSpeed;
			this.speed = new Vec2();
			this.speed.x = Helper.getRandomNumber( -baseSpeed, baseSpeed );
			this.speed.y = Helper.getRandomNumber( -baseSpeed, baseSpeed );
		}

		public function move() : void
		{
			speed.x += acceleration.x;
			speed.y += acceleration.y;

			x += speed.x * (friction - (1 / r));
			y += speed.y * (friction - (1 / r));
		}

		public function checkWallCollision() : void
		{
			if ( _x >= screenSize.x - r && speed.x > 0 ) speed.x = -speed.x;
			if ( _x <= r && speed.x < 0 ) speed.x = -speed.x;
			if ( _y >= screenSize.y - r && speed.y > 0 ) speed.y = -speed.y;
			if ( _y <= r && speed.y < 0 ) speed.y = -speed.y;
		}

		public function checkTouching( objectsList : Vector.<CircleData> ) : void
		{
			for ( var i : int = 0; i < objectsList.length; i++ )
			{
				var object : CircleData = objectsList[i];

				if ( object == this ) continue;

				if ( checkInteraction( object ) )
				{
					if ( this.r >= object.r )
					{
						var s1 : Number = Math.PI * (this.r * this.r );
						var s2 : Number = Math.PI * (object.r * object.r );

						/*var distance : Number = Helper.getDistance( this.position, object.position );
						 var r1 : Number = this.r;
						 var r2 : Number = object.r;
						 var f1 : Number = 2 * Math.acos( (r1 * r1 - r2 * r2 + distance * distance) / (2 * r1 * distance) );
						 var f2 : Number = 2 * Math.acos( (r2 * r2 - r1 * r1 + distance * distance) / (2 * r2 * distance) );
						 var sm1 : Number = ((r1 * r1) * f1 - Math.sin( f1 )) * 0.5;
						 var sm2 : Number = ((r2 * r2) * f2 - Math.sin( f2 )) * 0.5;*/

						var s3 : Number = s2 / object.r;

						s1 += s3;
						s2 -= s3;

						this.r = Math.sqrt( s1 / Math.PI );
						object.r = Math.sqrt( s2 / Math.PI );

					}
				}
			}
		}

		public function checkCollision( target : CircleData ) : Boolean
		{
			var distance : Number = Helper.getDistance( this.position, target.position );

			if ( distance < 0 )
			{
				distance = distance * -1;
			}

			return distance <= r + target.r;
		}

		public function checkInteraction( target : CircleData ) : Boolean
		{
			var distance : Number = Helper.getDistance( this.position, target.position );

			if ( distance < 0 )
			{
				distance = distance * -1;
			}

			return distance <= r + target.r;
		}

		public function get d() : Number
		{
			return r * 2;
		}
	}
}
