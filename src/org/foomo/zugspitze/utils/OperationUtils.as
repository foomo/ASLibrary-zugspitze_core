package org.foomo.zugspitze.utils
{
	import org.foomo.zugspitze.core.IUnload;
	import org.foomo.zugspitze.events.OperationEvent;
	import org.foomo.zugspitze.events.ProgressOperationEvent;
	import org.foomo.zugspitze.operations.IOperation;
	import org.foomo.zugspitze.operations.IProgressOperation;

	//[ExcludeClass]
	public class OperationUtils
	{
		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public static function runOperation(operation:IOperation, completeHandler:Function=null, errorHandler:Function=null):IOperation
		{
			var unload:Function;
			var complete:Function;
			var error:Function;

			unload = function():void {
				operation.removeEventListener(OperationEvent.OPERATION_ERROR, error);
				operation.removeEventListener(OperationEvent.OPERATION_COMPLETE, complete);
				ClassUtils.callMethodIfType(operation, IUnload, 'unload');
			}

			complete = function(event:OperationEvent):void {
				if (completeHandler != null) completeHandler.call(this, event);
				unload.call(this);
			}

			error = function(event:OperationEvent):void {
				if (errorHandler != null) errorHandler.call(this, event);
				unload.call(this);
			}

			operation.addEventListener(OperationEvent.OPERATION_COMPLETE, complete);
			operation.addEventListener(OperationEvent.OPERATION_ERROR, error);

			return operation;
		}

		/**
		 *
		 */
		public static function runProgressOperation(operation:IProgressOperation, completeHandler:Function=null, progressHandler:Function=null, errorHandler:Function=null):IProgressOperation
		{
			var unload:Function;
			var progress:Function;
			var complete:Function;
			var error:Function;

			unload = function():void {
				operation.removeEventListener(ProgressOperationEvent.OPERATION_PROGRESS, progress);
				operation.removeEventListener(OperationEvent.OPERATION_ERROR, error);
				operation.removeEventListener(OperationEvent.OPERATION_COMPLETE, complete);
				ClassUtils.callMethodIfType(operation, IUnload, 'unload');
			}

			progress = function(event:ProgressOperationEvent):void {
				if (errorHandler != null) progressHandler.call(this, event);
			}

			complete = function(event:OperationEvent):void {
				if (completeHandler != null) completeHandler.call(this, event);
				unload.call(this);
			}

			error = function(event:OperationEvent):void {
				if (errorHandler != null) errorHandler.call(this, event);
				unload.call(this);
			}

			operation.addEventListener(ProgressOperationEvent.OPERATION_PROGRESS, progress);
			operation.addEventListener(OperationEvent.OPERATION_COMPLETE, complete);
			operation.addEventListener(OperationEvent.OPERATION_ERROR, error);

			return operation;
		}
	}
}