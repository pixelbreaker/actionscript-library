package com.pixelbreaker.structures
{
	import flash.display.Sprite;
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.geom.Matrix;
	
	public class RGBStrip
	{
		//private var container:Sprite;
		private var bitmap:BitmapData;
		
		public function RGBStrip( colors:Array, alphas:Array, ratios:Array )
		{
			var container:Sprite = new Sprite();
		
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox( 1000, 2 );
			container.graphics.beginGradientFill( GradientType.LINEAR, colors, alphas, ratios, matrix );
			container.graphics.drawRect( 0, 0, 1000, 2 );
			container.graphics.endFill();

			bitmap = new BitmapData( container.width, container.height, false );
			bitmap.draw( container );
			
			container = null;
		}
		
		public function getHexAt( perc:Number ):uint
		{
			return bitmap.getPixel( Math.round( 999 * perc ), 1 );
		}		
	}
}