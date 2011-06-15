package org.foomo.zugspitze.managers
{
	import org.foomo.zugspitze.utils.ClassUtils;

	//[ExcludeClass]
	public class LogManagerImpl implements ILogManager
	{
		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		/**
		 *  @private
		 */
		private static var _instance:ILogManager;

		//-----------------------------------------------------------------------------------------
		// ~ Singleton constructor
		//-----------------------------------------------------------------------------------------

		/**
		 * @private
		 */
		public function LogManagerImpl()
		{
		}

		/**
		 * @private
		 */
		public static function getInstance():ILogManager
		{
			if (!_instance) _instance = new LogManagerImpl();
			return _instance;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		public function log(category:*, level:*, message:String, ... rest):void
		{
			trace('[' + level + '] ' + this.getCategoryName(category) + ' :: ' + this.format(message, rest));
		}

		public function info(category:*, message:String, ... rest):void
		{
			trace('[INFO] ' + this.getCategoryName(category) + ' :: ' + this.format(message, rest));
		}

		public function warn(category:*, message:String, ... rest):void
		{
			trace('[WARN] ' + this.getCategoryName(category) + ' :: ' + this.format(message, rest));
		}

		public function error(category:*, message:String, ... rest):void
		{
			trace('[ERROR] ' + this.getCategoryName(category) + ' :: ' + this.format(message, rest));
		}

		public function fatal(category:*, message:String, ... rest):void
		{
			trace('[FATAL] ' + this.getCategoryName(category) + ' :: ' + this.format(message, rest));
		}

		public function debug(category:*, message:String, ... rest):void
		{
			trace('[DEBUG] ' + this.getCategoryName(category) + ' :: ' + this.format(message, rest));
		}

		public function isInfo():Boolean
		{
			return true;
		}

		public function isWarn():Boolean
		{
			return true;
		}

		public function isError():Boolean
		{
			return true;
		}

		public function isFatal():Boolean
		{
			return true;
		}

		public function isDebug():Boolean
		{
			return true;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Private methods
		//-----------------------------------------------------------------------------------------

		private function getCategoryName(value:*):String
		{
			if (value is String) {
				return value as String;
			} else {
				return ClassUtils.getQualifiedName(value);
			}
		}

		private function format(message:String, ... rest):String
		{
			const numParams:int = rest ? rest.length: 0;
			for (var i:int = 0; i < numParams; ++i) {
				var param: * = rest[i];
				message = message.replace( "{"+i+"}", param );
			}
			return message;
		}
	}
}