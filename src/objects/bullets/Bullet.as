package objects.bullets
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	import worlds.Level;
	import GlobalVariables;
	
	/**
	 * ...
	 * @author konsnos
	 */
	public class Bullet extends Entity 
	{
		public static var list:uint;
		protected var image:Image;
		protected var speed:int;
		protected var damage:uint;
		
		// Gets-Sets
		public function get damageG():uint 
		{
			return damage;
		}
		
		public function Bullet()
		{
			graphic = image = new Image(GlobalVariables.IMG_BULLET);
			
			type = "bullet";
			layer = 1;
			
			speed = 0;
			width = image.width;
			height = image.height;
		}
		
		override public function update():void
		{
			if (GlobalVariables.gameState == GlobalVariables.PLAYING || 
			GlobalVariables.gameState == GlobalVariables.WIN ||
			GlobalVariables.gameState == GlobalVariables.LOST)
			{
				this.y += speed * FP.elapsed;
				
				if (this.y + height < 0)
				{
					destroy();
				}
				else if (this.y > FP.height)
				{
					destroy();
				}
			}
		}
		
		public function destroy():void 
		{
			FP.world.recycle(this);
		}
		
		/**
		 * Resets the position, damage, image and type of the bullet.
		 * @param	x Position in the x axis.
		 * @param	y Position in the y axis.
		 * @param	speed Speed of the bullet.
		 * @param	damage Damage dealt by the bullet.
		 * @param	img Image of the bullet.
		 * @param	type Type of the bullet.
		 */
		public function reset(x:Number, y:Number, speed:int = 0, damage:uint = 1, img:Class = null, type:String = null):void 
		{
			this.x = x;
			this.y = y;
			
			this.speed = speed;
			this.damage = damage;
			this.type = type;
			
			Bullet.list++;
		}
		
		override public function removed():void 
		{
			Bullet.list--;
		}
		
		public static function resetList():void 
		{
			list = 0;
		}
		
	}

}