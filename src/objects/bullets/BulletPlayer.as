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
		
		public function BulletPlayer() 
		{
			super();
			
			speed = -500;
			damage = 1;
			
			type = "bullet_P";
		}
		
		override public function update():void 
		{
			super.update();
		}
		
		override public function reset(x:Number, y:Number, speed:uint = -500, damage:uint = 1, 
		img:Image = null, type:String = "bullet_P"):void
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