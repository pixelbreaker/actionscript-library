package com.pixelbreaker.animation.transitionitems {
	import com.pixelbreaker.animation.ITransitionObject;

	/**
	 * @author Alias Cummins
	 */
	public class Transition  implements ITransitionObject{
		
		private var $target:Object;
		private var $time:Number;
		private var $duration:Number;
		private var $startValues:Object;
		private var $easingFunction:Function;
		private var $properties:Object;
		public var finished:Boolean;
		
		public function Transition(target:Object,properties:Object,easing:Function,duration:Number){
			$target = target;
			$time = 0;
			$duration = int(duration);
			$properties = properties;
			$easingFunction = easing;
			finished = false;
		}
		
	
		public function execute():Boolean{
			var func:Function = $easingFunction;
			var i:*;
			if ($startValues == null){
				$startValues = new Object();
				for (i in $properties){
					$startValues[i] = $target[i];
				}
			}
			
			if ($time < $duration){
				for (i in $properties){
					var b:Number = $startValues[i];
					var c:Number = $properties[i] - b;
					var d:Number = $duration;
					$target[i] = func($time, b, c, d);
					//trace("Transition.execute::$target["+i+"]=="+$target[i]);
				}
				$time++;
				return true;
			}else{
				for (i in $properties){
					$target[i] = $properties[i];
				}
				finished = true;
				//clean up to avoid wasting memory
				return false;
			}
			
		}
		
		
	}
}