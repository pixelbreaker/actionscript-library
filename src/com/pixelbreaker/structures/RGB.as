package com.pixelbreaker.structures
{
	public class RGB
	{
		/**
		 * Red component
		 */
		public var r:Number;
		/**
		 * Green component
		 */
		public var g:Number;
		/**
		 * Blue component
		 */
		public var b:Number;
		
		/**
		 * Create new intance of RGB
		 * 
		 * @usage
		 * <code>
		 * var myCol:RGB = new RGB( 0xFF0000 );
		 * 
		 * textField.textColor = myCol.getHex();
		 * </code>
		 * 
		 * @param hex Color value to initialize with
		 */
		public function RGB( hex:Number )
		{
			var hexStr:String = hex.toString( 16 );
			while( hexStr.length < 6 ) hexStr = '0' + hexStr;
			r = parseInt( hexStr.substring(0,2), 16 );
			g = parseInt( hexStr.substring(2,4), 16 );
			b = parseInt( hexStr.substring(4,6), 16 );
		}
		
		public function getHex():Number
		{
			return ( Math.round( r ) << 16 | Math.round( g ) << 8 | Math.round( b ) );	
		}
		
		/**
		 * returns a duplicate instance
		 * 
		 * @usage
		 * <code>
		 * 	var myCol:RGB = new RGB( 0xFF0000 );
		 * 	
		 * 	var myCol2:RGB = myCol.clone();
		 * </code>
		 */
		public function clone():RGB
		{
			return new RGB( getHex() );	
		}
		
		/**
		 * returns a string of the r,g,b values
		 */
		public function toString():String
		{
			var str:String = 'RGB:\n';
			str += '\tr: ' + r + '\n';
			str += '\tg: ' + g + '\n';
			str += '\tb: ' + b;
			return str;
		}
		
	}
}