package com.pixelbreaker.display
{
	import flash.display.Shape;
	
	public class RectangleShape extends Shape
	{
		private var _w:Number = 50;
		private var _h:Number = 50;
		private var _r:Number = 0;
		
		private var _fC:Number = NaN;
		private var _bC:Number = NaN;
		private var _b:Number = NaN;
		
		
		public function RectangleShape()
		{
			_render();
		}
		
		private function _render():void
		{
			graphics.clear();
			if( !isNaN( _b ) ) graphics.lineStyle( _b, _bC, 1, true );
			if( !isNaN( _fC ) ) graphics.beginFill( _fC, 1 );
			if( _r > 0 ) graphics.drawRoundRect( 0, 0, _w, _h, _r, _r );
			else graphics.drawRect( 0, 0, _w, _h );
			if( !isNaN( _fC ) ) graphics.endFill();
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
		
		public function set fillColor( value:Number ):void
		{
			_fC = value;
			_render();
		}
		
		public function get fillColor():Number
		{
			return _fC;
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