package org.foomo.zugspitze.utils
{
	import flash.display.MovieClip;
	import flash.display.Sprite;

	import flexunit.framework.Assert;

	public class DisplayObjectUtilsTest
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
		public function testGetParentByClass():void
		{
			var parent:MovieClip = new MovieClip;
			var child:Sprite = new Sprite;
			parent.addChild(child);
			Assert.assertEquals(DisplayObjectUtils.getParentByClass(child, MovieClip), parent);
		}
	}
}