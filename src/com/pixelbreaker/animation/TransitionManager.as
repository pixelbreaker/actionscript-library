package com.pixelbreaker.animation{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import com.pixelbreaker.animation.transitionitems.Wait;
	import com.pixelbreaker.animation.ITransitionObject;

	public class TransitionManager extends MovieClip {

		private var $queueArray : Array;
		private var $working : Boolean;
		private var $totalQueues : int;
		private static var $instance : TransitionManager;
		
		public function TransitionManager():void{
			trace("AnimationManager()");
			
			init();
		}
		
		public function init() : void {
			trace("AnimationManager.init()");
			$queueArray = new Array();
			$working = false;
			$totalQueues = 0;
			//easingLib = new EasingLib();
		}
	
	
		public function stopQueue() : void {
			//trace("AnimationManager.stopQueue()");
			this.removeEventListener(Event.ENTER_FRAME,executeQueue);
			$working = false;
		}

		public function startQueue() : void {
			//trace("AnimationManager.startQueue()");
			this.addEventListener(Event.ENTER_FRAME, executeQueue);
			$working = true;		
		}
			
		
		public function clearAllTweens() : void {
			//trace("AnimationManager.clearAllTweens()");
			for (var i in $queueArray){
				delete $queueArray[i];
			}
			$queueArray = new Array();	
		}
		
		private function executeQueue(e:Event) : void {
			//trace("AnimationManager.executeQueue()" + e);
			var i:String;
			var tr:String;
			
			for ( i in $queueArray){
				tr+=":"+i;
				if ($queueArray[i].length > 0){
					var tweenStatus:Boolean;
					$working = true;
					tweenStatus = $queueArray[i][0].execute();
					if (!tweenStatus){
						//trace("TweenManager.executeQueue::"+i+" next object");
						$queueArray[i].shift();
						if ($queueArray[i].length == 0){
							//trace("TweenManager.executeQueue::queue "+i+" finished");
							delete $queueArray[i];
							$totalQueues --;
						}
					}
				}
			}
			
			//trace("TweenManager.executeQueue::queues:"+tr);
			//trace("TweenManager.executeQueue::$queueArray.length="+$queueArray.length);
			if ($totalQueues == 0){
				//trace("TweenManager.executeQueue::all queues empty");
				$working = false;
				doneAllTransitions();
				stopQueue();
			}
	}
		
	private function doneAllTransitions():void{
		//trace("AnimationManager.doneAllTransitions()");
		$working = false;
		this.removeEventListener(Event.ENTER_FRAME,executeQueue);
	}
		
	public function get working():Boolean {
		//trace("TransitionManager.working()");
		return $working;
	}
	
	private function addQueue(name:String):void{
		//trace("TransitionManager.addQueue("+name+")");
		$queueArray[name] = new Array();
		$totalQueues ++;
	}
	public function removeQueue(name:String):void{
		for (var i in $queueArray){
			//trace("$queueArray[i]: " + $queueArray[i]+", name: " + name);
			
			//fixed rather nasty comparison bug here, should actually work now! - ar - 16/7
			if(i == name){
				delete $queueArray[i];
				if($totalQueues>0){
					$totalQueues --;
				}
			}
		}
		
	}
	public function addItem(txObject:ITransitionObject,queue:String):Boolean{
		//trace("AnimationManager.addTween("+txObject+","+queue+")");
		if (queue == null){
			queue = "default";
		}
		
		if ($queueArray[queue] == null){
			addQueue(queue);
		}
		
		$queueArray[queue].push(txObject);
		$working = true;
		startQueue();
		return true;
	}
	
	public function wait(queue:String,frames:Number) : void {
		//trace("TweenManager.wait("+queue+","+ frames+")");
		var w:Wait = new Wait(frames);
		addItem(w,queue);
	}

	/**
	 * @return singleton instance of TransitionManager
	 */
	public static function get instance() : TransitionManager {
		//trace("TransitionManager.instance()");
		if ($instance == null)
			$instance = new TransitionManager();
		return $instance;
	}
		
  }
}