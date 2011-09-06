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
			
			speed = 200;
			damage = 1;
			
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