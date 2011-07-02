/*
 * This file is part of the foomo Opensource Framework.
 *
 * The foomo Opensource Framework is free software: you can redistribute it
 * and/or modify it under the terms of the GNU Lesser General Public License as
 * published  by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * The foomo Opensource Framework is distributed in the hope that it will
 * be useful, but WITHOUT ANY WARRANTY; without even the implied warranty
 * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License along with
 * the foomo Opensource Framework. If not, see <http://www.gnu.org/licenses/>.
 */
package org.foomo.zugspitze.managers
{
	import org.foomo.zugspitze.utils.ClassUtils;

	[ExcludeClass]
	
	/**
	 * @link www.foomo.org
	 * @license www.gnu.org/licenses/lgpl.txt
	 * @author franklin <franklin@weareinteractive.com>
	 */
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