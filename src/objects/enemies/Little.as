package objects.enemies 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	import objects.bullets.Bullet;
	import objects.bullets.BulletEnemy;
	import worlds.Level;
	import worlds.Stats_Obj;
	import GlobalVariables;
	/**
	 * ...
	 * @author konsnos
	 */
	public class Little extends Alien 
	{
		private static var image:Image;
		public static var points:Number;
		public static var list:Number;
		
		private static var speed:Number;
		
		private static var listUpdate:Boolean; // Checks if the list with the Little aliens needs to be updated
		
		// Gets-Sets
		public static function get listUpdateG():Boolean
		{ 
			return listUpdate;
		}
		public static function set listUpdateS(setValue:Boolean):void 
		{
			listUpdate = setValue;
		}
		
		public function Little(x:Number, y:Number) 
		{
			graphic = image = new Image(GlobalVariables.IMG_ENEMY_S);
			
			image.scale *= 0.7;
			
			listUpdateS = false;
			
			super(x, y);
			
			hpS = 1;
			speed = 15;
			fireChance = 0.0003;
			
			width = image.width * image.scale;
			height = image.height * image.scale;
			
			type = "little";
			
			list++;
		}
		
		override public function update():void 
		{
			if (Level.gameStateG == GlobalVariables.PLAYING)
			{
				ShootCheck();
				
				CheckIfShot();
			}
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
		
		public static function resetList():void // Total number of entities existing.
		{
			list = 0;
			points = 10;
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
		
		override public function destroy():void 
		{
			Stats_Obj.scoreS = points;
			list--;
			super.destroy();
		}
	}
	
}