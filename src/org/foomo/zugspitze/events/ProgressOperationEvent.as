package org.foomo.zugspitze.events
{
	import flash.events.Event;

	import org.foomo.zugspitze.operations.IOperation;
	import org.foomo.zugspitze.operations.IProgressOperation;

	public class ProgressOperationEvent extends Event
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constants
		//-----------------------------------------------------------------------------------------

		public static const OPERATION_PROGRESS:String = 'operationProgress';

		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		protected var _operation:IProgressOperation;

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function ProgressOperationEvent(type:String, operation:IProgressOperation)
		{
			this._operation = operation;
			super(type);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		public function get operation():IProgressOperation
		{
			return this._operation;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Overriden methods
		//-----------------------------------------------------------------------------------------

		override public function clone():Event
		{
			return new ProgressOperationEvent(this.type, this._operation);
		}

		override public function toString():String
		{
			return formatToString('ProgressOperationEvent');
		}
	}
}