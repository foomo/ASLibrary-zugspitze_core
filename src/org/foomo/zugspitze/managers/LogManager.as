package org.foomo.zugspitze.managers
{
	import org.foomo.zugspitze.core.Singleton;

	public class LogManager
	{
		//-----------------------------------------------------------------------------------------
		// ~ Static variables
		//-----------------------------------------------------------------------------------------

		/**
		 *  @private
		 *  Linker dependency on implementation class.
		 */
		private static var _implClassDependency:LogManagerImpl;

		/**
		 * @private
		 */
		private static var _impl:ILogManager;

		//-----------------------------------------------------------------------------------------
		// ~ Singleton instance
		//-----------------------------------------------------------------------------------------

		private static function get impl():ILogManager
		{
			if (!_impl) _impl = ILogManager(Singleton.getInstance("org.foomo.zugspitze.managers::ILogManager"));
			return _impl;
		}

		/**
		 * @return ILogManager
		 */
		public static function getInstance():ILogManager
		{
			return impl;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------

		public static function log(category:*, level:*, message:String, ... rest):void
		{
			impl.log(category, level, message, rest);
		}

		public static function info(category:*, message:String, ... rest):void
		{
			impl.info(category, message, rest);
		}

		public static function warn(category:*, message:String, ... rest):void
		{
			impl.warn(category, message, rest);
		}

		public static function error(category:*, message:String, ... rest):void
		{
			impl.error(category, message, rest);
		}

		public static function fatal(category:*, message:String, ... rest):void
		{
			impl.fatal(category, message, rest);
		}

		public static function debug(category:*, message:String, ... rest):void
		{
			impl.debug(category, message, rest);
		}

		public static function isInfo():Boolean
		{
			return impl.isInfo();
		}

		public static function isWarn():Boolean
		{
			return impl.isWarn();
		}

		public static function isError():Boolean
		{
			return impl.isError();
		}

		public static function isFatal():Boolean
		{
			return impl.isFatal();
		}

		public static function isDebug():Boolean
		{
			return impl.isDebug();
		}
	}
}