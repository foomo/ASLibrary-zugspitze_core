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
	import org.foomo.zugspitze.events.OperationEvent;

	/**
	 * This class should not be used by it self.
	 * Extend it and define your events and typed result/error.
	 *
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 * @todo	Add progress operation
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

		/**
		 *
		 */
		public function addCompleteListener(listener:Function):IOperation
		{
			this.addEventListener(OperationEvent.OPERATION_COMPLETE, listener, false, 0, true);
			return this;
		}

		/**
		 *
		 */
		public function addCompleteCallback(callback:Function, ... args):IOperation
		{
			return this.addCallback(OperationEvent.OPERATION_COMPLETE, callback, args);
		}

		/**
		 *
		 */
		public function chainOnComplete(operation:Class, ... args):IOperation
		{
			return this.addChain(OperationEvent.OPERATION_COMPLETE, operation ,args);
		}

		/**
		 *
		 */
		public function addErrorListener(listener:Function):IOperation
		{
			this.addEventListener(OperationEvent.OPERATION_ERROR, listener, false, 0, true);
			return this;
		}

		/**
		 *
		 */
		public function addErrorCallback(callback:Function, ... args):IOperation
		{
			return this.addCallback(OperationEvent.OPERATION_ERROR, callback, args);
		}

		/**
		 *
		 */
		public function chainOnError(operation:Class, ... args):IOperation
		{
			return this.addChain(OperationEvent.OPERATION_ERROR, operation, args);
		}


		//-----------------------------------------------------------------------------------------
		// ~ Protected methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		protected function dispatchOperationCompleteEvent(result:*=null):Boolean
		{
			if (result != null) this._result = result;
			return this.dispatchEvent(new OperationEvent(OperationEvent.OPERATION_COMPLETE, this));
		}

		/**
		 *
		 */
		protected function dispatchOperationErrorEvent(error:*=null):Boolean
		{
			if (error != null) this._error = error;
			return this.dispatchEvent(new OperationEvent(OperationEvent.OPERATION_ERROR, this));
		}

		//-----------------------------------------------------------------------------------------
		// ~ Private methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @private
		 */
		private function addCallback(type:String, callback:Function, args:Array):IOperation
		{
			var fnc:Function
			var instance:Operation = this;

			fnc = function(event:OperationEvent):void {
				if (callback.length > args.length) args.unshift(event.operation[(type == OperationEvent.OPERATION_COMPLETE) ? 'result' : 'error']);
				callback.apply(instance, args);
				instance.removeEventListener(type, fnc);
			}
			instance.addEventListener(type, fnc, false, 0, true);
			return this;
		}

		/**
		 * @private
		 */
		private function addChain(type:String, operation:Class, args:Array):IOperation
		{
			var fnc:Function;
			var instance:Operation = this;
			var proxy:OperationProxy = new OperationProxy();

			fnc = function(event:OperationEvent):void {
				if (ClassUtil.getConstructorParameters(operation).length > args.length) args.unshift(event.operation[(type == OperationEvent.OPERATION_COMPLETE) ? 'result' : 'error']);
				proxy.chain(ClassUtil.createInstance(operation, args));
				instance.removeEventListener(type, fnc);
			}

			instance.addEventListener(type, fnc, false, 0, true);
			return proxy;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public static function create(operation:Class, ... args):IOperation
		{
			return ClassUtil.createInstance(operation, args);
		}
	}
}