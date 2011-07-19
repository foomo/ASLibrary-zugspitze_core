package org.foomo.zugspitze.mock.events
{
	import flash.events.Event;

	import org.foomo.zugspitze.events.OperationEvent;

	public class CompleteOperationEvent extends OperationEvent
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constants
		//-----------------------------------------------------------------------------------------

		public static const LOG_OPERATION_COMPLETE:String 	= "logOperationComplete";
		public static const LOG_OPERATION_PROGRESS:String 	= "logOperationProgress";
		public static const LOG_OPERATION_ERROR:String 		= "logOperationError";

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function CompleteOperationEvent(type:String, result:Boolean, error:*=null, total:Number=0, progress:Number=0)
		{
			super(type, result, error, total, progress);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public function get result():Boolean
		{
			return this.untypedResult;
		}
	}
}