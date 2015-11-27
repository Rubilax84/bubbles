/**
 * Created by Dryaglin on 24.10.2015.
 */
package model.world.objects
{

	import utils.Helper;
	import utils.math.Vec2;

	public class AtomData extends BaseData
	{
		public var radius : Number;
		public var baseSpeed : Number;
		public var area : Number;
		public var newArea : Number;

		public function AtomData( x : Number, y : Number, r : int, baseSpeed : Number )
		{
			super( x, y );

			this.radius = r;
			this.area = Math.PI * (this.radius * this.radius);
			this.newArea = 0;

			this.baseSpeed = baseSpeed;

			this.speed = new Vec2();
			this.speed.x = Helper.getRandomNumber( -baseSpeed, baseSpeed );
			this.speed.y = Helper.getRandomNumber( -baseSpeed, baseSpeed );

			this.state = BaseDataState.NORMAL;
		}

		override public function update() : void
		{
			move();
			updateSize();
		}

		override protected function move() : void
		{
			speed.x += acceleration.x;
			speed.y += acceleration.y;

			position.x += speed.x * friction;
			position.y += speed.y * friction;

			var d : Number;

			if ( Math.abs( speed.x ) > baseSpeed )
			{
				d = (speed.x / Math.abs( speed.x )) * -1;
				speed.x += 0.06 * d;
			}

			if ( Math.abs( speed.y ) > baseSpeed )
			{
				d = (speed.y / Math.abs( speed.y )) * -1;
				speed.y += 0.06 * d;
			}

			/*
			 * check wall collision
			 * */
			if ( position.x >= screenSize.x - radius && speed.x > 0 ) speed.x = -speed.x;
			if ( position.x <= radius && speed.x < 0 ) speed.x = -speed.x;
			if ( position.y >= screenSize.y - radius && speed.y > 0 ) speed.y = -speed.y;
			if ( position.y <= radius && speed.y < 0 ) speed.y = -speed.y;
		}

		override public function handleContact( data : BaseData ) : void
		{
			if ( !(data in collisionList) )
			{
				var atomData : AtomData = data as AtomData;
				var s1 : Number = Math.PI * (this.radius * this.radius );
				var s2 : Number = Math.PI * (atomData.radius * atomData.radius );

				this.state = ( s1 >= s2 ) ? BaseDataState.INCREASE : BaseDataState.DECREASE;
				atomData.state = BaseDataState.DECREASE;

				if ( state == BaseDataState.INCREASE )
				{
					var s : Number = s1 + s2;
					newArea += s;
					collisionList[atomData] = s;
					collisionsCount++;
				}

			}
		}

		public function updateSize() : void
		{
			for ( var data : AtomData in collisionList )
			{
				var d : Number = data.area * 0.1;
				data.area -= d;
				data.radius = Math.sqrt( data.area / Math.PI );

				this.area += d;
				this.radius = Math.sqrt( this.area / Math.PI );

				magic( data );
			}

			if ( newArea && this.area >= newArea )
			{
				this.area = newArea;
				this.radius = Math.sqrt( this.area / Math.PI );

				clearCollisions();

				newArea = 0;

				this.state = BaseDataState.NORMAL;
			}
		}

		private function magic( data : AtomData ) : void
		{
			var vec1 : Vec2 = new Vec2( data.position.x, data.position.y );
			var vec2 : Vec2 = new Vec2( position.x, position.y );

			vec2.subSelf( vec1 );
			vec2.normalizeSelf();

			data.position.addSelf(vec2);// = vec2.scaleSelf(0.4);
		}

		public function get diameter() : Number
		{
			return radius * 2;
		}
	}
}
