/**
 * Created by Dryaglin on 28.10.2015.
 */
package utils.math
{

	public class Gauss
	{
		private var ready : Boolean = false;
		private var second : Number = 0.0;

		public function Gauss()
		{
		}

		public function next( mean : Number = NaN, dev : Number = NaN ) : Number
		{
			mean = (!mean) ? 0.0 : mean;
			dev = (!dev) ? 1.0 : dev;

			if ( this.ready )
			{
				this.ready = false;
				return this.second * dev + mean;
			}
			else
			{
				var u : Number, v : Number, s : Number, r : Number;

				do {
					u = 2.0 * Math.random() - 1.0;
					v = 2.0 * Math.random() - 1.0;
					s = u * u + v * v;
				} while ( s > 1.0 || s == 0.0 );

				r  = Math.sqrt( -2.0 * Math.log( s ) / s );

				this.second = r * u;
				this.ready = true;

				return r * v * dev + mean;
			}
		}
	}
}
