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
	import org.foomo.zugspitze.utils.ArrayUtils;
	import org.foomo.zugspitze.utils.ClassUtils;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getQualifiedClassName;

	[Event(name="change", type="flash.events.Event")]
	[ExcludeClass]
	
	/**
	 * @link www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author franklin <franklin@weareinteractive.com>
	 */
	public class StatusManagerImpl extends EventDispatcher implements IStatusManager
	{
		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		/**
		 *  @private
		 */
		private static var _instance:StatusManagerImpl;

		/**
		 * @private
		 * Flag if busy cursor is in use
		 */
		private var _busy:Boolean = false;
		/**
		 * @private
		 * Holds all current caller by dictionary
		 */
		private var _stack:Array = new Array;

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		/**
		 * @private
		 */
		public function StatusManagerImpl()
		{
		}

		/**
		 * @private
		 */
		public static function getInstance():StatusManagerImpl
		{
			if (!_instance) _instance = new StatusManagerImpl();
			return _instance;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 * Returns current request stacking status
		 */
		public function get stack():Array
		{
			return this._stack;
		}

		/**
		 * Tells whether the busy cursor is visible or not
		 *
		 * <p>You may want to bind this property to disable the view in that time<br>
		 * Usage: SatusManager.busy</p>
		 *
		 * @return 				whether the busy cursor is in use or not
		 */
		[Bindable(event="change")]
		public function get busy():Boolean
		{
			return this._busy;
		}

		/**
		 * Set busy cursor
		 *
		 * @param instance			Caller instance as identifier
		 */
		public function setBusyStatus(instance:Object):void
		{
			this._stack.push(ClassUtils.getQualifiedName(instance));
			if (this._busy) return;
			this._busy = true;
			this.dispatchEvent(new Event(Event.CHANGE));
		}

		/**
		 * Remove busy cursor
		 *
		 * @param instance			Caller instance as identifier
		 */
		public function removeBusyStatus(instance:Object):void
		{
			if (this._stack.length == 0) return;

			var aliasName:String 	= ClassUtils.getQualifiedName(instance);
			var itemIndex:int 		= ArrayUtils.getItemIndex(aliasName, this._stack);

			if (itemIndex < 0) {
				if (LogManager.isError()) LogManager.error(this, 'Instance not found in stack');
			} else {
				this._stack.splice(itemIndex, 1);
				if (this._stack.length == 0) {
					this._busy = false;
					this.dispatchEvent(new Event(Event.CHANGE));
				}
			}
		}
	}
}