package com.pixelbreaker.debug.external
{
	import com.pixelbreaker.utils.ArrayUtils;
	import flash.net.LocalConnection;
	import flash.system.Capabilities;
	import flash.events.StatusEvent;
	
	public class ExtDebug
	{
		private static var instance:ExtDebug;

		public static const TRACE:uint = 0;
		public static const EVENT:uint = 1;
		public static const WARNING:uint = 2;
		public static const ERROR:uint = 3;
		 
		public static const DRILL_DEPTH:uint = 5;
		
		private var connection:LocalConnection;
		private var colors:Array;
		
		private var framerate:FrameRate;
		
		/**
		 * @return singleton instance of Debug
		 */
		
		public static function getInstance():ExtDebug
		{
			if( !instance ) instance = new ExtDebug( arguments.callee );
			return instance;
		}
		
		public function ExtDebug( caller:Function )
		{
			if( caller == ExtDebug.getInstance )
			{
				_init();
			}
			else
			{
				throw new Error( 'Debug is a singleton, use getInstance();' );
			}	
		}
		
		private function _init():void
		{
			colors = [
				0x000000, // 0-TRACE
				0x0000CC, // 1-EVENT
				0xFF9900, // 2-WARNING
				0xFF0000  // 3-ERROR
			];
			connection = new LocalConnection();
			connection.addEventListener( StatusEvent.STATUS, _statusHandler );	
			
			// framerate
			framerate = new FrameRate( this );
			
			_broadcast( 'Debug Active', EVENT );
		}
		
		private function _broadcast( text:String, type:uint = TRACE ):void
		{
			if( Capabilities.playerType.toLowerCase() == "external") trace(text);
			else connection.send( "_debugger", "sendText", text, colors[ type ], type );
//			trace( text );
		}
		
		private function _statusHandler( e:StatusEvent ):void
		{
//			trace( e );	
		}
		
		public function log( obj:Object, type:uint = TRACE ):void
		{
			_broadcast( obj.toString(), type );		
		}
		
		public function drill( obj:Object, depth:uint = DRILL_DEPTH, type:uint = TRACE ):void
		{
			// list of parse object, to check for circular references.
			var stack:Array = [];
			
			var md:Number = depth;
			var tmp:String = obj.toString() + '\n';
			var r:Function = function( ro:Object, d:Number ):void
			{
				var t:String = "<font color=\"#CCCCCC\">";
				for( var i:Number = 0; i <= d; i++ ) t += i<d? ' | ' : ' |_';
				t += "</font>";
				var co:Object;
				for( var j:String in ro )
				{
					co = ro[ j ];
					if( ArrayUtils.indexOf( stack, co ) != -1 )
					{
						tmp += t + co + ' ∞\n';	
						break;
					}
					
					stack.push( co );
					
					tmp += t +  j + ': ';
					if( !( co is String ) && !( co is Number ) )
					{
						tmp += co.toString() + '\n';
						if( d<=md ) r( co, d+1 );
						else tmp += t + '--->\n';
					}
					else
					{
						tmp += co + '\n';	
					}
				}
			};
			
			r( obj, 0 );
			
			_broadcast( tmp, type );
		}
		
		public function sendWatchList( arr:Array ):void
		{
			connection.send( "_debugger", "updateWatchList", arr );
		}
		
		public function frametime( timeTaken:Number ):void
		{
			connection.send( "_debugger", "sendFrameTime", timeTaken );	
		}
		
		public function kerneltime( timeTaken:Number ):void
		{
			connection.send("_debugger", "sendKernelTime", timeTaken);
		}
	}
}