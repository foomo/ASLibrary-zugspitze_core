package org.foomo.zugspitze.utils
{
	import flash.display.Sprite;

	import flexunit.framework.Assert;

	public class DisplayObjectContainerUtilsTest
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
		public function testAddChild():void
		{
			var parent:Sprite = new Sprite;
			var child:Sprite = new Sprite;
			Assert.assertEquals(parent.numChildren, 0);
			DisplayObjectContainerUtils.addChild(child, parent);
			Assert.assertEquals(parent.numChildren, 1);
		}

		[Test]
		public function testRemoveChild():void
		{
			var parent:Sprite = new Sprite;
			var child:Sprite = new Sprite;
			parent.addChild(child);
			Assert.assertEquals(parent.numChildren, 1);
			DisplayObjectContainerUtils.removeChild(child, parent);
			Assert.assertEquals(parent.numChildren, 0);
		}
	}
}