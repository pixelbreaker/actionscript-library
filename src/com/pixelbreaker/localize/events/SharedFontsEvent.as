package com.pixelbreaker.localize.events {
	import flash.events.Event;	
	
	/**
	 * @author Alias Cummins
	 */
	public class SharedFontsEvent extends Event {
		public static const AllFontsLoaded:String = 'allFontsLoaded';
		public static const DictionaryLoaded:String = 'dictionaryLoaded';
		public static const StylesheetLoaded:String = 'stylesheetLoaded';
		
		public function SharedFontsEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
		}
		
	}
}
