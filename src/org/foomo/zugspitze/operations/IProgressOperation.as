package org.foomo.zugspitze.operations
{
	public interface IProgressOperation extends IOperation
	{
		function get total():uint;
		function get progress():uint;
	}
}