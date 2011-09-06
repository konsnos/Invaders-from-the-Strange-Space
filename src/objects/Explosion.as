package objects 
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Emitter;
	
	/**
	 * ...
	 * @author konsnos
	 */
	public class Explosion extends Entity 
	{
		private var explosion:Emitter;
		protected const EXPLOSION_SIZE:uint = 15;
		
		public function Explosion() // Need also color
		{
			explosion = new Emitter(new BitmapData(2, 2, false));
			explosion.newType("explode", [0]);
			explosion.relative = false;
			collidable = false;
		}
		
		override public function update():void
		{
			if (explosion.particleCount == 0)
			{
				this.world.recycle(this);
			}
		}
		
		public function explode():void 
		{
			for (var i:uint = 0; i < EXPLOSION_SIZE; i++)
			{
				explosion.emit("explode", x, y);
			}
		}
		
		public function reset(x:Number,y:Number,sign:Number, color:uint):void 
		{
			explosion.x = x;
			explosion.y = y;
			explosion.setMotion("explode", 80*sign, 600, 4, 20*sign, -10, -0.5);
			explosion.setColor("explode", color);
			graphic = explosion;
			
			explode();
		}
		
	}

}