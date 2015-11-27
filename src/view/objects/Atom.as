/**
 * Created by Dryaglin on 24.10.2015.
 */
package view.objects
{

	import model.world.objects.AtomData;
	import model.world.objects.BaseDataState;

	import starling.core.RenderSupport;
	import starling.display.Canvas;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.filters.BlurFilter;

	public class Atom extends Sprite
	{
		public var data : AtomData;
		private var radius : int;
		private var canvas : Canvas;
		private var objectImage : Image;
		private var color : uint;

		public function Atom( data : AtomData )
		{
			this.data = data;
			this.radius = data.radius;

			color = Math.random() * 0xffffff;

			canvas = new Canvas();
			canvas.alpha = 1;
			canvas.filter = new BlurFilter( 1, 1, 3 );
			addChild( canvas );

			objectImage = new Image( Facade.instance.assetsManager.getAtomTexture() );
			objectImage.scaleX = data.diameter / objectImage.texture.width;
			objectImage.scaleY = objectImage.scaleX;
			objectImage.alignPivot();

			addChild( objectImage );

			this.x = data.position.x;
			this.y = data.position.y;
			this.touchable = false;
		}

		public function drawBackground() : void
		{
			canvas.clear();
			canvas.beginFill( color );
			canvas.drawCircle( 0, 0, data.isUserObject ? data.radius * 0.9 : data.radius * 0.6 );
			canvas.endFill();
		}

		public function setColor( color : uint ) : void
		{
			if ( this.color == color ) return;

			this.color = color != 0 ? color : Math.random() * 0xffffff;

			drawBackground();
		}

		public function update() : void
		{

		}

		override public function render( support : RenderSupport, parentAlpha : Number ) : void
		{
			this.x = data.position.x;
			this.y = data.position.y;

			if ( data.radius != radius )
			{
				if ( this.isFlattened && data.state != BaseDataState.NORMAL )
					this.unflatten();

				objectImage.scaleX = (data.radius * 2) / objectImage.texture.width;
				objectImage.scaleY = objectImage.scaleX;

				drawBackground();
			}

			if ( !this.isFlattened && data.state == BaseDataState.NORMAL )
				this.flatten();

			super.render( support, parentAlpha );
		}

		override public function dispose() : void
		{
			objectImage.dispose();
			canvas.dispose();

			objectImage = null;
			canvas = null;
			data = null;

			super.dispose();
		}
	}
}
