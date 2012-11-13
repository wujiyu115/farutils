package
{

	import com.far.utils.displayobject.DrawShape;
	import com.far.utils.load.NetLoad;
	import com.sociodox.theminer.TheMiner;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

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
			var storyVo:StoryVo=new StoryVo();
			storyVo.sid=1;
			storyVo.praise=3;
			for (var i:String in storyVo)
			{
				trace(i);
			}

		}



	}
}

