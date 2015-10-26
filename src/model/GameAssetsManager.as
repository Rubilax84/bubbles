/**
 * Created by Dryaglin on 24.10.2015.
 */
package model
{

	import starling.events.Event;
	import starling.utils.AssetManager;

	public class GameAssetsManager extends AssetManager
	{
		public static const NAME : String = 'AssetManager';

		public static const ASSETS_COMPLETE : String = 'assetsLoadComplete';

		public function GameAssetsManager( scaleFactor : Number = 1, useMipmaps : Boolean = false )
		{
			super( scaleFactor, useMipmaps );
		}

		public function loadData( files : Array ) : void
		{
			for ( var i : int = 0; i < files.length; i++ )
			{
				this.enqueue( 'assets/' + files[i] );
			}

			this.loadQueue( onLoadProgress );
		}

		private function onLoadProgress( ratio : Number ) : void
		{
			//trace( "Loading assets, progress:", ratio );

			if ( ratio == 1.0 )
				onAssetsLoaded();
		}

		private function onAssetsLoaded() : void
		{
			this.dispatchEvent( new Event( GameAssetsManager.ASSETS_COMPLETE ) );
		}
	}
}
