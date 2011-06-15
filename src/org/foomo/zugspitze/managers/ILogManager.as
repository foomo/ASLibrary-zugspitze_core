package org.foomo.zugspitze.managers
{
	internal interface ILogManager
	{
		function log(category:*, level:*, message:String, ... rest):void;

		function info(category:*, message:String, ... rest):void;
		function warn(category:*, message:String, ... rest):void;
		function error(category:*, message:String, ... rest):void;
		function fatal(category:*, message:String, ... rest):void;
		function debug(category:*, message:String, ... rest):void;

		function isInfo():Boolean;
		function isWarn():Boolean;
		function isError():Boolean;
		function isFatal():Boolean;
		function isDebug():Boolean;
	}
}