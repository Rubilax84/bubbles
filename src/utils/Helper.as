/**
 * Created by Dryaglin on 24.10.2015.
 */
package utils
{

	import flash.geom.Point;

	import model.world.objects.AtomData;

	import starling.display.Stage;

	import view.objects.Atom;

	public class Helper
	{
		public static function getRandomInt( min : int, max : int ) : int
		{
			return Math.round( Math.random() * (max - min) + min );
		}

		public static function getRandomNumber( min : Number, max : Number ) : Number
		{
			return Math.random() * (max - min) + min;
		}

		public static function getDistance( a : Point, b : Point ) : Number
		{
			return Math.sqrt( (b.x - a.x) * (b.x - a.x) + (b.y - a.y) * (b.y - a.y) );
		}

		public static function getScreenSize() : Point
		{
			var size : Point = new Point();
			var screen : Stage = Facade.instance.display.stage;

			size.x = screen.stageWidth;
			size.y = screen.stageHeight;

			return size;
		}

		public static function sortAtomsDescending( a : Atom, b : Atom ) : int
		{
			if ( a.data.radius < b.data.radius )
				return 1;
			else if ( a.data.radius > b.data.radius )
				return -1;
			else
				return 0;
		}

		public static function sortItemsDescending( a : AtomData, b : AtomData ) : int
		{
			if ( a.radius < b.radius )
				return 1;
			else if ( a.radius > b.radius )
				return -1;
			else
				return 0;
		}

		public static function RGBToHex( r : int, g : int, b : int ) : uint
		{
			var hex : uint = r << 16 | g << 8 | b;
			return hex;
		}

		public static function RGBToHexFromArray( data : Array ) : uint
		{
			var hex : uint = data[0] << 16 | data[1] << 8 | data[2];
			return hex;
		}

		public static function getColor( size : Number, minSize : Number, maxSize : Number, baseSize : Number, colorsData : Object ) : uint
		{

			var p : Number = (size / maxSize) * 100;
			var bp : Number = ((baseSize < maxSize ? baseSize : maxSize) / maxSize) * 100;

			function percentToRGB( percent : Number ) : Array
			{
				if ( percent === 100 )
				{
					percent = 99
				}
				var r : uint, g : uint, b : uint;

				if ( percent < bp )
				{
					r = Math.floor( 255 * (percent / 50) );
					b = 255;
				}
				else
				{
					r = 255;
					b = Math.floor( 255 * ((50 - percent % 50) / 50) );
				}

				g = 0;

				return [r, g, b];
			}

			return Helper.RGBToHexFromArray( percentToRGB( p ) );
		}
	}
}
