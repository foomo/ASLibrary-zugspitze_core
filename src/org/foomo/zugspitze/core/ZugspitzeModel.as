package org.foomo.zugspitze.core
{
	import flash.events.EventDispatcher;

	import org.foomo.zugspitze.events.OperationEvent;
	import org.foomo.zugspitze.operations.IOperation;
	import org.foomo.zugspitze.utils.OperationUtils;

	[Event(name="operationError", type="org.foomo.zugspitze.events.OperationEvent")]
	[Event(name="operationComplete", type="org.foomo.zugspitze.events.OperationEvent")]
	[Event(name="operationProgress", type="org.foomo.zugspitze.events.OperationEvent")]
	[Event(name="unhandledOperationError", type="org.foomo.zugspitze.events.OperationEvent")]
	[Event(name="unhandledOperationComplete", type="org.foomo.zugspitze.events.OperationEvent")]
	[Event(name="unhandledOperationProgress", type="org.foomo.zugspitze.events.OperationEvent")]

	/**
	 * Zugspitze Model.
	 */
	public class ZugspitzeModel extends EventDispatcher
	{
		//-----------------------------------------------------------------------------------------
		// ~ Protected methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @return IOperation The executed operation
		 */
		protected function runOperation(operation:IOperation, completeHandler:Function=null, errorHandler:Function=null, progressHandler:Function=null):*
		{
			if (progressHandler == null) progressHandler = this.unhandledOperations_operationEventHandler;
			if (completeHandler == null) completeHandler = this.unhandledOperations_operationEventHandler;
			if (errorHandler == null) errorHandler = this.unhandledOperations_operationEventHandler;
			OperationUtils.addEventListeners(operation, completeHandler, errorHandler, progressHandler);
			return OperationUtils.runOperation(operation, this.allOperations_operationEventHandler, this.allOperations_operationEventHandler, this.allOperations_operationEventHandler);
		}

		/**
		 * @return ZugspitzeModel
		 */
		protected function registerModel(model:ZugspitzeModel):*
		{
			model.addEventListener(OperationEvent.OPERATION_COMPLETE, this.allOperations_operationEventHandler, false, 0, true);
			model.addEventListener(OperationEvent.OPERATION_PROGRESS, this.allOperations_operationEventHandler, false, 0, true);
			model.addEventListener(OperationEvent.OPERATION_ERROR, this.allOperations_operationEventHandler, false, 0, true);
			model.addEventListener(OperationEvent.UNHANDLED_OPERATION_COMPLETE, this.unhandledOperations_operationEventHandler, false, 0, true);
			model.addEventListener(OperationEvent.UNHANDLED_OPERATION_PROGRESS, this.unhandledOperations_operationEventHandler, false, 0, true);
			model.addEventListener(OperationEvent.UNHANDLED_OPERATION_ERROR, this.unhandledOperations_operationEventHandler, false, 0, true);
			return model;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Protected eventhandler
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		protected function unhandledOperations_operationEventHandler(event:OperationEvent):void
		{
			this.dispatchEvent(OperationUtils.cloneToUnhandledOperationEvent(event));
		}

		/**
		 *
		 */
		protected function allOperations_operationEventHandler(event:OperationEvent):void
		{
			this.dispatchEvent(OperationUtils.cloneToOperationEvent(event));
		}
	}
}