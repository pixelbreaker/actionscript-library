package com.pixelbreaker.loaders
{
	import flash.net.URLRequest;
	import flash.events.IEventDispatcher;
	
	public interface IQueueLoader extends IEventDispatcher
	{
		function loadAsset( request:URLRequest = null, args:Array = null ):void;
		function getBytesLoaded():uint;
		function getBytesTotal():int;
		function getPercentageLoaded():Number;
	}
}