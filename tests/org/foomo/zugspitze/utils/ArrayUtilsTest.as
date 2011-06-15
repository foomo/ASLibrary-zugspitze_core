package org.foomo.zugspitze.utils
{
	import flexunit.framework.Assert;

	import org.foomo.zugspitze.utils.ArrayUtils;

	public class ArrayUtilsTest
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		[Before]
		public function setUp():void
		{
		}

		[After]
		public function tearDown():void
		{
		}

		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}

		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}

		//-----------------------------------------------------------------------------------------
		// ~ Test methods
		//-----------------------------------------------------------------------------------------

		[Test]
		public function testToArray():void
		{
			var obj:Object = {a:'a', b:'b', c:'c', d:'d'};
			var arr:Array = ArrayUtils.toArray(obj);
			Assert.assertTrue((arr is Array));
		}

		[Test]
		public function testGetItemIndex():void
		{
			var items:Array = ['a', 'b', 'c', 'd'];
			Assert.assertEquals(ArrayUtils.getItemIndex('b', items), 1);
		}
	}
}