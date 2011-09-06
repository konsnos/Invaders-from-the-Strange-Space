package objects.bullets 
{
	/**
	 * ...
	 * @author konsnos
	 */
	public class BulletEnemy extends Bullet 
	{
		public static var list:uint;
		
		public function BulletEnemy() 
		{
			super();
			
			graphic = GlobalVariables.IMG_BULLET_REDRECT;
			
			speed = 350;
			damage = 1;
			
			layer = 1;
			
			type = "bullet_L"
		}
		
		override public function update():void
		{
			super.update();
		}
		
		override public function reset(x:Number, y:Number):void
		{
			super.reset(x, y);
			BulletEnemy.list++;
		}
		
		override public function removed():void 
		{
			super.removed();
			BulletEnemy.list--;
		}
		
		public static function resetList():void 
		{
			list = 0;
		}
		
	}

}