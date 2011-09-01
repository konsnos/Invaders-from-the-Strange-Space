package objects.bullets 
{
	/**
	 * ...
	 * @author ...
	 */
	public class BulletEnemy extends Bullet 
	{
		
		public function BulletEnemy() 
		{
			super();
			
			speed = 200;
			damage = 1;
			
			type = "bullet_L"
		}
		
		override public function reset(x:Number, y:Number):void
		{
			super.reset(x, y);
		}
		
		override public function update():void
		{
			super.update();
		}
		
	}

}