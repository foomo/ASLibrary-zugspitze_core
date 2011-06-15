package org.foomo.zugspitze.commands
{
	import org.foomo.zugspitze.core.IUnload;
	import org.foomo.zugspitze.utils.ClassUtils;

	/**
	 * @private
	 * A simple command stack where commands can be added or taken from
	 */
	//[ExcludeClass]
	public class CommandStack
	{
		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		/**
		 * @private
		 */
		private var _size:uint;

		/**
		 * @private
		 */
		private var _index:int;

		/**
		 * @private
		 */
		private var _commands:Array;

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function CommandStack(size:int)
		{
			this._index 	= 0;
			this._size 		= size;
			this._commands 	= new Array;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 * Adds a new command to the stack
		 *
		 * @param value			command to be added
		 */
		public function put(value:ICommand):void
		{
			//if you were working with undo you have to raise the index after slicing
			//else there is a command in the history you want to be deleted
			if (this._commands[this._index]) {
				this._commands = this._commands.slice(0, this._index++);
			} else {
				this._commands = this._commands.slice(0, ++this._index);
			}
			this._commands.push(value);
			this.validateSize();
		}

		/**
		 * @param value			stack size
		 */
		public function set size(value:uint):void
		{
			this._size = value;
			this.validateSize();
		}

		/**
		 * @return				stack size
		 */
		public function get size():uint
		{
			return this._size;
		}

		/**
		 * @return 				has next command
		 */
		public function get hasNext():Boolean
		{
			return (this._index < this._commands.length);
		}

		/**
		 * @return 				next command in stack
		 */
		public function get next():Command
		{
			this.validateSize();
			return this._commands[this._index++];
		}

		/**
		 * @return 				has previous command
		 */
		public function get hasPrevious():Boolean
		{
			return this._index > 0;
		}

		/**
		 * @return 				previous command in stack
		 */
		public function get previous():Command
		{
			this.validateSize();
			return this._commands[--this._index];
		}

		/**
		 * Cuts the stack back to current index
		 */
		public function cutBack():void
		{
			this._commands = this._commands.slice(0, this._index);
		}

		/**
		 * Resets the stack
		 */
		public function reset():void
		{
			this._index = 0;
			for each (var command:ICommand in this._commands) ClassUtils.callMethodIfType(command, IUnload, 'unload');
			this._commands = new Array();
		}

		//-----------------------------------------------------------------------------------------
		// ~ Private methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @private
		 */
		private function validateSize():void
		{
			if (this._commands.length > this._size) {
				this._commands 	= this._commands.slice((this._commands.length - this._size), this._commands.length);
				this._index 	= this._commands.length;
			}
		}
	}
}