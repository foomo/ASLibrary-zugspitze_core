package org.foomo.zugspitze.core
{
	import flash.events.EventDispatcher;

	import org.foomo.zugspitze.events.OperationEvent;
	import org.foomo.zugspitze.events.ProgressOperationEvent;
	import org.foomo.zugspitze.operations.IOperation;
	import org.foomo.zugspitze.operations.IProgressOperation;
	import org.foomo.zugspitze.utils.OperationUtils;

	[Event(name="operationError", type="org.foomo.zugspitze.events.OperationEvent")]
	[Event(name="operationComplete", type="org.foomo.zugspitze.events.OperationEvent")]
	[Event(name="operationProgress", type="org.foomo.zugspitze.operations.ProgressOperationEvent")]

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
		protected function runOperation(operation:IOperation, completeHandler:Function=null, errorHandler:Function=null):IOperation
		{
			if (completeHandler == null) completeHandler = this.unhandled_operationCompleteHandler;
			if (errorHandler == null) errorHandler = this.unhandled_operationErrorHandler;
			return OperationUtils.runOperation(operation, completeHandler, errorHandler);
		}

		/**
		 *
		 */
		protected function runProgressOperation(operation:IProgressOperation, completeHandler:Function=null, progressHandler:Function=null, errorHandler:Function=null):IProgressOperation
		{
			if (progressHandler == null) progressHandler = this.unhandled_operationProgressHandler;
			if (completeHandler == null) completeHandler = this.unhandled_operationCompleteHandler;
			if (errorHandler == null) errorHandler = this.unhandled_operationErrorHandler;
			return OperationUtils.runProgressOperation(operation, completeHandler, progressHandler, errorHandler);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Protected eventhandler
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		protected function unhandled_operationProgressHandler(event:ProgressOperationEvent):void
		{
			this.dispatchEvent(event);
		}

		/**
		 *
		 */
		protected function unhandled_operationCompleteHandler(event:OperationEvent):void
		{
			this.dispatchEvent(event);
		}

		/**
		 *
		 */
		protected function unhandled_operationErrorHandler(event:OperationEvent):void
		{
			this.dispatchEvent(event);
		}
	}
}