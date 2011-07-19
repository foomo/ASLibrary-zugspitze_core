package org.foomo.zugspitze.mock.events
{
	import org.foomo.zugspitze.events.OperationEvent;

	public class ErrorOperationEvent extends OperationEvent
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function ErrorOperationEvent(type:String, result:*=null, error:Boolean, total:Number=0, progress:Number=0)
		{
			super(type, result, error, total, progress);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		public function get error():Boolean
		{
			return this.untypedError;
		}
	}
}