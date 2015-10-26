/**
 * Created by Dryaglin on 24.10.2015.
 */
package utils
{

	import flash.geom.Point;

	import model.world.objects.CircleData;

	import starling.display.Stage;

	public class Helper
	{
		public static function getRandomInt( min : int, max : int ) : Number
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

		public static function getBiggestObgectSize( list : Vector.<CircleData> ) : int
		{
			var nList : Vector.<CircleData> = list.filter( function ( item : CircleData, index : int, vector : Vector.<CircleData> ) : Boolean {return true} );

			nList.sort( sortItemsDescending );

			var value : int = nList[0].d;

			nList = null;

			return value;
		}

		public static function sortItemsDescending( a : CircleData, b : CircleData ) : int
		{
			if ( a.r < b.r )
				return 1;
			else if ( a.r > b.r )
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
	}
}
