package com.pixelbreaker.utils.maths
{
	import com.pixelbreaker.utils.maths.MathUtils;
	/**
	 * @author Gabriel Bucknall
	 */
	public class Radix
	{
		/**
		 * Convert R,G,B to an Hexidecimal number
		 * @param   r 	Number: Red value
		 * @param   g 	Number: Green value
		 * @param   b 	Number: Blue value
		 * @return  
		 */
		public static function toHex(r:Number, g:Number, b:Number):Number
		{
			return (Math.round(r) << 16 | Math.round(g) << 8 | Math.round(b));
		}
		
		/**
		 * Convert an Hexidecimal number to and Object with r, g, and b properties
		 * @param   hex 	Number: Hex number
		 * @return  Object { r:value, g:value, b:value }
		 */
		public static function toDec(hex:Number):Object
		{
			var str:String = hex.toString(16);
			while(str.length < 6) str = "0"+str;
			return { r:parseInt(str.substring(0,2),16), g:parseInt(str.substring(2,4),16), b:parseInt(str.substring(4,6),16) };
		}

		/**
		 * Convert an Hexidecimal number to and Object with r, g, and b properties
		 * @param   hex 	Number: Hex number
		 * @return  Object { r:value, g:value, b:value }
		 */
		public static function toDecARGB( hex:uint ):Object
		{
			var str:String = hex.toString(16);
			while(str.length < 8) str = "0"+str;
			return { a:parseInt(str.substring(0,2),16), r:parseInt(str.substring(2,4),16), g:parseInt(str.substring(4,6),16), b:parseInt(str.substring(6,8),16) };
		}
		
		/**
		 * Multiply a Hex value by a decimal amount and return the resulting hex.
		 * 
		 * Care is need when multiplying Colours by more than 1, as values may exceed 255 and break colour rendering.
		 * @usage   
		 * @param   hex  	Number: Input Hex value
		 * @param   perc 	Number: amount to multiply by
		 * @return  Number
		 */
		public static function percHex(hex:Number,perc:Number):Number
		{
			var col:Object = Radix.toDec(hex);
			return Radix.toHex(
				MathUtils.constrain(Math.round(col.r*perc),0,255),
				MathUtils.constrain(Math.round(col.g*perc),0,255),
				MathUtils.constrain(Math.round(col.b*perc),0,255)
			);
		}
		
		/**
		 * Create a Number from a standard Hex String e.g "FF0000" would convert to 0xFF0000
		 * @param   hexStr 	String: Hexidecimal string without preceeding "#"
		 * @return  Number
		 */
		public static function toHexFromHexStr(hexStr:String):Number
		{
			hexStr = hexStr.substr (-6, 6);
			return parseInt (hexStr, 16);
		}
	
		/**
		 * Convert a Hex Number to standard Hex String without preceeding "#"
		 * @param   hex 	Number: Input hex number
		 * @return 	String 
		 */
		public static function toHexStrFromHex(hex:Number):String
		{
			var col:Object = Radix.toDec(hex);
			var rad:String = "0123456789ABCDEF";
			var r:String = rad.charAt(col.r/16) + rad.charAt(col.r%16);
			var g:String = rad.charAt(col.g/16) + rad.charAt(col.g%16);
			var b:String = rad.charAt(col.b/16) + rad.charAt(col.b%16);
			return r+g+b;
		}
	}
}