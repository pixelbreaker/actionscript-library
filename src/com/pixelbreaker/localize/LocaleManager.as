package com.pixelbreaker.localize
{
	public final class LocaleManager
	{
		private static var instance:LocaleManager;
		
		private var _iso:String;
		private var _isoList:Object;
		
		public static function getInstance():LocaleManager
		{
			if( instance == null ) instance = new LocaleManager( new SingletonEnforcer() );
			return instance;	
		}
		
		public function LocaleManager( enforcer:SingletonEnforcer )
		{
			_iso = 'en';
			_isoList = {
				en: { embed:true },	
				en_GB: { embed:true },	
				nl: { embed:true },
				nl_NL: { embed:true },
				en_US: { embed:true },	
				en_CA: { embed:true },	
				fr_FR: { embed:true },	
				fr_CA: { embed:true },	
				de_DE: { embed:true },
				es_ES: { embed:true },	
				pt_PT: { embed:true },	
				it_IT: { embed:true },
				sv_SE: { embed:true },	
				zh: { embed:false },
				zh_CN: { embed:false },
				zh_HK: { embed:false }			
			};
		}
		
		public function set iso( value:String ):void
		{
			if( value == null ) return;
			_iso = value;
		}
		
		public function get iso():String
		{
			return _iso;
		}
		
		public function get embed():Boolean
		{
			return getInstance()._isoList[ getInstance()._iso ].embed;	
		}
	}
}

internal class SingletonEnforcer{}