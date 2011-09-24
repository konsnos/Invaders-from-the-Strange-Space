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
			
			graphic = image = new Image(GlobalVariables.IMG_BULLET);
			
			speed = 650;
			damage = 1;
			
			type = "bullet_e";
		}
		
		/**
		 * Resets the position, damage, image and type of the bullet
		 * @param	x Position in the x axis.
		 * @param	y Position in the y axis.
		 * @param	speed Speed of the bullet.
		 * @param	damage Damage dealt by the bullet.
		 * @param	image The image is not used, the default is fine. It's here only for override reasons.
		 * @param	type Type of the bullet.
		 */
		override public function reset(x:Number, y:Number, speed:int = 350, damage:uint = 1, 
		image:Class = null, type:String = "Bullet_Enem"):void
		{
			super.reset(x, y, speed, damage, image, type);
			
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