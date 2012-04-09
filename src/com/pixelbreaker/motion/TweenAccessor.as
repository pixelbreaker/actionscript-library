package com.pixelbreaker.motion
{
	import com.pixelbreaker.events.AnimationEvent;
	import flash.events.EventDispatcher;
	import com.pixelbreaker.accessors.IAccessor;
	
	public class TweenAccessor extends EventDispatcher implements IAnimate
	{
		// arguments
		private var begin				:Number;
		private var end					:Number;
		private var duration			:uint;
		private var easing				:Function;
		private var delay				:uint;
		private var exArgs				:Array;
		private var hasExArgs			:Boolean;
		
		// properties
		private var time				:uint;
		private var accessor			:IAccessor;
		private var pixelSnapping	:Boolean;
		
		// references
		private var controller		:MotionControl;
		
		/**
		 * Create a new tween
		 * 
		 * @usage
		 * <code>
		 * 
		 * var tween:Tween = new Tween( new PropertyAccessor( movieClip, '_x' ), 200, 30 );
		 * </code>
		 * 
		 * @param accessor An IAccessor implementing instance
		 * @param end Target value of property
		 * @param duration Duration in frames
		 * @param easing [optional] Easing function, if not specified, will use {@link com.pixelbreaker.motion.MotionSettings }.DEFAULT_EASING
		 * @param delay [optional] Delay in frames before easing starts
		 * @param ex1 [optional] Extra param for Elastic and Bounce easing
		 * @param ex2 [optional] Extra param for Elastic and Bounce easing
		 */
		public function TweenAccessor( accessor:IAccessor, end:Number, duration:Number, easing:Function = null, delay:Number = 0, ex1:Number = NaN, ex2:Number = NaN )
		{
			// arguments
			this.accessor = accessor;
			this.end = end;
			this.duration = duration;
			this.easing = easing || MotionSettings.DEFAULT_EASING;
			this.delay = delay;
			
			exArgs = [];
			if( !isNaN( ex1 ) ) exArgs.push( ex1 );
			if( !isNaN( ex2 ) ) exArgs.push( ex2 );
			hasExArgs = exArgs.length > 0;
			
			// properties
			time = 0;
			begin = Number( accessor.getValue() );
			pixelSnapping = MotionSettings.PIXEL_SNAPPING;
			
			// references
			controller = MotionControl.getInstance();
			
			start();
		}
		
		public function step():void
		{
			if( delay == 0 )
			{
				if( time == 0 )
				{
					controller.removeConflicts( this );
					
					dispatchEvent( new AnimationEvent( AnimationEvent.START ) );
				}	
				
				if( time < duration )
				{
					var easingArgs:Array = [ ++time, begin, end-begin, duration ];
					if( hasExArgs ) easingArgs.push( exArgs );
					
					var setValue:Number = easing.apply( null, easingArgs );
					if( pixelSnapping == true ) setValue = int( setValue );	
					
					accessor.setValue( setValue );
					
					dispatchEvent( new AnimationEvent( AnimationEvent.PROGRESS ) );
				}
				else
				{
					accessor.setValue( end );
					controller.removeAnimation( this );
					
					dispatchEvent( new AnimationEvent( AnimationEvent.COMPLETE ) );
				}
			}
			else
			{
				delay--;
				if( delay == 0 ) begin = Number( accessor.getValue() );
			}
		}
		
		public function setPixelSnapping( b:Boolean ):void
		{
			pixelSnapping = b;	
		}
			
		public function stop():void
		{
			controller.removeAnimation( this );
		}
	
		public function start():void
		{
			controller.addAnimation( this );
		}
		
		public function reverse():void
		{
			var b:Number = begin;
			begin = end;
			end = b;
			time = duration - time;
			start();
		}
	
		public function getTarget():Object
		{
			return {
				scope: accessor.getScope(),
				property: accessor.getProperty()
			};
		}
		
		public function getDelay():uint
		{
			return delay;
		}
	}
}