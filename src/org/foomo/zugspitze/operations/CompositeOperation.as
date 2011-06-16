package org.foomo.zugspitze.operations
{
	import org.foomo.zugspitze.events.OperationEvent;
	import org.foomo.zugspitze.utils.OperationUtils;

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