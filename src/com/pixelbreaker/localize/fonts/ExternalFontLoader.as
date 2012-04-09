package com.pixelbreaker.localize.fonts
{
	import com.pixelbreaker.loaders.IQueueLoader;
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.text.Font;
	import com.pixelbreaker.debug.Debug;

	public class ExternalFontLoader extends EventDispatcher implements IQueueLoader
	{
		private var fontLoader:Loader;
		
		private var bl:int;
		private var bt:int;
		
		public function ExternalFontLoader()
		{
			bl = bt = 0;
			fontLoader = new Loader();
			fontLoader.contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS, onProgress );
			fontLoader.contentLoaderInfo.addEventListener( Event.COMPLETE, onComplete );
		}
		
		public function loadAsset( request:URLRequest = null, args:Array = null ):void
		{
			fontLoader.load( request );
		}
		
		private function onProgress( e:ProgressEvent ):void
		{
			bl = e.bytesLoaded;
			bt = e.bytesTotal;
			
			dispatchEvent( new ProgressEvent( ProgressEvent.PROGRESS, false, false, bl, bt ) );
		}
		
		private function onComplete( e:Event ):void
		{
			var li:LoaderInfo = fontLoader.contentLoaderInfo;
			var ad:ApplicationDomain = li.applicationDomain;
			var classes:Array = fontLoader.content[ 'fontClasses' ] as Array;

			var i:int;
			for( i=0; i<classes.length; i++ )
			{								
				Font.registerFont( ad.getDefinition( classes[ i ] ) as Class );
				Debug.log( classes[ i ] );
			}
			
			fontLoader.unload();
			
			dispatchEvent( new Event( Event.COMPLETE ) );
		}
		
		public function getBytesLoaded():uint
		{
			return bl;
		}
		
		public function getBytesTotal():int
		{
			return bt;
		}
		
		public function getPercentageLoaded():Number
		{
			if( bt < 4 ) return 0;
				
			return bl / bt;
		}
	}
}