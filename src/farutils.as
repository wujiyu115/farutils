package
{
	import flash.display.Sprite;
	import flash.events.Event;

	[SWF(width="1440", height="900")]
	public class farutils extends Sprite
	{

		public function farutils()
		{
			if (stage == null)
			{
				addEventListener(Event.ADDED_TO_STAGE, init, false, 0, true);
			}
			else
			{
				init();
			}
		}

		private function init(e:Event=null):void
		{
		}
	}
}

