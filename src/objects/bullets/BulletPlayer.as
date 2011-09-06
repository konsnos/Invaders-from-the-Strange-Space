package objects.bullets 
{
	/**
	 * ...
	 * @author konsnos
	 */
	public class BulletPlayer extends Bullet 
	{
		public static var list:uint;
		private static var BulletsExisting:Number;
		
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
			BulletPlayer.list++;
		}
		
		override public function removed():void 
		{
			super.removed();
			BulletPlayer.list--;
		}
		
		public static function resetList():void 
		{
			list = 0;
		}
	}
}