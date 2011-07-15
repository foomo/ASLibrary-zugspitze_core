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
	import org.foomo.zugspitze.events.OperationEvent;

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
		/**
		 *
		 */
		protected var _eventName:String;

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function Operation(eventClass:Class)
		{
			this._eventClass = eventClass;
			this._eventName = StringUtil.lcFirst(ClassUtil.getClassName(this._eventClass)).replace('Event', '');
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
		 *
		 */
		public function addProgressCallback(callback:Function, ... args):IOperation
		{
			return Operation.addCallback(this, this.addProgressListener, 'progress', callback, args);
		}

		/**
		 *
		 */
		public function addProgressListener(listener:Function):IOperation
		{
			super.addEventListener(this._eventName + 'Progress', listener, false, 0, true);
			return this;
		}

		public function chainOnProgress(operationCall:Function, ... args):IOperation
		{
			return Operation.addChain(this, this.addProgressListener, 'progress', operationCall, args);
		}

		/**
		 *
		 */
		public function addCompleteCallback(callback:Function, ... args):IOperation
		{
			return Operation.addCallback(this, this.addCompleteListener, 'complete', callback, args);
		}

		/**
		 *
		 */
		public function addCompleteListener(listener:Function):IOperation
		{
			super.addEventListener(this._eventName + 'Complete', listener, false, 0, true);
			return this;
		}

		public function chainOnComplete(operationCall:Function, ... args):IOperation
		{
			return Operation.addChain(this, this.addCompleteListener, 'complete', operationCall, args);
		}

		/**
		 *
		 */
		public function addErrorCallback(callback:Function, ... args):IOperation
		{
			return Operation.addCallback(this, this.addErrorListener, 'error', callback, args);
		}

		/**
		 *
		 */
		public function addErrorListener(listener:Function):IOperation
		{
			super.addEventListener(this._eventName + 'Error', listener, false, 0, true);
			return this;
		}

		public function chainOnError(operationCall:Function, ... args):IOperation
		{
			return Operation.addChain(this, this.addErrorListener, 'error', operationCall, args);
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
			return this.dispatchEvent(new this._eventClass(this._eventName + 'Progress', this.untypedResult, this.untypedError, this.total, this.progress));
		}

		/**
		 *
		 */
		protected function dispatchOperationCompleteEvent(result:*=null):Boolean
		{
			if (result != null) this._result = result;
			return this.dispatchEvent(new this._eventClass(this._eventName + 'Complete', this.untypedResult, this.untypedError, this.total, this.progress));
		}

		/**
		 *
		 */
		protected function dispatchOperationErrorEvent(error:*=null):Boolean
		{
			if (error != null) this._error = error;
			return this.dispatchEvent(new this._eventClass(this._eventName + 'Error', this.untypedResult, this.untypedError, this.total, this.progress));
		}

		//-----------------------------------------------------------------------------------------
		// ~ Internal static methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @private
		 */
		internal static function addChain(thisArg:*, addListenerCall:Function, eventReturnParameter:String, operationCall:Function, args:Array):IOperation
		{
			var token:OperationProxy = new OperationProxy();
			var fnc:Function = function(event:Object):void {
				if (operationCall.length > args.length) args.unshift(event[eventReturnParameter]);
				token.chain(operationCall.apply(thisArg, args))
			}
			addListenerCall.apply(thisArg, [fnc]);
			return token;
		}

		/**
		 * @private
		 */
		internal static function addCallback(thisArg:*, addListenerCall:Function, eventReturnParameter:String, callback:Function, args:Array):IOperation
		{
			var fnc:Function = function(event:Object):void {
				if (callback.length > args.length) args.unshift(event[eventReturnParameter]);
				callback.apply(thisArg, args)
			}
			return addListenerCall.apply(thisArg, [fnc]);
		}
	}
}