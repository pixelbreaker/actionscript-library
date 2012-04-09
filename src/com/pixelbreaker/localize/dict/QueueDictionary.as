package com.pixelbreaker.localize.dict
{
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import com.pixelbreaker.loaders.IQueueLoader;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.events.ProgressEvent;

	public class QueueDictionary extends EventDispatcher implements IQueueLoader
	{
		private var _xml:XML;
		private var _xmlList:XMLList;
		private var _urlLoader:URLLoader;
		
		public function QueueDictionary()
		{
			_urlLoader = new URLLoader();
		}
		
		public function loadAsset( request:URLRequest=null, args:Array=null ):void
		{
			_urlLoader.addEventListener( ProgressEvent.PROGRESS, _onProgress );
			_urlLoader.addEventListener( Event.COMPLETE, _onComplete );
			_urlLoader.load( request );
		}
		
		private function _onProgress( e:ProgressEvent ):void
		{
			dispatchEvent( new ProgressEvent( ProgressEvent.PROGRESS, false, false, e.bytesLoaded, e.bytesTotal ) );
		}
		
		private function _onComplete( e:Event ):void
		{
			_xml = new XML( String( _urlLoader.data ) );
			_xmlList = _xml..text as XMLList;//elements( "text" );
			dispatchEvent( new Event( Event.COMPLETE ) );
		}
		
		
		public function getStyle( id:String):String{
			var textNode:XMLList = _xmlList.( @id == id );
			var style:String = textNode.attribute("style");	
			return style;
		}
		
		public function getPlainText( id:String )
		 : String{
			var textNode:XMLList = _xmlList.( @id == id );
			var text:String = textNode.text();
			return text;
		}
		
		public function getText( id:String, overrideCssClass:String=null ):String
		{
			var textNode:XMLList = _xmlList.( @id == id );
			
			var style:String = textNode.attribute("style");
			var text:String = textNode.text();
			////trace("QueueDictionary.getText("+id+")::style="+style);
			if( text == null || text == ""){ 
				return "<span class='error'>"+ id + " is undefined</span>";
			}
			
			if(style == null || style == ""){
				style = "body";
			}
			
			if (overrideCssClass != null){
				style = overrideCssClass;
			}
			////trace("QueueDictionary.getText("+id+")::text before search/replace="+text);
			
			//make the embedded fonts display bold weights correctly
			/*
			 * We do this because the bold version of a font is not necessaruly the same typeface as the regular version.
			 * For example, Futura has about 9 different variants, e.g. Futura MT Bold, Futura MT Italic, Futura Light Italic, etc.
			 * These are all seperate fonts, and Flash won't automatically know which one we intend to use, nor which one is embedded.
			 * 
			 * As a workaround, we create a ".bold" CSS class in the stylesheet, and use a search and replace to convert <b> and <i> tags into
			 * <span class="bold">. 
			 * 
			 * This means that we can specify different fonts for bold and italic weights, and also ensure that the correct embedded fonts are 
			 * used when we're working with bold and italic text.
			 *
			 * TODO - Do some tests with nested HTML tags in the character data, e.g. <b><i>Bold Italic Text</i></b>  
			 * 
			 */
			
			//BEGIN SEARCH/REPLACE
			//replace closing bold tags
			var replaceOpeningBoldTags:RegExp = /<b>/g;  
 			var replaceClosingBoldTags:RegExp = /<\/b>/g;
			
 			text = text.replace(replaceOpeningBoldTags, "<span class=\"bold\">");;  
			text = text.replace(replaceClosingBoldTags, "</span>");
			
			//replace closing italic tags
			var replaceOpeningItalicTags:RegExp = /<i>/g;  
 			var replaceClosingItalicTags:RegExp = /<\/i>/g;
			
 			text = text.replace(replaceOpeningItalicTags, "<span class=\"italic\"><i>");;  
			text = text.replace(replaceClosingItalicTags, "</i></span>");
			
			//
			//END SEARCH/REPLACE
			
			//trace("QueueDictionary.getText("+id+")::text after search/replace="+text);
			text = "<span class='"+style+"'>"+ text + "</span>";
			return text;
		}
		
		public function getBytesLoaded():uint
		{
			return _urlLoader.bytesLoaded;
		}
		
		public function getBytesTotal():int
		{
			return _urlLoader.bytesTotal;
		}
		
		public function getPercentageLoaded():Number
		{
			if( _urlLoader.bytesTotal < 4 ) return 0;
			return _urlLoader.bytesLoaded/_urlLoader.bytesTotal;
		}	
		
		public override function toString() : String {
			return _xml.toString();
		}
	}
}