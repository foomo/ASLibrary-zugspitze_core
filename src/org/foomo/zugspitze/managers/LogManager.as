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
	import org.foomo.zugspitze.core.Singleton;

	/**
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
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