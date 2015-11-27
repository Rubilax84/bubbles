package
{

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.system.Capabilities;

	import starling.core.Starling;
	import starling.textures.RenderTexture;

	import utils.math.Gauss;

	[SWF(frameRate=60, backgroundColor='0x000000', width='800', height='600')]
	public class Main extends Sprite
	{
		private var _starling : Starling;

		public function Main()
		{
			if ( stage ) init( null );
			else addEventListener( Event.ADDED_TO_STAGE, init, false, 0, true );
		}

		private function init( event : Event ) : void
		{
			if ( event ) removeEventListener( Event.ADDED_TO_STAGE, init );

			Starling.handleLostContext = true; // recommended everywhere when using AssetManager
			RenderTexture.optimizePersistentBuffers = true; // should be safe on Desktop

			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;

			_starling = new Starling( Game, stage );
			_starling.enableErrorChecking = Capabilities.isDebugger;
			_starling.showStats = true;

			_starling.start();

		}

	}
}
