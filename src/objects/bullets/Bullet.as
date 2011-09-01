package objects.bullets
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	import objects.GlobalVariables;
	
	/**
	 * ...
	 * @author konsnos
	 */
	public class Bullet extends Entity 
	{
		protected var image:Image;
		protected var speed:Number;
		
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
			this.y -= speed * FP.elapsed;
		}
		
		public function destroy():void 
		{
			FP.world.recycle(this);
		}
		
		public function reset(x:Number,y:Number):void 
		{
			this.x = x;
			this.y = y;
		}
		
	}

}