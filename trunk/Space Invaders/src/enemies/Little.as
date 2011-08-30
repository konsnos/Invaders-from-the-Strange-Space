package enemies 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	import objects.bullets.Bullet;
	import objects.GlobalVariables;
	/**
	 * ...
	 * @author konsnos
	 */
	public class Little extends Alien 
	{
		private static var image:Image;
		public static var points:Number;
		
		private static var speed:Number;
		
		private static var listUpdate:Boolean;
		public function get listUpdateP():Boolean 
		{ 
			return listUpdate;
		}
		public function set listUpdateP(setValue:Boolean):void 
		{
			listUpdate = setValue;
		}
		
		public function Little(x:Number, y:Number) 
		{
			graphic = image = new Image(GlobalVariables.IMG_ENEMY_S);
			
			image.scale *= 0.7;
			
			listUpdate = false;
			
			super(x, y);
			
			hp = 1;
			speed = 15;
			
			width = image.width * image.scale;
			height = image.height * image.scale;
			
			type = "little";
			points = 10;
		}
		
		override public function update():void 
		{
			super.update();
			
			CollisionDetection();
		}
		
		public function walkOn():void 
		{
			this.x += speed;
		}
		
		public static function reverseDirection():void 
		{
			speed *= -1;
		}
		
		public function comeCloser():void 
		{
			this.y += Math.abs(speed) * 2;
		}
		
		public function CollisionDetection():void 
		{
			var b:Bullet = collide("bullet_P", x, y) as Bullet;
			
			if (b)
			{
				b.destroy();
				this.destroy();
				listUpdate = true;
			}
		}
	}
	
}