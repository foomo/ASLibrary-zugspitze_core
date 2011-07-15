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
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;

	import org.foomo.managers.LogManager;
	import org.foomo.zugspitze.events.OperationEvent;

	/**
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 * @todo	check if you can implement the IEventDispatcher async
	 */
	dynamic internal class OperationProxy extends Proxy implements IOperation
	{
		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		private var _progressListeners:Array = new Array;
		private var _completeListeners:Array = new Array;
		private var _errorListeners:Array = new Array;

		private var _operation:IOperation;

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function OperationProxy()
		{
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 * Returns an untyped result
		 */
		public function get untypedResult():*
		{
			return this._operation.untypedResult;
		}

		/**
		 * Returns an untyped error
		 */
		public function get untypedError():*
		{
			return this._operation.untypedError;
		}

		/**
		 * Returns the operation total
		 */
		public function get total():Number
		{
			return this._operation.total;
		}

		/**
		 * Returns the operation progress
		 */
		public function get progress():Number
		{
			return this._operation.progress;
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
			this._progressListeners.push(listener);
			return this;
		}

		/**
		 *
		 */
		public function chainOnProgress(operationCall:Function, ... args):IOperation
		{
			return Operation.addChain(this, addProgressListener, 'progress', operationCall, args);
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
			this._completeListeners.push(listener);
			return this;
		}

		/**
		 *
		 */
		public function chainOnComplete(operationCall:Function, ... args):IOperation
		{
			return Operation.addChain(this, this.addCompleteListener, 'result', operationCall, args);
		}


		/**
		 *
		 */
		public function addErrorCallback(callback:Function, ... args):IOperation
		{
			return Operation.addCallback(this, this.addCompleteListener, 'error', callback, args);
		}

		/**
		 *
		 */
		public function addErrorListener(listener:Function):IOperation
		{
			this._errorListeners.push(listener);
			return this;
		}

		/**
		 *
		 */
		public function chainOnError(operationCall:Function, ... args):IOperation
		{
			if (!this._operation) throw new Error('The opertion that you chained does not exist yet!');
			return Operation.addChain(this, addErrorListener, 'error', operationCall, args);
		}

		/**
		 *
		 */
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			if (!this._operation) throw new Error('The opertion that you chained does not exist yet!');
			this._operation.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}

		/**
		 *
		 */
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			if (!this._operation) throw new Error('The opertion that you chained does not exist yet!');
			this._operation.removeEventListener(type, listener, useCapture);
		}

		/**
		 *
		 */
		public function hasEventListener(type:String):Boolean
		{
			if (!this._operation) throw new Error('The opertion that you chained does not exist yet!');
			return this._operation.hasEventListener(type);
		}

		/**
		 *
		 */
		public function dispatchEvent(event:Event):Boolean
		{
			if (!this._operation) throw new Error('The opertion that you chained does not exist yet!');
			return this._operation.dispatchEvent(event);
		}

		/**
		 *
		 */
		public function willTrigger(type:String):Boolean
		{
			if (!this._operation) throw new Error('The opertion that you chained does not exist yet!');
			return this._operation.willTrigger(type);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Overriden methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @private
		 */
		flash_proxy override function callProperty(name:*, ... rest):*
		{
			if (!this._operation) throw new Error('The opertion that you chained does not exist yet!');
			try {
				var fnc:Function = this._operation[name];
				fnc.apply(this, rest);
			} catch (e:Error) {
				LogManager.fatal(this, 'Property does not exist:' + e.message);
				return null;
			}
		}

		/**
		 * @private
		 */
		flash_proxy override function setProperty(name:*, value:*):void
		{
			if (!this._operation) throw new Error('The opertion that you chained does not exist yet!');
			this._operation[name] = value;
		}

		/**
		 * @private
		 */
		flash_proxy override function getProperty(name:*):*
		{
			if (!this._operation) throw new Error('The opertion that you chained does not exist yet!');
			return this._operation[name];
		}

		//-----------------------------------------------------------------------------------------
		// ~ Internal methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @private
		 */
		internal function chain(operation:IOperation):void
		{
			var listener:Function;
			this._operation = operation;
			while (listener = this._progressListeners.shift()) operation.addProgressListener(listener);
			while (listener = this._completeListeners.shift()) operation.addCompleteListener(listener);
			while (listener = this._errorListeners.shift()) operation.addErrorListener(listener);
		}
	}
}