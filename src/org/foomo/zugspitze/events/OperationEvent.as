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
package org.foomo.zugspitze.events
{
	import flash.events.Event;

	import org.foomo.zugspitze.operations.IOperation;
	import org.foomo.flash.utils.ClassUtil;

	/**
	 * This class should not be used by it"s own.
	 * Extend it and define your own result and error types.
	 * There are some helper constants if you need to propagate operation events without typing them.
	 *
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class OperationEvent extends Event
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constants
		//-----------------------------------------------------------------------------------------

		public static const OPERATION_ERROR:String 				= "operationError";
		public static const OPERATION_COMPLETE:String 			= "operationComplete";
		public static const OPERATION_PROGRESS:String 			= "operationProgress";
		public static const UNHANDLED_OPERATION_COMPLETE:String = "unhandledOperationComplete";
		public static const UNHANDLED_OPERATION_PROGRESS:String = "unhandledOperationProgress";
		public static const UNHANDLED_OPERATION_ERROR:String 	= "unhandledOperationError";

		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		private var _result:*;
		/**
		 *
		 */
		private var _error:*;
		/**
		 *
		 */
		private var _total:Number;
		/**
		 *
		 */
		private var _progress:Number;

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function OperationEvent(type:String, result:*=null, error:*=null, total:Number=0, progress:Number=0)
		{
			this._result = result;
			this._error = error;
			this._total = total;
			this._progress = progress;
			super(type);
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

		/**
		 * Clone event with different type
		 */
		public function cloneWithType(type:String):OperationEvent
		{
			var eventClass:Class = ClassUtil.getClass(this);
			return new eventClass(type, this.untypedResult, this.untypedError, this.total, this.progress);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Overriden methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @inherit
		 */
		override public function clone():Event
		{
			var eventClass:Class = ClassUtil.getClass(this);
			return new eventClass(this.type, this.untypedResult, this.untypedError, this.total, this.progress);
		}

		/**
		 * @inherit
		 */
		override public function toString():String
		{
			return formatToString(ClassUtil.getClassName(this), "result", "error", "total", "progress");
		}
	}
}