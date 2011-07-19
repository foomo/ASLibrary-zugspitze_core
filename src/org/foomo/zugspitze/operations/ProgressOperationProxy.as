package org.foomo.zugspitze.operations
{

	public class ProgressOperationProxy extends OperationProxy implements IProgressOperation
	{
		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		protected var _progressListeners:Array = new Array;
		protected var _progressCallbacks:Array = new Array;

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function ProgressOperationProxy()
		{
			super();
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 * Returns the operation total
		 */
		public function get total():Number
		{
			return IProgressOperation(this._operation).total;
		}

		/**
		 * Returns the operation progress
		 */
		public function get progress():Number
		{
			return IProgressOperation(this._operation).progress;
		}

		/**
		 *
		 */
		public function addProgressListener(listener:Function):IProgressOperation
		{
			this._progressListeners.push({listener:listener});
			return this;
		}

		/**
		 *
		 */
		public function addProgressCallback(callback:Function, ... args):IProgressOperation
		{
			args.unshift(callback);
			this._progressCallbacks.push({args:args});
			return this;
		}

		/**
		 *
		 */
		public function chainOnProgress(operation:Class, ... args):IProgressOperation
		{
			return null;
		}



		//-----------------------------------------------------------------------------------------
		// ~ Overriden methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @inherit
		 */
		override public function unload():void
		{
			this._progressCallbacks = null;
			this._completeListeners = null;
			super.unload();
		}
	}
}