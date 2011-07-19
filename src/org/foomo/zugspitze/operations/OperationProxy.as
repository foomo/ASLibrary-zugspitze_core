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

	import org.foomo.core.IUnload;
	import org.foomo.managers.LogManager;
	import org.foomo.utils.ClassUtil;
	import org.foomo.zugspitze.events.OperationEvent;

	/**
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 * @todo	check if you can implement the IEventDispatcher async
	 */
	dynamic public class OperationProxy extends Proxy implements IOperation, IUnload
	{
		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		protected var _completeListeners:Array = new Array;
		protected var _completeCallbacks:Array = new Array;
		protected var _errorListeners:Array = new Array;
		protected var _errorCallbacks:Array = new Array;
		protected var _operation:IOperation;

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
		public function get result():*
		{
			return this._operation.result;
		}

		/**
		 * Returns an untyped error
		 */
		public function get error():*
		{
			return this._operation.error;
		}

		/**
		 *
		 */
		public function addCompleteListener(listener:Function):IOperation
		{
			this._completeListeners.push({listener:listener});
			return this;
		}

		/**
		 *
		 */
		public function addCompleteCallback(callback:Function, ... args):IOperation
		{
			args.unshift(callback);
			this._completeCallbacks.push({args:args});
			return this;
		}

		/**
		 *
		 */
		public function addErrorListener(listener:Function):IOperation
		{
			this._errorListeners.push({listener:listener});
			return this;
		}

		/**
		 *
		 */
		public function addErrorCallback(callback:Function, ... args):IOperation
		{
			args.unshift(callback);
			this._errorCallbacks.push({args:args});
			return this;
		}
		/**
		 *
		 */
		public function chainOnComplete(operation:Class, ... args):IOperation
		{
			return this.addChain(this.addCompleteCallback, operation ,args);
		}
		/**
		 *
		 */
		public function chainOnError(operation:Class, ... args):IOperation
		{
			return this.addChain(this.addErrorCallback, operation, args);
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

		/**
		 *
		 */
		public function unload():void
		{
			this._completeCallbacks = null;
			this._completeListeners = null;
			this._errorCallbacks = null;
			this._errorListeners = null;
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
			var obj:Object;
			this._operation = operation;
			while (obj = this._completeListeners.shift()) operation.addCompleteListener(obj.listener);
			while (obj = this._completeCallbacks.shift()) (operation.addCompleteCallback as Function).apply(this, obj.args);
			while (obj = this._errorListeners.shift()) operation.addErrorListener(obj.listener);
			while (obj = this._errorCallbacks.shift()) (operation.addErrorCallback as Function).apply(this, obj.args);
		}

		/**
		 * @private
		 */
		private function addChain(callbackListener:Function, operation:Class, args:Array):IOperation
		{
			var fnc:Function;
			var instance:OperationProxy = this;
			var proxy:OperationProxy = new OperationProxy();

			fnc = function(value:*):void {
				if (ClassUtil.getConstructorParameters(operation).length > args.length) args.unshift(value);
				proxy.chain(ClassUtil.createInstance(operation, args));
			}

			callbackListener.apply(this, [fnc]);
			return proxy;
		}
	}
}