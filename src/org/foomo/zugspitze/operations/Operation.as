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
	
	import org.foomo.memory.IUnload;
	import org.foomo.utils.CallLaterUtil;
	import org.foomo.utils.ClassUtil;
	import org.foomo.zugspitze.events.OperationEvent;

	/**
	 * This class should not be used by it self.
	 * Extend it and define your events and typed result/error.
	 * Note: As operations need to be asynchronous use the "dispatchAsync*" methods if you have synchronous code
	 *
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 * @todo	Add progress operation
	 */
	public class Operation extends EventDispatcher implements IOperation, IUnload
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

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function Operation()
		{
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public function unload():void
		{
			this._error = null;
			this._result = null;
		}

		/**
		 *
		 */
		public function get result():*
		{
			return this._result;
		}

		/**
		 *
		 */
		public function get error():*
		{
			return this._error;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Protected methods
		//-----------------------------------------------------------------------------------------

		/**
		 * Dispatch a OperationEvent.OPERATION_COMPLETE event with given result
		 * 
		 * @param result The result object to pass 
		 * @return The result of dispatchEvent()
		 */
		protected function dispatchOperationCompleteEvent(result:*=null):Boolean
		{
			if (result != null) this._result = result;
			return this.dispatchEvent(new OperationEvent(OperationEvent.OPERATION_COMPLETE, this));
		}
		
		/**
		 * Dispatch a OperationEvent.OPERATION_COMPLETE event with given result on next Event.ENTER_FRAME event
		 * 
		 * @param result The result object to pass 
		 */
		protected function dispatchAsyncOperationCompleteEvent(result:*=null):void
		{
			CallLaterUtil.addCallback(this.dispatchAsyncOperationCompleteEvent_callbackHandler, result);
		}

		/**
		 * @param error The error object to pass 
		 * @return The error of dispatchEvent()
		 */
		protected function dispatchOperationErrorEvent(error:*=null):Boolean
		{
			if (error != null) this._error = error;
			return this.dispatchEvent(new OperationEvent(OperationEvent.OPERATION_ERROR, this));
		}
		
		/**
		 * Dispatch a OperationEvent.OPERATION_ERROR event with given error on next Event.ENTER_FRAME event
		 * 
		 * @param error The error object to pass 
		 */
		protected function dispatchAsyncOperationErrorEvent(error:*=null):void
		{
			CallLaterUtil.addCallback(this.dispatchAsyncOperationErrorEvent_callbackHandler, error);
		}
		
		//-----------------------------------------------------------------------------------------
		// ~ Private eventhandler
		//-----------------------------------------------------------------------------------------
		
		/**
		 * @param result Result object
		 */
		private function dispatchAsyncOperationCompleteEvent_callbackHandler(result:*=null):void
		{
			CallLaterUtil.removeCallback(this.dispatchAsyncOperationCompleteEvent_callbackHandler);
			this.dispatchOperationCompleteEvent(result);
		}
		
		/**
		 * @param error Error object
		 */
		private function dispatchAsyncOperationErrorEvent_callbackHandler(error:*=null):void
		{
			CallLaterUtil.removeCallback(this.dispatchAsyncOperationErrorEvent_callbackHandler);
			this.dispatchOperationErrorEvent(result);
		}
	}
}