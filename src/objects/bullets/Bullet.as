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
		protected var speed:Number;
		protected var damage:Number;
		
		// Gets-Sets
		public function get damageG():Number 
		{
			return damage;
		}
		
		public function Bullet() 
		{
			graphic = image = new Image(GlobalVariables.IMG_BULLET_PLAYER);
			
			type = "bullet";
			
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
		
		public function reset(x:Number, y:Number, speed:uint = 0, damage:uint = 1, img:Image = null, type:String = null):void 
		{
			this.x = x;
			this.y = y;
			
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