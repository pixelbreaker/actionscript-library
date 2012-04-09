package com.pixelbreaker.debug.external
{
	import com.pixelbreaker.utils.ArrayUtils;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;

	public class FrameRate
	{
		private var sprite:Sprite;
		private var startSec:int;
		private var currTime:int;
		private var lastTime:int;
		
		private var history:Array;
		
		private var extDebug:ExtDebug;
		
		public function FrameRate( extDebug:ExtDebug )
		{
			this.extDebug = extDebug;
			sprite = new Sprite();
			startSec = getTimer();
			history = new Array();
			
			sprite.addEventListener( Event.ENTER_FRAME, enterFrame );
		}
		
		private function enterFrame( e:Event ):void
		{
			currTime = getTimer();
			history.push( 1000 / ( currTime - lastTime ) );
			
			if( getTimer() - startSec > 1000 )
			{
				var n:Number = Math.round( ArrayUtils.average( history ) );
				if( isNaN( n ) ) n = 0;
				extDebug.frametime( n );
				history = new Array();
				startSec = getTimer();
			}
			lastTime = currTime;
		}
	}
}