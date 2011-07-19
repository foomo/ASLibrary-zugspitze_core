package org.foomo.zugspitze.mock.operations
{
	import org.foomo.zugspitze.mock.events.CompleteOperationEvent;
	import org.foomo.zugspitze.operations.Operation;

	public class CompleteOperation extends Operation
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function CompleteOperation()
		{
			super(CompleteOperationEvent);
			this.dispatchOperationCompleteEvent('All good');
		}
	}
}