package objects.enemies 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	import objects.bullets.Bullet;
	import objects.bullets.BulletEnemy;
	import objects.Explosion;
	/**
	 * ...
	 * @author konsnos
	 */
	public class Big extends Alien 
	{
		public static const Points:uint = 20;
		public static var list:Number;
		public static var timeElapsed:Number;
		private static var maxShots:uint; // The amount of shots Medium aliens can shoot in game.
		private static var WhoShoots:uint; // The Medium that shoots.
		public static var shootInterval:Number; // The interval the Medium shoots.
		
		// Gets-Sets
		public static function get WhoShootsG():uint
		{
			return WhoShoots;
		}
		public static function get maxShotsG():uint 
		{
			return maxShots;
		}
		
		public function Big() 
		{
			graphic = image = new Image(GlobalVariables.IMG_ENEMY_L);
			
			image.scale *= 0.7;
			
			listUpdateS = false;
			
			super();
			
			speed = 15;
			direction = 1;
			
			width = image.width * image.scale;
			height = image.height * image.scale;
			
			type = "Big";
		}
		
		override public function reset(x:Number,y:Number):void 
		{
			super.reset(x, y);
			switch (hpG) 
			{
				case 0:
					hpS = 2;
					break;
				case 1:
					hpS = 1;
					break;
				default:
					break;
			}
			list++;
			direction = 1;
			listUpdateS = false;
		}
		
		override public function update():void 
		{
			if (GlobalVariables.gameState == GlobalVariables.PLAYING)
			{
				CheckIfShot();
			}
		}
		
		override public function spawnBullet(x:Number, y:Number):void 
		{
			BulletEnemy(world.create(BulletEnemy)).reset(x, y, 400,1,GlobalVariables.IMG_BULLET,"Bullet_Enem_Big");
		}
		
		public static function resetList():void // Total number of entities existing.
		{
			list = 0;
			shootInterval = 0.2;
			timeElapsed = 0;
		}
		
		public static function calculateMaxShots():void 
		{
			maxShots = uint(list / 2);
			if (maxShots == 0)
			{
				maxShots = 1;
			}
		}
		
		public static function calculateWhichShoot():uint
		{
			return WhoShoots = FP.random * list;
		}
		
		public function CheckIfShot():void 
		{
			var b:Bullet = collide("bullet_P", x, y) as Bullet;
			
			if (b)
			{
 				takeDamage(b.damageG);
				Explosion(world.create(Explosion)).reset(this.x + this.halfWidth, this.y + this.halfHeight, 1, 0x00FF00, 5);
				b.destroy();
			}
		}
		
		override public function destroy(points:uint = Big.Points):void 
		{
			list--;
			listUpdateS = true;
			Explosion(world.create(Explosion)).reset(this.x + this.halfWidth, this.y + this.halfHeight, 1, 0x00FF00);
			if (list % 2 == 0)
			{
				Small.calculateMaxShots();
			}
			super.destroy(points);
		}
		
	}

}