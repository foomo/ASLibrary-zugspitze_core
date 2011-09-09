package org.foomo.zugspitze.commands
{
	import org.foomo.utils.ObjectUtil;

	public class CommandValue
	{
		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		private var _host:Object;

		private var _path:String;

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function CommandValue(host:Object, path:String=null)
		{
			this._host = host;
			this._path = path;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		public function get value():*
		{
			return (this._path != null) ? ObjectUtil.resolveValue(this._host, this._path) : this._host;
		}

		public function getString():String
		{
			return this.value;
		}

		public function getNumber():Number
		{
			return this.value;
		}

		public function getInt():int
		{
			return this.value;
		}

		public function getUint():uint
		{
			return this.value;
		}

		public function getArray():Array
		{
			return this.value;
		}

		public function getObject():Object
		{
			return this.value;
		}
	}
}