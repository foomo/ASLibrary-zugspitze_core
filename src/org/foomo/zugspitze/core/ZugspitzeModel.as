package org.foomo.zugspitze.core
{
	import flash.events.EventDispatcher;

	import org.foomo.zugspitze.events.OperationEvent;
	import org.foomo.zugspitze.operations.IOperation;
	import org.foomo.zugspitze.utils.OperationUtils;

	/**
	 * Zugspitze Model.
	 */
	public class ZugspitzeModel extends EventDispatcher
	{
		//-----------------------------------------------------------------------------------------
		// ~ Protected methods
		//-----------------------------------------------------------------------------------------

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
			// TODO: what to do with unhandled events!?
			this.dispatchEvent(event);
		}
	}
}