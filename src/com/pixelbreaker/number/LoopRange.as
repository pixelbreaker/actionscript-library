package com.pixelbreaker.number
{
	public class LoopRange
	{
		public var min:int;
		public var max:int;
		
		private var _current:int;
		
		function LoopRange( min:int, max:int )
		{
			this.min = min;
			this.max = max;
			_current = min;
		}
		
		public function get next():int
		{
			_current = _current+1 <= max? _current+1 : min;
			return _current;	
		}
		
		public function get previous():int
		{
			_current = _current-1 >= min? _current-1 : max;
			return _current;	
		}
		
		public function set current( value:int ):void
		{
			if( value >= min && value <= max ) _current = value;
			//else throw new GenericError( 'number ' + value + ' is out of range [ ' + min + ', ' + max + ' ]' );
		}
		
		public function get current():int
		{
			return _current;	
		}
	}
}