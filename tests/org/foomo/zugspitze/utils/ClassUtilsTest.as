package org.foomo.zugspitze.utils
{
	import flexunit.framework.Assert;

	import org.foomo.zugspitze.utils.ClassUtils;

	public class ClassUtilsTest
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
		public function testGetQualifiedName():void
		{
			Assert.assertEquals(ClassUtils.getQualifiedName(ClassUtilsTest), 'org.foomo.zugspitze.utils.ClassUtilsTest');
		}
	}
}