package org.foomo.zugspitze.utils
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	[ExcludeClass]
	public class ClassUtils
	{
		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @param value		The object for which a fully qualified class name is desired. Any ActionScript value may be passed to this method including all available ActionScript types, object instances, primitive types such as uint, and class objects
		 * @return 			A string containing the fully qualified class name
		 */
		public static function getQualifiedName(value:*):String
		{
			return getQualifiedClassName(value).replace('::', '.');
		}

		/**
		 *
		 */
		public static function getPackageName(value:*):String
		{
			var data:Array = getQualifiedClassName(value).split('::');
			return data[0];
		}

		/**
		 *
		 */
		public static function getClass(value:*):Class
		{
			return getDefinitionByName(ClassUtils.getQualifiedName(value)) as Class;
		}

		/**
		 *
		 */
		public static function getClassName(value:*):String
		{
			var data:Array = getQualifiedClassName(value).split('::');
			return data[1];
		}

		/**
		 *
		 */
		public static function callMethod(instance:Object, method:String, args:Array=null):*
		{
			if (!instance.hasOwnProperty(method) || !(instance[method] is Function)) throw new Error('No method ' + method + 'on  instance');
			var func:Function = (instance[method] as Function);
			return func.apply(instance, args);
		}

		/**
		 *
		 */
		public static function callMethodIfType(instance:Object, type:Class, method:String, args:Array=null):*
		{
			if (!(instance is type)) return null;
			return ClassUtils.callMethod(instance, method, args);
		}
	}
}