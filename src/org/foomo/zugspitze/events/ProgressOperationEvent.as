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

		public static const OPERATION_PROGRESS:String 	= "operationProgress";

		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		private var _operation:IProgressOperation;

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function ProgressOperationEvent(type:String, operation:IProgressOperation, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this._operation = operation;
			super(type, bubbles, cancelable);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public function get operation():IProgressOperation
		{
			return this._operation;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Overriden methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @inherit
		 */
		override public function clone():Event
		{
			return new ProgressOperationEvent(this.type, this.operation, this.bubbles, this.cancelable);
		}

		/**
		 * @inherit
		 */
		override public function toString():String
		{
			return formatToString("ProgressOperationEvent", "type", "operation", "bubbles", "cancelable");
		}
	}
}