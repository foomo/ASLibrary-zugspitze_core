package org.foomo.zugspitze.operations
{
	import org.foomo.zugspitze.events.OperationEvent;
	import org.foomo.zugspitze.utils.OperationUtils;

	[Event(name="operationError", type="org.foomo.zugspitze.events.OperationEvent")]
	[Event(name="operationComplete", type="org.foomo.zugspitze.events.OperationEvent")]
	[Event(name="operationProgress", type="org.foomo.zugspitze.events.OperationEvent")]
	[Event(name="unhandledOperationComplete", type="org.foomo.zugspitze.events.OperationEvent")]
	[Event(name="unhandledOperationProgress", type="org.foomo.zugspitze.events.OperationEvent")]
	[Event(name="unhandledOperationError", type="org.foomo.zugspitze.events.OperationEvent")]

	/**
	 *
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
		protected function runOperation(operation:IOperation, completeHandler:Function=null, errorHandler:Function=null, progressHandler:Function=null):*
		{
			if (progressHandler == null) progressHandler = this.unhandledOperations_operationEventHandler;
			if (completeHandler == null) completeHandler = this.unhandledOperations_operationEventHandler;
			if (errorHandler == null) errorHandler = this.unhandledOperations_operationEventHandler;
			OperationUtils.addEventListeners(operation, completeHandler, errorHandler, progressHandler);
			return OperationUtils.runOperation(operation, allOperations_operationEventHandler, allOperations_operationEventHandler, allOperations_operationEventHandler);
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