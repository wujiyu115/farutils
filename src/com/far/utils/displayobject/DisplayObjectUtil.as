package   com.far.utils.displayobject
{
	import flash.display.DisplayObjectContainer;
	import flash.utils.ByteArray;

	public class DisplayObjectUtil
	{
		public function DisplayObjectUtil()
		{
		}
		/**
		 * 
		 * @param container
		 * 
		 */		
		public static function removeAllChildren(container:DisplayObjectContainer):void
		{
			while(container.numChildren > 0)
			{
				container.removeChildAt(0);
			}
		}
	}
}