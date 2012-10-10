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
	import flash.events.IEventDispatcher;

	[Event(name="change", type="flash.events.Event")]

	/**
	 * @link www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author franklin <franklin@weareinteractive.com>
	 */
	public interface IStatusManager extends IEventDispatcher
	{
		/**
		 * Returns current request stack
		 */
		function get stack():Array;

		/**
		 * Returns the current application status
		 */
		function get busy():Boolean;

		/**
		 * Set busy cursor
		 *
		 * @param instance			Caller instance as identifier
		 */
		function setBusyStatus(instance:Object):void;

		/**
		 * Remove busy cursor
		 *
		 * @param instance			Caller instance as identifier
		 */
		function removeBusyStatus(instance:Object):void;

		/**
		 * Remove all busy cursor
		 */
		function removeAllBusyStatus():void;
	}
}