package org.foomo.zugspitze.mock.events
{
	import org.foomo.zugspitze.events.OperationEvent;
	
	public class ProgressCompleteOperationEvent extends OperationEvent
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constants
		//-----------------------------------------------------------------------------------------
		
		public static const PROGRESS_COMPLETE_OPERATION_COMPLETE:String = '';
		
		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------
		
		public function ProgressCompleteOperationEvent(type:String, result:Boolean, error:*=null, total:Number=0, progress:Number=0)
		{
			super(type, result, error, total, progress);
		}
	}
}