package com.pixelbreaker.motion
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import com.pixelbreaker.utils.ArrayUtils;
	import com.pixelbreaker.utils.ObjectUtils;
	
	public final class MotionControl extends Sprite
	{
		private static var instance:MotionControl;
		
		private var animList:Array;
		
		public static function getInstance():MotionControl
		{
			if( instance == null ) instance = new MotionControl( new SingletonEnforcer() );
			return instance;
		}
		
		public function MotionControl( pvt:SingletonEnforcer )
		{
			_init();
		}	
		
		private function _init():void
		{
			animList = new Array();
			
			addEventListener( Event.ENTER_FRAME, step );
		}
		
		private function step( e:Event ):void
		{
//			Debug.log( 'step', Debug.EVENT );
			var i:uint;
			for( i = 0; i < animList.length; i++ )
			{
				IAnimate( animList[ i ] ).step();
			}
		}
		
		/**
		 * Add an animation to the list, must implement IAnimate
		 * 
		 * @param anim IAnimate
		 */
		public function addAnimation( anim:IAnimate ):void
		{
			if( ArrayUtils.indexOf( animList, anim ) == -1 )
			{
				animList.push( anim );
			}
		}
		
		/**
		 * Remove an animation from the list, if it exists, must implement IAnimate
		 * 
		 * @param anim IAnimate
		 */
		public function removeAnimation( anim:IAnimate ):void
		{
			while( ArrayUtils.indexOf( animList, anim) != -1 )
				animList.splice( ArrayUtils.indexOf( animList, anim ), 1 );
		}
		
		/**
		 * Find any other animations in the list that are manipulating the same properties and remove them
		 * 
		 * @param anim IAnimate
		 */
		public function removeConflicts( anim:IAnimate ):void
		{
			var cAnim:IAnimate;
			for( var i:uint = 0; i < animList.length; i++ )
			{
				cAnim = animList[ i ];
				if( cAnim != anim )
				{
					if( ObjectUtils.matchProperties( cAnim.getTarget(), anim.getTarget() ) )
					{
						if( anim != cAnim && cAnim.getDelay() <= anim.getDelay() )
						{
							 animList.splice( i--, 1 );
						}		
					}
				}
			}
		}
		
		/**
		 * Remove any animations that manipulate the scope/property passed in
		 * 
		 * @param scope Object
		 * @param property String
		 */
		public function explicitRemove( scope:Object, property:String ):void
		{
			var compareObject:Object = { scope: scope, property: property };
			var cAnim:IAnimate;
			for( var i:uint = 0; i < animList.length; i++ )
			{
				cAnim = animList[ i ];
				if( ObjectUtils.matchProperties( cAnim.getTarget(), compareObject ) )
				{
					animList.splice( i--, 1 );		
				}
			}	
		}
		
		/**
		 * Returns the number of active animations
		 * 
		 * @return Number
		 */
		public function getAnimCount():int
		{
			return animList.length;	
		}
	}
}

internal class SingletonEnforcer{}