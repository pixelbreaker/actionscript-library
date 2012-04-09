package com.pixelbreaker.loaders
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class QueueURLLoader extends URLLoader implements IQueueLoader
	{
		public function QueueURLLoader( request:URLRequest = null )
		{
			super( request );
		}
		
		public function loadAsset( request:URLRequest = null, args:Array = null ):void
		{
			load( request );	
		}

		public function getBytesLoaded():uint
		{
			return bytesLoaded;	
		}
		
		public function getBytesTotal():int
		{
			return bytesTotal;	
		}
		
		public function getPercentageLoaded():Number
		{
			if( bytesTotal < 4 ) return 0;
			return bytesLoaded/bytesTotal;
		}
	}
}