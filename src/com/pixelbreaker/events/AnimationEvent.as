package com.pixelbreaker.events
{
	import flash.events.Event;

	public class AnimationEvent extends Event
	{
		public static const START:String = 'animStart';
		public static const PROGRESS:String = 'animProgress';
		public static const COMPLETE:String = 'animComplete';
		
		public static const RENDER:String = 'animRender';
		
		public function AnimationEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}