/**
 * Created by Dryaglin on 24.10.2015.
 */
package model.world.objects
{

	import utils.Helper;
	import utils.math.Vec2;

	public class AtomData extends BaseData
	{
		private var _radius : Number;
		private var _newRadius : Number;
		private var _diameter : Number;
		private var _state : int;

		public function AtomData( x : Number, y : Number, r : int, baseSpeed : Number )
		{
			super( x, y );

			this._radius = r;
			this._diameter = r * 2;

			this.speed = new Vec2();
			this.speed.x = Helper.getRandomNumber( -baseSpeed, baseSpeed );
			this.speed.y = Helper.getRandomNumber( -baseSpeed, baseSpeed );

			_state = AtomState.NORMAL;
		}

		override public function update() : void
		{
			move();
			checkState();
		}

		override protected function move() : void
		{
			position.x += speed.x * friction;
			position.y += speed.y * friction;

			/*
			 * check wall collision
			 * */
			if ( position.x >= _screenSize.x - radius && speed.x > 0 ) speed.x = -speed.x;
			if ( position.x <= radius && speed.x < 0 ) speed.x = -speed.x;
			if ( position.y >= _screenSize.y - radius && speed.y > 0 ) speed.y = -speed.y;
			if ( position.y <= radius && speed.y < 0 ) speed.y = -speed.y;
		}

		override public function handleContact( data : BaseData ) : void
		{
			var atomData : AtomData = data as AtomData;

			this.state = ( this.radius >= atomData.radius ) ? AtomState.INCREASE : this.state = AtomState.DECREASE;

			if ( this.state == AtomState.INCREASE )
			{
				var s1 : Number = Math.PI * (this.radius * this.radius );
				var s2 : Number = Math.PI * (atomData.radius * atomData.radius );

				_newRadius = Math.sqrt( (s1 + s2) / Math.PI );
			}
			else if ( this.state == AtomState.DECREASE )
			{
				_newRadius = 5;
			}

		}

		public function checkState() : void
		{
			switch ( this._state )
			{
				case AtomState.INCREASE:
				{
					this.radius *= 1.03;

					if ( this.radius >= newRadius )
					{
						this.radius = newRadius;
						state = AtomState.NORMAL;
						_newRadius = 0;
					}

					break;
				}
				case  AtomState.DECREASE:
				{
					this.radius *= 0.9;

					if ( this.radius <= newRadius )
					{
						this.radius = newRadius;
						state = AtomState.NORMAL;
						_newRadius = 0;
					}
					break;
				}
			}
		}

		public function get radius() : Number
		{
			return _radius;
		}

		public function set radius( value : Number ) : void
		{
			_radius = value;
			_diameter = _radius * 2;
		}

		public function get diameter() : Number
		{
			return _diameter;
		}

		public function get state() : int
		{
			return _state;
		}

		public function set state( value : int ) : void
		{
			_state = value;
		}

		public function get newRadius() : Number
		{
			return _newRadius;
		}
	}
}
