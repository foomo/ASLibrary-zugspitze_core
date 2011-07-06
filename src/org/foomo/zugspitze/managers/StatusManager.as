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
	import flash.events.EventDispatcher;

	import org.foomo.core.Managers;

	/**
	 *  @eventType flash.events.Event.CHANGE
	 */
	[Event(name="change", type="flash.events.Event")]

	/**
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class StatusManager extends EventDispatcher
	{
		//-----------------------------------------------------------------------------------------
		// ~ Static initialization
		//-----------------------------------------------------------------------------------------

		Managers.registerClass('org.foomo.zugspitze.managers::IStatusManager', StatusManagerImpl);

		//-----------------------------------------------------------------------------------------
		// ~ Static Variables
		//-----------------------------------------------------------------------------------------

		/**
		 * @private
		 */
		private static var _impl:IStatusManager;

		//-----------------------------------------------------------------------------------------
		// ~ Singleton instance
		//-----------------------------------------------------------------------------------------

		/**
		 * @private
		 */
		private static function get impl():IStatusManager
		{
			if (!_impl) _impl = IStatusManager(Managers.getInstance("org.foomo.zugspitze.managers::IStatusManager"));
			return _impl;
		}

		/**
		 * @return ICommandManager
		 */
		public static function getInstance():IStatusManager
		{
			return impl;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------

		/**
		 * Returns current request stack
		 */
		public static function get stack():Array
		{
			return impl.stack;
		}

		/**
		 * Set busy cursor
		 *
		 * @param instance			Caller instance as identifier
		 */
		public static function setBusyStatus(instance:Object):void
		{
			impl.setBusyStatus(instance);
		}

		/**
		 * Remove busy cursor
		 *
		 * @param instance			Caller instance as identifier
		 */
		public static function removeBusyStatus(instance:Object):void
		{
			impl.removeBusyStatus(instance);
		}

		/**
		 * @param type
		 * @param listener
		 * @param useCapture
		 * @param priority
		 * @param useWeakRefernce
		 */
		public static function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=true):void
		{
			impl.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}

		/**
		 * @param type
		 * @param listener
		 */
		public static function removeEventListener(type:String, listener:Function):void
		{
			impl.removeEventListener(type, listener);
		}
	}
}