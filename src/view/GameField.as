/**
 * Created by Dryaglin on 24.10.2015.
 */
package view
{

	import model.world.GameWorld;
	import model.world.objects.AtomData;

	import starling.animation.Tween;
	import starling.core.Starling;

	import starling.display.Canvas;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.VAlign;

	import utils.GlobalConstants;
	import utils.Helper;

	import view.objects.Atom;

	public class GameField extends Sprite
	{
		public static const NAME : String = 'GameField';

		private var display : Sprite;
		private var objectsList : Vector.<Atom>;
		private var config : Object;
		private var viewObject : Atom;
		private var userAtom : Atom;
		private var canvas : Canvas;
		private var atomsField : Sprite;

		public function GameField( display : Sprite )
		{
			this.display = display;

			this.x = 0;
			this.y = 0;

			this.display.addChild( this );
			objectsList = new <Atom>[];

			this.atomsField = new Sprite();
		}

		private function addBack() : void
		{
			this.removeChildren();
			this.atomsField.removeChildren();
			this.atomsField.alpha = 1;

			canvas = new Canvas();
			canvas.beginFill( 0x000000, 1 );
			canvas.drawRectangle( 0, 0, stage.stageWidth, stage.stageHeight );
			canvas.endFill();
			canvas.touchable = true;

			this.addChild( canvas );
			this.addChild( atomsField );
		}

		public function initialize() : void
		{

			clear();
			addBack();

			config = Facade.instance.assetsManager.getObject( GlobalConstants.CONFIG_OBJECT_NAME );

			var objectsData : Vector.<AtomData> = (Facade.instance.dataStorage[GameWorld.NAME] as GameWorld).worldObjectsList;

			for ( var i : int = 0; i < objectsData.length; i++ )
			{
				drawObject( objectsData[i] );
			}
		}

		private function drawObject( data : AtomData ) : void
		{
			var atom : Atom = new Atom( data );

			atom.setColor( data.isUserObject ? Helper.RGBToHexFromArray( config.color.user.color ) : 0 );

			objectsList.push( atom );

			this.atomsField.addChild( atom );

			if ( data.isUserObject ) userAtom = atom;
		}

		public function updateField() : void
		{
			/*
			 * update atoms colors
			 * */
			var eList : Vector.<Atom> = objectsList.filter( getEnemyAtomsList );

			eList.sort( Helper.sortAtomsDescending );

			for each ( var atom : Atom in eList )
			{
				var color : uint = Helper.getColor( atom.data.radius, eList[eList.length - 1].data.radius, eList[0].data.radius, userAtom.data.radius, config.color.enemy );
				atom.setColor( color );
			}

			for each ( viewObject in objectsList )
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

		private static function getEnemyAtomsList( item : Atom, index : int, vector : Vector.<Atom> ) : Boolean
		{
			return !item.data.isUserObject;
		}

		public function clear() : void
		{
			for ( var i : int = 0; i < objectsList.length; i++ )
			{
				objectsList[i].removeFromParent( true );
			}

			objectsList.length = 0;
		}

		public function onGameOver() : void
		{
			var tween : Tween = new Tween( this.atomsField, 0.5 );
			tween.fadeTo( 0 );
			tween.onComplete = onFadeComplete;

			Starling.juggler.add( tween );
		}

		private function onFadeComplete() : void
		{
			var tf : TextField = new TextField( display.width, 100, "Game over!\nPress 'R' button to start! " );
			tf.color = 0xffffff;
			tf.fontSize = 16;
			tf.bold = true;
			tf.x = 0;
			tf.y = (display.stage.stageHeight - tf.height) * 0.5;

			tf.vAlign = VAlign.CENTER;

			this.addChild( tf );
		}
	}
}
