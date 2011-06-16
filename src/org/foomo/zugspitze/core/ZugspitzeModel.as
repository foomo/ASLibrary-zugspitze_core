package org.foomo.zugspitze.core
{
	import flash.events.EventDispatcher;

	import org.foomo.zugspitze.events.OperationEvent;
	import org.foomo.zugspitze.operations.IOperation;
	import org.foomo.zugspitze.utils.OperationUtils;

	[Event(name="operationError", type="org.foomo.zugspitze.events.OperationEvent")]
	[Event(name="operationComplete", type="org.foomo.zugspitze.events.OperationEvent")]
	[Event(name="operationProgress", type="org.foomo.zugspitze.events.OperationEvent")]

	/**
	 * Zugspitze Model.
	 */
	public class ZugspitzeModel extends EventDispatcher
	{
		//-----------------------------------------------------------------------------------------
		// ~ Protected methods
		//-----------------------------------------------------------------------------------------

		protected function setupModel(model:ZugspitzeModel):*
		{
			model.addEventListener(OperationEvent.OPERATION_COMPLETE, this.unhandled_operationEventHandler, false, 0, true);
			model.addEventListener(OperationEvent.OPERATION_PROGRESS, this.unhandled_operationEventHandler, false, 0, true);
			model.addEventListener(OperationEvent.OPERATION_ERROR, this.unhandled_operationEventHandler, false, 0, true);
			return model;
		}

		/**
		 *
		 */
		protected function runOperation(operation:IOperation, completeHandler:Function=null, progressHandler:Function=null, errorHandler:Function=null):IOperation
		{
			if (progressHandler == null) progressHandler = this.unhandled_operationEventHandler;
			if (completeHandler == null) completeHandler = this.unhandled_operationEventHandler;
			if (errorHandler == null) errorHandler = this.unhandled_operationEventHandler;
			return OperationUtils.runOperation(operation, completeHandler, progressHandler, errorHandler);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Protected eventhandler
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		protected function unhandled_operationEventHandler(event:OperationEvent):void
		{
			this.dispatchEvent(event);
		}
	}
}