/**
 * Created by Dryaglin on 24.10.2015.
 */
package view.objects
{

	import model.world.objects.CircleData;

	import starling.display.Canvas;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.filters.ColorMatrixFilter;
	import starling.textures.Texture;

	import utils.GlobalConstants;

	public class CircleViewObject extends Sprite
	{
		public var data : CircleData;
		private var radius : int;
		private var canvas : Canvas;
		private var objectImage : Image;
		private var colorFilter : ColorMatrixFilter;
		private var color : uint;

		public function CircleViewObject( data : CircleData )
		{
			this.data = data;
			this.radius = data.r;
			var texture : Texture = Facade.instance.assetsManager.getTexture( GlobalConstants.BUBLE_FILE_NAME.split( '.' )[0] );

			color = Math.random() * 0xffffff;

			colorFilter = new ColorMatrixFilter();

			objectImage = new Image( texture );
			objectImage.scaleX = data.d / objectImage.texture.width;
			objectImage.scaleY = objectImage.scaleX;
			objectImage.alignPivot();

			//objectImage.filter = new BlurFilter( 1, 1, 4 );
			addChild( objectImage );

			canvas = new Canvas();
			canvas.alpha = 1;
			canvas.touchable = false;
			//canvas.filter = new BlurFilter( 1, 1, 3 );
			addChildAt( canvas, 0 );

			//this.filter = colorFilter;

			this.x = data.x;
			this.y = data.y;

			this.touchable = false;
		}

		public function drawBackground() : void
		{
			canvas.clear();
			canvas.beginFill( color );
			canvas.drawCircle( 0, 0, data.isUserObject ? data.r* 0.9 : data.r * 0.6 );
			canvas.endFill();
		}

		public function setColor( color : uint ) : void
		{
			this.color = color != 0 ? color : Math.random() * 0xffffff;
			colorFilter.tint( color );
			drawBackground();

			//this.flatten( true );
		}

		public function update() : void
		{
			this.x = data.x;
			this.y = data.y;

			if ( data.r != radius )
			{
				objectImage.scaleX = (data.r * 2) / objectImage.texture.width;
				objectImage.scaleY = objectImage.scaleX;

				drawBackground();
			}
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
