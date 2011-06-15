package org.foomo.zugspitze.core
{
	//[ExcludeClass]
	public class Singleton
	{
		//--------------------------------------------------------------------------
		//  Class variables
		//--------------------------------------------------------------------------

		/**
		 *  @private
		 *  A map of fully-qualified interface names,
		 *  such as "mx.managers::IPopUpManager",
		 *  to implementation classes which produce singleton instances,
		 *  such as mx.managers.PopUpManagerImpl.
		 */
		private static var classMap:Object = {};

		//--------------------------------------------------------------------------
		//
		//  Class methods
		//
		//--------------------------------------------------------------------------

		/**
		 *  @private
		 *  Adds an interface-name-to-implementation-class mapping to the registry,
		 *  if a class hasn't already been registered for the specified interface.
		 *  The class must implement a getInstance() method which returns
		 *  its singleton instance.
		 */
		public static function registerClass(interfaceName:String, clazz:Class):void
		{
			var c:Class = classMap[interfaceName];
			if (!c) classMap[interfaceName] = clazz;
		}

		/**
		 *  @private
		 *  Returns the implementation class registered for the specified
		 *  interface, or null if no class has been registered for that interface.
		 *
		 *  This method should not be called at static initialization time,
		 *  because the factory class may not have called registerClass() yet.
		 */
		public static function getClass(interfaceName:String):Class
		{
			return classMap[interfaceName];
		}

		/**
		 *  @private
		 *  Returns the singleton instance of the implementation class
		 *  that was registered for the specified interface,
		 *  by looking up the class in the registry
		 *  and calling its getInstance() method.
		 *
		 *  This method should not be called at static initialization time,
		 *  because the factory class may not have called registerClass() yet.
		 */
		public static function getInstance(interfaceName:String):Object
		{
			var c:Class = classMap[interfaceName];
			if (!c) throw new Error("No class registered for interface '" + interfaceName + "'.");
			return c["getInstance"]();
		}
	}
}