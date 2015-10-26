/**
 * Created by Dryaglin on 24.10.2015.
 */
package controller
{

	import model.GameAssetsManager;
	import model.world.GameWorld;

	import starling.events.Event;

	import utils.GlobalConstants;

	public class AssetsLoadController
	{
		public static const NAME : String = 'AssetsLoadController';

		public function AssetsLoadController()
		{

		}

		public function initialize() : void
		{
			Facade.instance.assetsManager.addEventListener( GameAssetsManager.ASSETS_COMPLETE, assetsManager_assetsLoadCompleteHandler );
			Facade.instance.assetsManager.loadData( [GlobalConstants.FILE_CONFIG_NAME, GlobalConstants.BUBLE_FILE_NAME] );
		}

		private function assetsManager_assetsLoadCompleteHandler( event : Event ) : void
		{
			(Facade.instance.dataStorage[GameWorld.NAME] as GameWorld).create();
		}
	}
}
