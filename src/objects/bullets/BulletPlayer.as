package objects.bullets 
{
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author konsnos
	 */
	public class BulletPlayer extends Bullet 
	{
		public static var list:uint;
		public static var bulletsShot:uint; // For accuracy.
		public static var bulletsHitT:uint; // Bullets that hit the target.
		
		public function BulletPlayer()
		{
			super();
			
			graphic = image = new Image(GlobalVariables.IMG_BULLET_PLAYER);
			
			speed = -700;
			damage = 1;
			
			type = "bullet_P";
		}
		
		/**
		 * Resets the bullet of the player.
		 * @param	x The position on the x axis.
		 * @param	y The position on the y axis.
		 * @param	speed The speed and direction the bullet has.
		 * @param	damage The damage the bullet does.
		 * @param	img The image is not used, the default is fine. It's here only for override reasons.
		 * @param	type The type of the bullet.
		 */
		override public function reset(x:Number, y:Number, speed:int = -700, damage:uint = 1, 
		img:Class = null, type:String = "bullet_P"):void
		{
			super.reset(x, y, speed, damage, img, type);
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
		
		public static function resetBulletsAcc():void 
		{
			bulletsShot = 0;
			bulletsHitT = 0;
		}
		
		public static function findAcc():Number 
		{
			return bulletsHitT / bulletsShot;
		}
	}
}