package org.foomo.zugspitze.commands
{
	/**
	 * Enables a command to be undoable.
	 * 
	 * @package org.foomo.zugspitze
	 * @author franklin
	 */
	public interface IUndoableCommand
	{
		function undo():void;
	}
}