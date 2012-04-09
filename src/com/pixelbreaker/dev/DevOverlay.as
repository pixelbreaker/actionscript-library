package com.pixelbreaker.dev
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.events.Event;
	import flash.utils.getTimer;
	import flash.text.TextFormat;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.display.DisplayObject;
	
	import flash.system.System;
	/**
	 * Class for displaying some basic stats about the current movie.
	 * It lists Current framerate, Average frame rate and Memory usage.
	 */
	public class DevOverlay extends Sprite
	{
		private const w:int = 100;
		private const h:int = 48; 
		
		private var tf:TextFormat;
		
		private var fpsCurrent:TextField;
		private var fpsAverage:TextField;
		private var memUse:TextField;

		private var fpsSet:int;
		private var frametime:int;
		private var fpsList:Array;
		
		/**
		 * Create a new instance of DevOverlay 
		 * 
		 * @param parent The parent DisplayObject to add this too.
		 */
		public function DevOverlay( parent:DisplayObject )
		{
			addEventListener( Event.ADDED_TO_STAGE,	_addedToStage );
			parent.stage.addChild( this );
		}
		
		private function _addedToStage( e:Event ):void
		{
			visible = false;
			x = stage.stageWidth - w;
			y = 0;
			graphics.beginFill( 0xDDDDDD, 0.8 );
			graphics.drawRect( 0, 0, w, h );
			
			tf = new TextFormat();
			tf.font = '_sans';
			tf.size = 10;
			
			fpsCurrent = new TextField();
			fpsCurrent.defaultTextFormat = tf;
			fpsCurrent.x = 5;
			fpsCurrent.y = 3;
			addChild( fpsCurrent );
			
			fpsAverage = new TextField();
			fpsAverage.defaultTextFormat = tf;
			fpsAverage.x = 5;
			fpsAverage.y = 18;
			addChild( fpsAverage );
			
			memUse = new TextField();
			memUse.defaultTextFormat = tf;
			memUse.x = 5;
			memUse.y = 33;
			addChild( memUse );
			
			fpsList = new Array();
			fpsSet = stage.frameRate;
			
			
			//reset();
			addEventListener( Event.ENTER_FRAME, enterFrame );
			//var timer:int = setInterval( reset, 200 );
			
			stage.addEventListener( KeyboardEvent.KEY_DOWN, keyHandler );
			stage.addEventListener( Event.RESIZE, resizeHandler );
		}
		
		private function resizeHandler( e:Event ):void
		{
			x = stage.stageWidth - w;
		}
		
		private function keyHandler( e:KeyboardEvent ):void
		{
			if( e.keyCode == Keyboard.SPACE )
			{
				visible = !visible;	
			}	
		}
		
		private function reset():void
		{
			memUse.text = 'mem: ' + Number( System.totalMemory / 1024 / 1024 ).toFixed( 2 ) + 'Mb';
			
			var currFps:int = 1000 / ( getTimer()-frametime );
			fpsCurrent.text = 'cur: ' + String( currFps ) + ' / ' + fpsSet;
			frametime = getTimer();	
			fpsList.push( currFps );
			if( fpsList.length >= fpsSet )
			{
				var avg:int = 0;
				for( var i:int=0; i<fpsList.length; i++ ){ avg += fpsList[ i ]; }
				avg /= fpsList.length;
				fpsAverage.text = 'avg: ' + int( avg ) + ' / ' + fpsSet;
				fpsList = new Array();
			}
		}
		
		private function enterFrame( e:Event ):void
		{
			reset();
		}
	}
}