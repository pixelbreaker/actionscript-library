package com.pixelbreaker.motion
{
	import com.pixelbreaker.accessors.IAccessor;
	import com.pixelbreaker.events.AnimationEvent;
	import com.pixelbreaker.structures.RGB;
	
	import flash.events.EventDispatcher;
	
	public class HexTweenAccessor extends EventDispatcher implements IAnimate
	{
		// arguments
		private var begin				:Number;
		private var end					:uint;
		private var duration			:uint;
		private var easing				:Function;
		private var delay				:uint;
		private var exArgs				:Array;
		private var hasExArgs			:Boolean;
		
		// properties
		private var time				:uint;
		private var accessor			:IAccessor;
		
		private var beginValues		:RGB;
		private var currValues		:RGB;
		private var finalValues		:RGB;
		
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
		public function HexTweenAccessor( accessor:IAccessor, end:uint, duration:Number, easing:Function = null, delay:Number = 0, ex1:Number = NaN, ex2:Number = NaN )
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
			
			beginValues = new RGB( uint( accessor.getValue() ) );
			currValues = new RGB( uint( accessor.getValue() ) );
			finalValues = new RGB( end );
			
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
					var easingArgsR:Array = [ ++time, beginValues.r, finalValues.r-beginValues.r, duration ];
					var easingArgsG:Array = [ time, beginValues.g, finalValues.g-beginValues.g, duration ];
					var easingArgsB:Array = [ time, beginValues.b, finalValues.b-beginValues.b, duration ];
					if( hasExArgs )
					{
						easingArgsR.push( exArgs );
						easingArgsG.push( exArgs );
						easingArgsB.push( exArgs );
					}
					
					currValues.r = easing.apply( null, easingArgsR );
					currValues.g = easing.apply( null, easingArgsG );
					currValues.b = easing.apply( null, easingArgsB );
					
//					trace( currValues.getHex() );
					accessor.setValue( currValues.getHex() );
					
					dispatchEvent( new AnimationEvent( AnimationEvent.PROGRESS ) );
				}
				else
				{
					accessor.setValue( finalValues.getHex() );
					controller.removeAnimation( this );
					
					dispatchEvent( new AnimationEvent( AnimationEvent.COMPLETE ) );
				}
			}
			else
			{
				delay--;
				if( delay == 0 ) beginValues = new RGB( uint( accessor.getValue() ) );
			}
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