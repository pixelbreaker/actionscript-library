package com.pixelbreaker.loaders
{
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.ProgressEvent;
	import flash.events.Event;
	import flash.system.LoaderContext;

	public class QueueLoader extends Loader implements IQueueLoader
	{
		private var _loaderContext:LoaderContext;
		
		public function QueueLoader()
		{
			contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS, _loadProgress );
			contentLoaderInfo.addEventListener( Event.COMPLETE, _loadComplete );
		}
		
		private function _loadProgress( e:ProgressEvent ):void
		{
			dispatchEvent( new ProgressEvent( ProgressEvent.PROGRESS, false, false, e.bytesLoaded, e.bytesTotal ) );
		}
		
		private function _loadComplete( e:Event ):void
		{
			dispatchEvent( new Event( Event.COMPLETE ) );
		}
		
		public function loadAsset( request:URLRequest = null, args:Array = null ):void
		{
			load( request, _loaderContext );
		}
		
		public function getBytesLoaded():uint
		{
			return contentLoaderInfo.bytesLoaded;	
		}
		
		public function getBytesTotal():int
		{
			return contentLoaderInfo.bytesTotal;
		}
		
		public function getPercentageLoaded():Number
		{
			if( getBytesTotal() < 4 ) return 0;
			
			return getBytesLoaded()/getBytesTotal();
		}
		
		public function set loaderContext( ldrContext:LoaderContext ):void
		{
			_loaderContext = ldrContext;	
		}
		
		public function get loaderContext():LoaderContext
		{
			return _loaderContext;	
		}
	}
}