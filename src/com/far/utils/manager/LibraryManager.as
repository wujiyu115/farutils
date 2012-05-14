package  com.far.utils.manager {
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.media.Sound;
	import flash.text.Font;
	
	public class LibraryManager
	{
		private static var libraryManager	: LibraryManager;
		private var _loader					:Loader;
		
		public function LibraryManager() {
			if ( LibraryManager.libraryManager != null ) {
				throw new Error( "Only one LibraryManager instance should be instantiated" );
			}
		}
		
		public static function getInstance():LibraryManager{
			if ( libraryManager == null )
				libraryManager = new LibraryManager();
			return libraryManager;
		}
		
		//----------------------------------------------------------------
		public function setLoader(loader:Loader):void {
			_loader = loader;
		}
		
		public function getLibMc(name:String):MovieClip {
			var classReference:Class = (_loader.contentLoaderInfo.applicationDomain.getDefinition(name) as Class);
			return (new classReference() as MovieClip);
		}
				
		public function getLibSb(name:String):SimpleButton {
			var classReference:Class = (_loader.contentLoaderInfo.applicationDomain.getDefinition(name) as Class);
			return (new classReference() as SimpleButton);
		}
		
		public function getLibSd(name:String):Sound {
			var classReference:Class = (_loader.contentLoaderInfo.applicationDomain.getDefinition(name) as Class);
			return (new classReference() as Sound);
		}
		
		//得到字体类
		public function getLibFontClass(name:String):Font{
			var classReference:Class = (_loader.contentLoaderInfo.applicationDomain.getDefinition(name) as Class);
			return ((new classReference) as Font);
		}
		
	}
}