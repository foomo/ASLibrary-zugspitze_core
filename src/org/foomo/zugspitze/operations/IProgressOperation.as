package org.foomo.zugspitze.operations
{
	public interface IProgressOperation extends IOperation
	{
		/**
		 * Returns the operation total
		 */
		function get total():Number;
		/**
		 * Returns the operation progress
		 */
		function get progress():Number;
		/**
		 *
		 */
		function addProgressListener(listener:Function):IProgressOperation
		/**
		 *
		 */
		function addProgressCallback(callback:Function, ... args):IProgressOperation;
		/**
		 *
		 */
		function chainOnProgress(operation:Class, ... args):IProgressOperation;
	}
}