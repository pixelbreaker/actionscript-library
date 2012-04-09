package com.pixelbreaker.events {
	import flash.events.Event;	
	import flash.events.IEventDispatcher;	
/**
	 * @author CumminsA
	 */
	public class SWFAddressEvent extends Event implements IEventDispatcher {
		public function SWFAddressEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
		}		
		
		public function dispatchEvent(event : Event) : Boolean {
			return null;
		}		
		
		public function hasEventListener(type : String) : Boolean {
			return null;
		}		
		
		public function willTrigger(type : String) : Boolean {
			return null;
		}		
		
		public function removeEventListener(type : String, listener : Function, useCapture : Boolean = false) : void {
		}		
		
		public function addEventListener(type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false) : void {
		}
	}
}
