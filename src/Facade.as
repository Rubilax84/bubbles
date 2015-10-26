/**
 * Created by Dryaglin on 24.10.2015.
 */
package
{

	import controller.AssetsLoadController;
	import controller.GameFieldController;
	import controller.GameStateController;
	import controller.GameWorldController;

	import flash.utils.Dictionary;

	import model.GameAssetsManager;
	import model.world.GameWorld;

	import starling.display.Sprite;

	import view.GameField;

	public class Facade
	{
		private static var _instance : Facade;

		private var _display : Sprite;

		public var dataStorage : Dictionary;
		public var viewStorage : Dictionary;
		public var controllersStorage : Dictionary;

		public function Facade()
		{
			trace( this, 'created!' );
		}

		public function initFacade( disaplay : Sprite ) : void
		{
			this._display = disaplay;

			initDataModel();
			initView();
			initControllers();

			loadAssets();
		}

		private function initDataModel() : void
		{
			dataStorage = new Dictionary();

			//add game world model
			dataStorage[GameWorld.NAME] = new GameWorld();
			//add assets manager
			dataStorage[GameAssetsManager.NAME] = new GameAssetsManager();
		}

		private function initView() : void
		{
			viewStorage = new Dictionary();

			//add game space
			viewStorage[GameField.NAME] = new GameField( _display );
		}

		private function initControllers() : void
		{
			controllersStorage = new Dictionary();

			//add assets load controller
			controllersStorage[AssetsLoadController.NAME] = new AssetsLoadController();
			//add game world controller
			controllersStorage[GameWorldController.NAME] = new GameWorldController();
			//add game field controller
			controllersStorage[GameFieldController.NAME] = new GameFieldController();
			//add game sate controller
			controllersStorage[GameStateController.NAME] = new GameStateController();

		}

		private function loadAssets() : void
		{
			(controllersStorage[AssetsLoadController.NAME] as AssetsLoadController).initialize();
		}

		public function get assetsManager() : GameAssetsManager
		{
			return dataStorage[GameAssetsManager.NAME] as GameAssetsManager;
		}

		public static function get instance() : Facade
		{
			if ( !_instance )
				_instance = new Facade();
			return _instance;
		}

		public function get display() : Sprite
		{
			return _display;
		}
	}
}
