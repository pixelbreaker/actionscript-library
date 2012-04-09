package com.pixelbreaker.localize.text
{
	import flash.text.AntiAliasType;
	import flash.text.StyleSheet;
	import flash.text.TextField;		
	public class TextFieldLocal extends TextField
	{
		private var _defaultStyle:Object;
		
		public function TextFieldLocal()
		{
			super();
			wordWrap = true;
			selectable = false;
			if( GlobalStyleSheet.getInstance().loaded ){
				trace("TextFieldLocal.TextFieldLocal::getting style sheet");
				styleSheet = GlobalStyleSheet.getInstance();
			}
		}
		
		public override function set styleSheet( css:StyleSheet ):void
		{
			super.styleSheet = css;
			_defaultStyle = css.getStyle( 'body' );
			//Debug.log( _defaultStyle.fontFamily );

			if( _defaultStyle == null )
			{
				throw new Error( 'no "body" class set in CSS' );
				return;
			}			
			
			var ff:String = _defaultStyle.fontFamily;
			
			switch( ff )
			{
				case '_sans':
				case '_serif':
				case '_typewriter':
				case 'sans-serif':
				case 'serif':
				case 'mono':
					antiAliasType = AntiAliasType.NORMAL;
					embedFonts = false;
				break;
				
				default:
					antiAliasType = AntiAliasType.ADVANCED;
					embedFonts = true;
				break;	
			}
		}
		
		public override function set htmlText( value:String ):void
		{
			if( _defaultStyle != null )
			{
				super.htmlText = '<body>' + value + '</body>'; 
				// previously code was '<body>' + value + '<br /></body>';
				// TODO: find out if extra <br/> actually served any purpose
				return;
			}
			super.htmlText = value + '<br />';
		}
		
		public override function set text( value:String ):void
		{
			throw new Error( "must use htmlText property" );	
		}
	}
}