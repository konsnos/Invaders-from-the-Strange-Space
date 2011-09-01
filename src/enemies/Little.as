package enemies 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	import objects.bullets.Bullet;
	import objects.bullets.BulletEnemy;
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
		
		private static var listUpdate:Boolean; // Checks if the list with the Little aliens needs to be updated
		
		// Gets-Sets
		public function get listUpdateG():Boolean
		{ 
			return listUpdate;
		}
		public function set listUpdateS(setValue:Boolean):void 
		{
			listUpdate = setValue;
		}
		
		public function Little(x:Number, y:Number) 
		{
			graphic = image = new Image(GlobalVariables.IMG_ENEMY_S);
			
			image.scale *= 0.7;
			
			listUpdateS = false;
			
			super(x, y);
			
			hp = 1; // Να δοκιμάσω να χρησιμοποιήσω την Set
			speed = 15;
			fireChance = 0.0003;
			
			width = image.width * image.scale;
			height = image.height * image.scale;
			
			type = "little";
			points = 10;
		}
		
		override public function update():void 
		{
			super.update();
			
			ShootCheck();
			
			CheckIfShot();
		}
		
		private function ShootCheck():void 
		{
			var checkIfShoot:Number = FP.random;
			if (checkIfShoot < fireChance)
			{
				spawnBullet(this.x + halfWidth, this.y + height);
			}
		}
		
		private function spawnBullet(x:Number, y:Number):void 
		{
			BulletEnemy(world.create(BulletEnemy)).reset(x, y);
		}
		
		public function walkOn():void 
		{
			this.x += speed;
		}
		
		public static function reverseDirection():void 
		{
			speed *= -1;
		}
		
		public function ComeCloser():void 
		{
			this.y += Math.abs(speed) * 2;
		}
		
		public function CheckIfShot():void 
		{
			var b:Bullet = collide("bullet_P", x, y) as Bullet;
			
			if (b)
			{
				takeDamage(b.damageG);
				b.destroy();
				listUpdateS = true;
			}
		}
	}
	
}