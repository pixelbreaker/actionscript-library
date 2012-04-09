package com.pixelbreaker.motion
{
	import com.pixelbreaker.accessors.IAccessor;
	import com.pixelbreaker.events.AnimationEvent;
	
	import flash.events.EventDispatcher;
	
	public class FrictionAccessor extends EventDispatcher implements IAnimate
	{
		// arguments
		public var rate				:Number;
		public var friction			:Number;
		
		// properties
		private var accessor			:IAccessor;
		private var pixelSnapping	:Boolean;
		
		private var end					:Number;
		
		private var currentVal		:Number;
		
		private var speed				:Number;
		private var accel				:Number;
		
		private var started			:Boolean;
		
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
		public function FrictionAccessor( accessor:IAccessor, rate:Number = NaN, friction:Number = NaN )
		{
			// arguments
			this.accessor = accessor;
			this.rate = isNaN( rate )? MotionSettings.FRICTION_RATE : rate;
			this.friction = isNaN( friction )? MotionSettings.FRICTION_FRICTION : friction;			
			
			// properties
			currentVal = Number( accessor.getValue() );
			speed = 0;
			accel = 0;
			pixelSnapping = MotionSettings.PIXEL_SNAPPING;
			
			started = false;
			
			// references
			controller = MotionControl.getInstance();
		}
		
		public function goto( value:Number ):void
		{
			currentVal = accessor.getValue();
			controller.removeConflicts( this );
			end = value;
			start();	
		}
		
		public function forceTo( value:Number ):void
		{
			stop();
			speed = 0;
			accel = 0;
			currentVal = value;
			accessor.setValue( value );
		}
		
		public function step():void
		{
			if( !started || ( Math.abs( accel ) > MotionSettings.FRICTION_PRECISION && Math.abs( speed ) > MotionSettings.FRICTION_PRECISION && Math.abs( end - currentVal ) > MotionSettings.FRICTION_PRECISION ) )
			{
				started = true;
				accel = ( end - currentVal ) * rate;
				speed = ( speed * friction) + accel;
				currentVal += speed;
				
				var setValue:Number = currentVal;
				if( pixelSnapping ) setValue = Math.round( setValue );	
				
				accessor.setValue( setValue );
				
				dispatchEvent( new AnimationEvent( AnimationEvent.PROGRESS ) );
			}
			else
			{
				currentVal = end;
				accessor.setValue( currentVal );
				controller.removeAnimation( this );
				started = false;
	
				dispatchEvent( new AnimationEvent( AnimationEvent.PROGRESS ) );
				dispatchEvent( new AnimationEvent( AnimationEvent.COMPLETE ) );
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
		
		public function getTarget():Object
		{
			return {
				scope: accessor.getScope(),
				property: accessor.getProperty()
			};
		}
		
		public function getDelay():uint
		{
			return 0;
		}
	}
}