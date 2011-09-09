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
	import flash.utils.flash_proxy;

	import org.foomo.core.EventDispatcherChain;
	import org.foomo.managers.LogManager;
	import org.foomo.utils.ClassUtil;
	import org.foomo.zugspitze.events.OperationEvent;
	import org.foomo.zugspitze.events.ProgressOperationEvent;

	use namespace flash_proxy;

	/**
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	dynamic public class OperationChain extends EventDispatcherChain
	{

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public function OperationChain()
		{
			if (LogManager.isDebug()) {
				this.addEventListener(OperationEvent.OPERATION_ERROR, this.debug_unhandledOperationEvent);
				this.addEventListener(OperationEvent.OPERATION_COMPLETE, this.debug_unhandledOperationEvent);
			}
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public function addOperationCompleteListener(listener:Function):OperationChain
		{
			if (LogManager.isDebug()) super.removeEventListener(OperationEvent.OPERATION_COMPLETE, this.debug_unhandledOperationEvent);
			return super.addEventListener(OperationEvent.OPERATION_COMPLETE, listener) as OperationChain;
		}

		/**
		 *
		 */
		public function addOperationErrorListener(listener:Function):OperationChain
		{
			if (LogManager.isDebug()) super.removeEventListener(OperationEvent.OPERATION_ERROR, this.debug_unhandledOperationEvent);
			return super.addEventListener(OperationEvent.OPERATION_COMPLETE, listener) as OperationChain;
		}

		/**
		 *
		 */
		public function addOperationProgressListener(listener:Function):OperationChain
		{
			return super.addEventListener(ProgressOperationEvent.OPERATION_PROGRESS, listener) as OperationChain;
		}

		/**
		 *
		 */
		public function addOperationCompleteCallback(callback:Function, eventArgs:Array=null, ... rest):OperationChain
		{
			if (LogManager.isDebug()) super.removeEventListener(OperationEvent.OPERATION_COMPLETE, this.debug_unhandledOperationEvent);
			rest.unshift(OperationEvent.OPERATION_COMPLETE, callback, eventArgs);
			return (super.addEventCallback as Function).apply(this, rest);
		}

		/**
		 *
		 */
		public function addOperationErrorCallback(callback:Function, eventArgs:Array=null, ... rest):OperationChain
		{
			if (LogManager.isDebug()) super.removeEventListener(OperationEvent.OPERATION_ERROR, this.debug_unhandledOperationEvent);
			rest.unshift(OperationEvent.OPERATION_ERROR, callback, eventArgs);
			return (super.addEventCallback as Function).apply(this, rest);
		}

		/**
		 *
		 */
		public function addOperationProgressCallback(callback:Function, eventArgs:Array=null, ... rest):OperationChain
		{
			rest.unshift(ProgressOperationEvent.OPERATION_PROGRESS, callback, eventArgs);
			return (super.addEventCallback as Function).apply(this, rest);
		}

		/**
		 *
		 */
		public function setOnOperationComplete(host:Object, parameter:String, eventArg:String=null, customArg:*=null):OperationChain
		{
			if (LogManager.isDebug()) super.removeEventListener(OperationEvent.OPERATION_COMPLETE, this.debug_unhandledOperationEvent);
			return super.setOnEvent(OperationEvent.OPERATION_COMPLETE, host, parameter, eventArg, customArg) as OperationChain;
		}

		/**
		 *
		 */
		public function setOnOperationError(host:Object, parameter:String, eventArg:String=null, customArg:*=null):OperationChain
		{
			if (LogManager.isDebug()) super.removeEventListener(OperationEvent.OPERATION_ERROR, this.debug_unhandledOperationEvent);
			return super.setOnEvent(OperationEvent.OPERATION_ERROR, host, parameter, eventArg, customArg) as OperationChain;
		}

		/**
		 *
		 */
		public function setOnOperationProgress(host:Object, parameter:String, eventArg:String=null, customArg:*=null):OperationChain
		{
			return super.setOnEvent(ProgressOperationEvent.OPERATION_PROGRESS, host, parameter, eventArg, customArg) as OperationChain;
		}

		/**
		 *
		 */
		public function unloadOnOperationComplete():OperationChain
		{
			return super.unloadOnEvent(OperationEvent.OPERATION_COMPLETE) as OperationChain;
		}

		/**
		 *
		 */
		public function unloadOnOperationError():OperationChain
		{
			return super.unloadOnEvent(OperationEvent.OPERATION_COMPLETE) as OperationChain;
		}

		/**
		 *
		 */
		public function unloadOnOperationProgress():OperationChain
		{
			return super.unloadOnEvent(ProgressOperationEvent.OPERATION_PROGRESS) as OperationChain;
		}

		/**
		 *
		 */
		public function chainOnOperationComplete(dispatcher:Class, eventArgs:Array=null, ... rest):OperationChain
		{
			if (LogManager.isDebug()) super.removeEventListener(OperationEvent.OPERATION_COMPLETE, this.debug_unhandledOperationEvent);
			rest.unshift(OperationEvent.OPERATION_COMPLETE, dispatcher, eventArgs);
			return (super.chainOn as Function).apply(this, rest);
		}

		/**
		 *
		 */
		public function chainOnOperationError(dispatcher:Class, eventArgs:Array=null, ... rest):OperationChain
		{
			if (LogManager.isDebug()) super.removeEventListener(OperationEvent.OPERATION_ERROR, this.debug_unhandledOperationEvent);
			rest.unshift(OperationEvent.OPERATION_ERROR, dispatcher, eventArgs);
			return (super.chainOn as Function).apply(this, rest);
		}

		/**
		 *
		 */
		public function chainOnOperationProgress(dispatcher:Class, eventArgs:Array=null, ... rest):OperationChain
		{
			rest.unshift(ProgressOperationEvent.OPERATION_PROGRESS, dispatcher, eventArgs);
			return (super.chainOn as Function).apply(this, rest);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Private eventhandler
		//-----------------------------------------------------------------------------------------

		private function debug_unhandledOperationEvent(event:OperationEvent):void
		{
			LogManager.warn(this, 'Unhandled {0}::{1} event!', ClassUtil.getQualifiedName(event.target), event.type);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public static function create(dispatcher:Class, ... rest):OperationChain
		{
			if (LogManager.isDebug()) LogManager.debug(EventDispatcherChain, 'Creating OperationChain :: {0}', ClassUtil.getQualifiedName(dispatcher));
			var ret:OperationChain = new OperationChain();
			return ret.setDispatcher(dispatcher, rest) as OperationChain;
		}
	}
}