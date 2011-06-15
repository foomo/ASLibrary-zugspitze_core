package org.foomo.zugspitze.operations
{
	import org.foomo.zugspitze.events.ProgressOperationEvent;

	public class AbstractProgressOperation extends AbstractOperation implements IProgressOperation
	{
		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		protected var _total:uint;

		protected var _progress:uint;

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function AbstractProgressOperation(eventClass:Class=null)
		{
			super((eventClass) ? eventClass : ProgressOperationEvent);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public function get total():uint
		{
			return this._total;
		}

		/**
		 *
		 */
		public function get progress():uint
		{
			return this._progress;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Protected methods
		//-----------------------------------------------------------------------------------------

		protected function dispatchOperationProgressEvent(total:uint, progress:uint):Boolean
		{
			this._total = total;
			this._progress = progress;
			return this.dispatchEvent(new ProgressOperationEvent(ProgressOperationEvent.OPERATION_PROGRESS, this));
		}
	}
}