/**
 * Created by Dryaglin on 24.10.2015.
 */
package view
{

	import model.world.GameWorld;
	import model.world.objects.AtomData;

	import starling.display.Canvas;
	import starling.display.Sprite;

	import utils.GlobalConstants;
	import utils.Helper;

	import view.objects.Atom;

	public class GameField extends Sprite
	{
		public static const NAME : String = 'GameField';

		private var display : Sprite;
		private var objectsList : Vector.<Atom>;
		private var config : Object;

		public function GameField( display : Sprite )
		{
			this.display = display;

			this.x = 0;
			this.y = 0;

			this.display.addChild( this );
			objectsList = new <Atom>[];

			addBack();
		}

		private function addBack() : void
		{
			var canvas : Canvas = new Canvas();
			canvas.beginFill( 0x000000, 1 );
			canvas.drawRectangle( 0, 0, stage.stageWidth, stage.stageHeight );
			canvas.endFill();
			canvas.touchable = true;

			this.addChild( canvas );
		}

		public function initialize() : void
		{
			config = Facade.instance.assetsManager.getObject( GlobalConstants.CONFIG_OBJECT_NAME );
			var objectsData : Vector.<AtomData> = (Facade.instance.dataStorage[GameWorld.NAME] as GameWorld).worldObjectsList;

			for ( var i : int = 0; i < objectsData.length; i++ )
			{
				drawObject( objectsData[i] );
			}
		}

		private function drawObject( data : AtomData ) : void
		{
			var gameObject : Atom = new Atom( data );

			gameObject.setColor( data.isUserObject ? Helper.RGBToHexFromArray( config.color.user.color ) : 0 );

			objectsList.push( gameObject );

			this.addChild( gameObject );
		}

		public function updateField() : void
		{
			for each ( var viewObject : Atom in objectsList )
			{
				if ( viewObject.data.radius <= config.circleSize.removeSize )
				{
					objectsList.splice( objectsList.indexOf( viewObject ), 1 );
					viewObject.removeFromParent( true );
					continue;
				}

				viewObject.update();
			}
		}

		public function clear() : void
		{
			for ( var i : int = 0; i < objectsList.length; i++ )
			{
				objectsList[i].removeFromParent( true );
			}

			objectsList.length = 0;
		}
	}
}
