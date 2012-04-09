package com.pixelbreaker.loaders
{
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.media.SoundLoaderContext;
	public class QueueSound extends Sound implements IQueueLoader
	{
		public function QueueSound( stream:URLRequest = null, context:SoundLoaderContext = null )
		{
			super( stream, context );
		}
		
		public function getBytesLoaded():uint
		{
			return bytesLoaded;	
		}
		
		public function getBytesTotal():int
		{
			return bytesTotal;	
		}
		
		public function get percentageLoaded():Number
		{
			if( bytesTotal < 4 ) return 0;
			return bytesLoaded/bytesTotal;
		}
		
		public function loadAsset(request:URLRequest = null, args:Array = null):void
		{
		}
		
		public function getPercentageLoaded():Number
		{
			if( getBytesTotal() < 4 ) return 0;
			
			return getBytesLoaded()/getBytesTotal();
		}
	}
}