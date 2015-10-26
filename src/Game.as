package
{
	import starling.display.Sprite;
	import starling.events.Event;

	public class Game extends Sprite
	{
		public function Game()
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler );
		}

		private function addedToStageHandler( event : Event ) : void
		{
			Facade.instance.initFacade( this );
		}
	}
}
