package org.foomo.zugspitze.utils
{
	import org.foomo.zugspitze.core.IUnload;
	import org.foomo.zugspitze.events.OperationEvent;
	import org.foomo.zugspitze.operations.IOperation;

	//[ExcludeClass]
	public class OperationUtils
	{
		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public static function runOperation(operation:IOperation, completeHandler:Function=null, progressHandler:Function=null, errorHandler:Function=null):IOperation
		{
			var unload:Function;
			var progress:Function;
			var complete:Function;
			var error:Function;

			var errorEvent:String = StringUtils.ucFirst(ClassUtils.getClassName(operation)) + 'Error';
			var progressEvent:String = StringUtils.ucFirst(ClassUtils.getClassName(operation)) + 'Progress';
			var completeEvent:String = StringUtils.ucFirst(ClassUtils.getClassName(operation)) + 'Complete';

			unload = function():void {
				operation.removeEventListener(progressEvent, progress);
				operation.removeEventListener(completeEvent, complete);
				operation.removeEventListener(errorEvent, error);
				ClassUtils.callMethodIfType(operation, IUnload, 'unload');
			}

			progress = function(event:OperationEvent):void {
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

			operation.addEventListener(progressEvent, progress);
			operation.addEventListener(completeEvent, complete);
			operation.addEventListener(errorEvent, error);

			return operation;
		}
	}
}