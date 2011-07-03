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
	import org.foomo.zugspitze.events.OperationEvent;
	import org.foomo.zugspitze.utils.OperationUtil;

	[Event(name="operationError", type="org.foomo.zugspitze.events.OperationEvent")]
	[Event(name="operationComplete", type="org.foomo.zugspitze.events.OperationEvent")]
	[Event(name="operationProgress", type="org.foomo.zugspitze.events.OperationEvent")]
	[Event(name="unhandledOperationComplete", type="org.foomo.zugspitze.events.OperationEvent")]
	[Event(name="unhandledOperationProgress", type="org.foomo.zugspitze.events.OperationEvent")]
	[Event(name="unhandledOperationError", type="org.foomo.zugspitze.events.OperationEvent")]

	/**
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class CompositeOperation extends Operation
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function CompositeOperation(eventClass:Class=null)
		{
			super(eventClass);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Protected methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @return IOperation The executed operation
		 */
		protected function registerOperation(operation:IOperation, completeHandler:Function=null, errorHandler:Function=null, progressHandler:Function=null):*
		{
			if (progressHandler == null) progressHandler = this.unhandledOperations_operationEventHandler;
			if (completeHandler == null) completeHandler = this.unhandledOperations_operationEventHandler;
			if (errorHandler == null) errorHandler = this.unhandledOperations_operationEventHandler;
			OperationUtil.register(operation, completeHandler, errorHandler, progressHandler);
			return OperationUtil.register(operation, allOperations_operationEventHandler, allOperations_operationEventHandler, allOperations_operationEventHandler, true);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Protected eventhandler
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		protected function unhandledOperations_operationEventHandler(event:OperationEvent):void
		{
			this.dispatchEvent(OperationUtil.cloneToUnhandledOperationEvent(event));
		}

		/**
		 *
		 */
		protected function allOperations_operationEventHandler(event:OperationEvent):void
		{
			this.dispatchEvent(OperationUtil.cloneToOperationEvent(event));
		}
	}
}