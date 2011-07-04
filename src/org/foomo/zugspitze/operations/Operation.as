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
package org.foomo.zugspitze.operations
{
	import flash.events.EventDispatcher;

	import org.foomo.utils.ClassUtil;
	import org.foomo.utils.StringUtil;

	/**
	 * This class should not be used by it self.
	 * Extend it and define your events and typed result/error.
	 *
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class Operation extends EventDispatcher implements IOperation
	{
		//-----------------------------------------------------------------------------------------
		// ~ Variabels
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		protected var _error:*;
		/**
		 *
		 */
		protected var _result:*;
		/**
		 *
		 */
		protected var _total:Number;
		/**
		 *
		 */
		protected var _progress:Number;
		/**
		 *
		 */
		protected var _eventClass:Class;

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function Operation(eventClass:Class)
		{
			this._eventClass = eventClass;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public function get untypedResult():*
		{
			return this._result;
		}

		/**
		 *
		 */
		public function get untypedError():*
		{
			return this._error;
		}

		/**
		 *
		 */
		public function get total():Number
		{
			return this._total;
		}

		/**
		 *
		 */
		public function get progress():Number
		{
			return this._progress;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Protected methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		protected function dispatchOperationProgressEvent(total:Number, progress:Number):Boolean
		{
			this._total = total;
			this._progress = progress;
			return this.dispatchEvent(new this._eventClass(this.eventClassToEventName() + 'Progress', this.untypedResult, this.untypedError, this.total, this.progress));
		}

		/**
		 *
		 */
		protected function dispatchOperationCompleteEvent(result:*=null):Boolean
		{
			if (result != null) this._result = result;
			return this.dispatchEvent(new this._eventClass(this.eventClassToEventName() + 'Complete', this.untypedResult, this.untypedError, this.total, this.progress));
		}

		/**
		 *
		 */
		protected function dispatchOperationErrorEvent(error:*=null):Boolean
		{
			if (error != null) this._error = error;
			return this.dispatchEvent(new this._eventClass(this.eventClassToEventName() + 'Error', this.untypedResult, this.untypedError, this.total, this.progress));
		}

		/**
		 *
		 */
		protected function eventClassToEventName():String
		{
			return StringUtil.lcFirst(ClassUtil.getClassName(this._eventClass)).replace('Event', '');
		}
	}
}