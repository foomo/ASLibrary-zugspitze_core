package org.foomo.zugspitze.mock.operations
{
	import org.foomo.zugspitze.mock.events.ErrorOperationEvent;
	import org.foomo.zugspitze.operations.Operation;

	public class ErrorOperation extends Operation
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function ErrorOperation()
		{
			super(ErrorOperationEvent);
			this.dispatchOperationErrorEvent(false);
		}
	}
}