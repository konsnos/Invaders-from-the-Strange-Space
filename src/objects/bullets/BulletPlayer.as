package objects.bullets 
{
	/**
	 * ...
	 * @author konsnos
	 */
	public class BulletPlayer extends Bullet 
	{
		private static var BulletsExisting:Number;
		public static function set PlayerShotsS(setValue:Number):void
		{
			BulletsExisting = setValue;
		}
		public static function get PlayerShotsG():Number
		{
			return BulletsExisting;
		}
		
		public function BulletPlayer() 
		{
			super();
			
			speed = -300;
			damage = 1;
			
			type = "bullet_P";
		}
		
		override public function update():void 
		{
			super.update();
		}
		
		override public function reset(x:Number, y:Number):void
		{
			super.reset(x, y);
			BulletsExisting++;
		}
		
		override public function removed():void 
		{
			BulletsExisting--;
		}
		
	}

}