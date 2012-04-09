package com.pixelbreaker.loaders 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.utils.getQualifiedClassName;
	
	import com.pixelbreaker.debug.Debug;
	
	/**
	 * @author	Gabriel Bucknall
	 * @since	Apr 22, 2007
	 */
	public class PreloadQueue extends Sprite implements IEventDispatcher
	{
		public static const CONCURRENT:String = 'concurrent';
		public static const SEQUENTIAL:String = 'sequential';
		
		protected var loadMode:String;
		protected var preloadList:Array;
		protected var currentItem:Number;
		
		private var wait:int = 0;
		
		public function PreloadQueue()
		{
			loadMode = CONCURRENT;
			preloadList = new Array();
			currentItem = 0;
		}
		
		public function addAsset( loader:IQueueLoader, request:URLRequest = null ):void
		{
			if( ! ( loader is IQueueLoader ) )
			{
				throw new Error( getQualifiedClassName( loader ) + ' does not implement the ILoadable interface' );	
			}
			else
			{
				preloadList.push( { loader: loader, args: arguments.slice( 1 ), progress: 0 } );
			}
		}
		
		public function setMode( mode:String ):void
		{
			if( loadMode == CONCURRENT || loadMode == SEQUENTIAL ) loadMode = mode;
			else throw new Error( 'invalid load mode passed to PreloadQueue' );	
		}
		
		public function start():void
		{
			switch( loadMode )
			{
				case CONCURRENT:
					for( var i:Number = 0; i < preloadList.length; i++ )
					{
						loadItem( i );
					}
				break;
				
				case SEQUENTIAL:
					loadItem( currentItem );
				break;
			}
			
			addEventListener( Event.ENTER_FRAME, enterFrame );
		}
		
		protected function enterFrame( e:Event ):void
		{
			var itemValue:Number = 1 / preloadList.length;
			var totalLoaded:Number = 0;
			var allLoaded:Boolean = true;
			for( var i:Number = 0; i < preloadList.length; i++ )
			{
				var p:Number = preloadList[ i ].progress;
				if( isNaN( p ) ) p = 0;
				var iV:Number = i==preloadList.length-1? 1-( itemValue * ( preloadList.length - 1 ) ) : itemValue;
				totalLoaded += iV * p;
				if( p < 1 ) allLoaded = false;
			}
			if( totalLoaded < 1 )
			{
				dispatchEvent( new ProgressEvent( ProgressEvent.PROGRESS, false, false, totalLoaded*1000, 1000 ) );
			}
			if( allLoaded )
			{
				removeEventListener( Event.ENTER_FRAME, enterFrame );
				wait = 0;
				addEventListener( Event.ENTER_FRAME, delayFrame );
			}
		}
		
		private function delayFrame( e:Event ):void
		{
			if( wait == 1 )
			{
				dispatchEvent( new ProgressEvent( ProgressEvent.PROGRESS, false, false, 1, 1 ) );
				dispatchEvent( new Event( Event.COMPLETE ) );
				removeEventListener( Event.ENTER_FRAME, delayFrame );
			}
			wait++;
		}
		
		protected function loadItem( index:Number ):void
		{
			var item:Object = preloadList[ index ];
			var loader:IQueueLoader = item.loader;
			loader.addEventListener( ProgressEvent.PROGRESS, itemProgressUpdate );
			loader.addEventListener( Event.COMPLETE, itemComplete );
			loader.loadAsset.apply( loader, item.args );
		}
		
		protected function loadNextItem():void
		{
			if( ++currentItem < preloadList.length ) loadItem( currentItem );
		}
		
		protected function itemProgressUpdate( e:ProgressEvent ):void
		{
			var cItem:Object = getPreloadItem( e.target );
			if( cItem == null )
			{
				throw new Error( 'invalid item' );
			}
			
			cItem.progress = IQueueLoader( e.target ).getPercentageLoaded();
		}
		
		protected function itemComplete( e:Event ):void
		{
			var cItem:Object = getPreloadItem( e.target );
			cItem.progress = 1;
			var loader:IQueueLoader = IQueueLoader( e.target );
			
			Debug.log( 'loaded: ' + getQualifiedClassName( loader ), Debug.EVENT );
			
			loader.removeEventListener( ProgressEvent.PROGRESS, itemProgressUpdate );
			loader.removeEventListener( Event.COMPLETE, itemComplete );
			if( loadMode == SEQUENTIAL )
			{
				loadNextItem();	
			}	
		}
			
		protected function getPreloadItem( loader:Object ):Object
		{
			for( var i:Number = 0; i < preloadList.length; i++ )
			{
				if( preloadList[ i ].loader == loader ) return preloadList[ i ];
			}
			return null;
		}
	}
}