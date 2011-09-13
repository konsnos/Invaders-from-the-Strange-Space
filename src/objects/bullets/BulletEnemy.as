package objects.bullets 
{
	import net.flashpunk.graphics.Image;
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
			
			speed = 650;
			damage = 1;
			
			type = "bullet_e";
		}
		
		override public function update():void
		{
			super.update();
		}
		
		override public function reset(x:Number, y:Number, speed:uint = 350, damage:uint = 1, 
		image:Image = null, type:String = "Bullet_Enem"):void
		{
			super.reset(x, y);
			
			graphic = this.image = image;
			
			this.speed = speed;
			this.damage = damage;
			
			this.type = type;
			
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