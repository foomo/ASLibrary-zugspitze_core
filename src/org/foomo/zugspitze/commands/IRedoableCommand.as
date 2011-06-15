package org.foomo.zugspitze.commands
{
	/**
	 * Enables a command to be redoable.
	 * 
	 * @author franklin
	 */
	public interface IRedoableCommand
	{
		function redo():void;
	}
}