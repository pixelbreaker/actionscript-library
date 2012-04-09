package com.pixelbreaker.debug
{
	import flash.display.Loader;
	import flash.events.Event;
	import com.pixelbreaker.utils.QueryString;
	import flash.net.URLRequest;
	import flash.events.IOErrorEvent;
	import flash.system.Capabilities;

	public class Debug
	{
		private static var instance:Debug;
		
		public static const TRACE:uint = 0;
		public static const EVENT:uint = 1;
		public static const WARNING:uint = 2;
		public static const ERROR:uint = 3;
		 
		public static const DRILL_DEPTH:uint = 5;

		private var active:Boolean;
		private var loaded:Boolean;
		private var preEmptiveStack:Array;
		private var debugLoader:Loader;
		private var debugClass:Object;
		
		public static function getInstance():Debug
		{
			if( instance == null ) instance = new Debug( new SingletonEnforcer() );
			return instance;	
		}
		
		public function Debug( pvt:SingletonEnforcer )
		{
			loaded = false;
			_init();
		}
		
		private function _init():void
		{
			//find out what our host environment is
			var playerType:String = Capabilities.playerType.toLowerCase();
			
			//if we're in the IDE, or a projector, don't bother with the debugger
			if( playerType == 'external' || playerType == 'standalone' )
				active = false;
			else{
				if(String( QueryString.getValues().debug ).toLowerCase() == 'true'){
					active = true;
				}else{
					active = false;
				}
			}
			if( active )
			{
				preEmptiveStack = [];

				debugLoader = new Loader();
				debugLoader.contentLoaderInfo.addEventListener( Event.COMPLETE, loadComplete );
				debugLoader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, ioError );
				debugLoader.load( new URLRequest( './extdebugger3.swf' ) );	
			}
		}
		
		private function ioError( e:IOErrorEvent ):void
		{
			//trace( e );// do nothing, just wont debug as file isn't present	
		}
		
		private function loadComplete( e:Event ):void
		{
			debugClass = debugLoader.content['extDebug'];
			loaded = true;
			execStack();
		}
		
		private function _log( obj:*, type:uint ):void
		{
			if( active )
			{
				if( loaded )
				{
					debugClass.log( obj, type );
				}
				else 
				{
					preEmptiveStack.push( { method:'log', args:[ obj, type ] } );	
				}
			}
		}
		
		private function _drill( obj:Object, depth:uint = DRILL_DEPTH, type:uint = TRACE ):void
		{
			if( active )
			{
				if( loaded )
				{
					debugClass.drill( obj, depth, type );
				}
				else
				{
					preEmptiveStack.push( { method:'drill', args:[ obj, depth, type ] } );	
				}
			}
		}
	
		public function _kerneltime( timeTaken:Number ):void
		{
			if( active )
			{
				if( loaded )
				{
					debugClass.kerneltime( timeTaken );
				}
				else
				{
					preEmptiveStack.push( { method:'kerneltime', args:[ timeTaken ] } );	
				}
			}
		}
		
		private function execStack():void
		{
			var item:Object;
			for( var i:Number = 0; i < preEmptiveStack.length; i++ )
			{
				item = preEmptiveStack[ i ];
				debugClass[ item.method ].apply( debugClass, item.args );
			}
		}
		
		public static function log( obj:*, type:uint = TRACE ):void
		{
			getInstance()._log( obj, type );
		}
	
		public static function drill( obj:Object, depth:uint = DRILL_DEPTH, type:uint = TRACE ):void
		{
			getInstance()._drill( obj, depth, type );
		}
		
		public static function kerneltime( timeTaken:Number ):void
		{
			getInstance()._kerneltime( timeTaken );	
		}
	}
}

internal class SingletonEnforcer{}