package
{
	import com.far.test.Stats;
	import com.far.utils.collisions.HitTest;
	import com.far.utils.displayobject.DrawShape;
	import com.far.utils.filter.FilterUtil;

	import flash.display.Sprite;
	import flash.events.Event;

	[SWF(width="1440", height="900")]
	public class farutils extends Sprite
	{
		private var _balls:Array;
		private var clock:Sprite;
		private var _speed:int=10;

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
			addChild(new Stats());

		}

	}
}
