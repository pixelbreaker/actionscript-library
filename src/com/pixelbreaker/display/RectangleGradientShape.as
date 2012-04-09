package com.pixelbreaker.display
{
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.display.GradientType;
	public class RectangleGradientShape extends Shape
	{
		private var _w:Number = 50;
		private var _h:Number = 50;
		private var _r:Number = 0;
		
		private var _bC:Number = NaN;
		private var _b:Number = NaN;
		
		private var _type:String = GradientType.LINEAR;
		private var _colors:Array;
		private var _alphas:Array;
		private var _ratios:Array;
		private var _matrix:Matrix;

		
		
		public function RectangleGradientShape()
		{
			_render();
		}
		
		private function _render():void
		{
			graphics.clear();
			if( !isNaN( _b ) ||  _b > 0 ) graphics.lineStyle( _b, _bC, 1, true );
			if( _colors != null ) graphics.beginGradientFill( _type, _colors, _alphas, _ratios, _matrix );
			if( _r > 0 ) graphics.drawRoundRect( 0, 0, _w, _h, _r, _r );
			else graphics.drawRect( 0, 0, _w, _h );
			if( _colors != null ) graphics.endFill();
		}
		
		public override function set width( value:Number ):void
		{
			_w = value;
			_render();
		}
		
		public override function get width():Number
		{
			return _w;
		}
		
		public override function set height( value:Number ):void
		{
			_h = value;
			_render();
		}
		
		public override function get height():Number
		{
			return _h;
		}
		
		public function set fillColors( value:Array ):void
		{
			_colors = value;
			_render();
		}
		
		public function get fillColors():Array
		{
			return _colors;
		}
		
		public function set fillAlphas( value:Array ):void
		{
			_alphas = value;
			_render();
		}
		
		public function get fillAlphas():Array
		{
			return _alphas;
		}
		
		public function set fillRatios( value:Array ):void
		{
			_ratios = value;
			_render();
		}
		
		public function get fillRatios():Array
		{
			return _ratios;
		}
		
		public function set fillMatrix( value:Matrix ):void
		{
			_matrix = value;
			_render();
		}
		
		public function get fillMatrix():Matrix
		{
			return _matrix;
		}
		
		public function set borderColor( value:Number ):void
		{
			_bC = value;
			_render();
		}
		
		public function get borderColor():Number
		{
			return _bC;
		}
		
		public function set border( value:int ):void
		{
			_b = value;
			_render();
		}
		
		public function get border():int
		{
			return _w;
		}
		
		public function set radius( value:uint ):void
		{
			_r = value;
			_render();
		}
		
		public function get radius():uint
		{
			return _r;
		}
		
	}
}