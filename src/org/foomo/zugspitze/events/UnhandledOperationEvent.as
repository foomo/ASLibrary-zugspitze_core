package org.foomo.zugspitze.events
{
	import flash.events.Event;

	import org.foomo.zugspitze.operations.IOperation;

	public class UnhandledOperationEvent extends Event
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constants
		//-----------------------------------------------------------------------------------------

		public static const UNHANDLED_OPERATION_ERROR:String 		= "unhandledOperationError";
		public static const UNHANDLED_OPERATION_COMPLETE:String 	= "unhandledOperationComplete";
		public static const UNHANDLED_OPERATION_PROGRESS:String 	= "unhandledOperationProgress";

		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		private var _operation:IOperation;

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function UnhandledOperationEvent(type:String, operation:IOperation, bubbles:Boolean=false, cancelable:Boolean=false)
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
		public function get operation():IOperation
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
			return new UnhandledOperationEvent(this.type, this.operation, this.bubbles, this.cancelable);
		}

		/**
		 * @inherit
		 */
		override public function toString():String
		{
			return formatToString("type", "operation", "bubbles", "cancelable");
		}
	}
}