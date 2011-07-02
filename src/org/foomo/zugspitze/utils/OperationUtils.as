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
package org.foomo.zugspitze.utils
{
	import org.foomo.zugspitze.core.IUnload;
	import org.foomo.zugspitze.events.OperationEvent;
	import org.foomo.zugspitze.operations.IOperation;

	/**
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class OperationUtils
	{
		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------

		/**
		 * Calls the unload method after execution
		 *
		 * @private
		 */
		public static function register(operation:IOperation, completeHandler:Function=null, errorHandler:Function=null, progressHandler:Function=null, unload:Boolean=false):IOperation
		{
			var unloadMethod:Function;
			var progressMethod:Function;
			var completeMethod:Function;
			var errorMethod:Function;

			var errorEvent:String = StringUtils.lcFirst(ClassUtils.getClassName(operation)) + 'Error';
			var progressEvent:String = StringUtils.lcFirst(ClassUtils.getClassName(operation)) + 'Progress';
			var completeEvent:String = StringUtils.lcFirst(ClassUtils.getClassName(operation)) + 'Complete';

			unloadMethod = function():void {
				operation.removeEventListener(progressEvent, progressMethod);
				operation.removeEventListener(completeEvent, completeMethod);
				operation.removeEventListener(errorEvent, errorMethod);
				if (unload) ClassUtils.callMethodIfType(operation, IUnload, 'unload');
			}

			progressMethod = function(event:OperationEvent):void {
				if (progressHandler != null) progressHandler.call(this, event);
			}

			completeMethod = function(event:OperationEvent):void {
				if (completeHandler != null) completeHandler.call(this, event);
				unloadMethod.call(this);
			}

			errorMethod = function(event:OperationEvent):void {
				if (errorHandler != null) errorHandler.call(this, event);
				unloadMethod.call(this);
			}

			operation.addEventListener(progressEvent, progressMethod);
			operation.addEventListener(completeEvent, completeMethod);
			operation.addEventListener(errorEvent, errorMethod);

			return operation;
		}


		/**
		 * Clone an operation event with a basic type
		 */
		public static function cloneToUnhandledOperationEvent(event:OperationEvent):OperationEvent
		{
			switch (true) {
				case (event.type.substr(-8) == 'Progress'):
					event = event.cloneWithType(OperationEvent.UNHANDLED_OPERATION_PROGRESS);
					break;
				case (event.type.substr(-8) == 'Complete'):
					event = event.cloneWithType(OperationEvent.UNHANDLED_OPERATION_COMPLETE);
					break;
				case (event.type.substr(-5) == 'Error'):
					event = event.cloneWithType(OperationEvent.UNHANDLED_OPERATION_ERROR);
					break;
				default:
					throw new Error('Could not figure out operation event type ' + event.type);
					break;
			}
			return event;
		}

		/**
		 * Clone an operation event with a basic type
		 */
		public static function cloneToOperationEvent(event:OperationEvent):OperationEvent
		{
			switch (true) {
				case (event.type.substr(-8) == 'Progress'):
					event = event.cloneWithType(OperationEvent.OPERATION_ERROR);
					break;
				case (event.type.substr(-8) == 'Complete'):
					event = event.cloneWithType(OperationEvent.OPERATION_ERROR);
					break;
				case (event.type.substr(-5) == 'Error'):
					event = event.cloneWithType(OperationEvent.OPERATION_ERROR);
					break;
				default:
					throw new Error('Could not figure out operation event type ' + event.type);
					break;
			}
			return event;
		}
	}
}