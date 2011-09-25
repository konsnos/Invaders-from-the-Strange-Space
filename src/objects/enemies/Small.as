package objects.enemies 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	
	import objects.Explosion;
	import objects.bullets.Bullet;
	import objects.bullets.BulletEnemy;
	import worlds.Level;
	import worlds.objs.Stats_Obj;
	import GlobalVariables;
	/**
	 * ...
	 * @author konsnos
	 */
	public class Small extends Alien 
	{
		public static var list:Number;
		public static var timeElapsed:Number;
		private static var maxShots:uint; // The amount of shots Small aliens can shoot in game.
		private static var WhoShoots:uint; // The Small that shoots.
		public static var shootInterval:Number; // The interval the Smalls shoots.
		
		public static function get WhoShootsG():uint
		{
			return WhoShoots;
		}
		public static function get maxShotsG():uint 
		{
			return maxShots;
		}
		
		public function Small()
		{
			graphic = image = new Image(GlobalVariables.IMG_ENEMY_S);
			
			listUpdateS = false;
			
			super();
			
			hpS = 1;
			speed = 15;
			direction = 1;
			points = 10;
			
			width = image.width;
			height = image.height;
			
			type = "Small";
		}
		
		override public function reset(x:Number, y:Number):void 
		{
			super.reset(x, y);
			if (hpG == 0)
			{
				hpS = 1;
			}
			direction = 1;
			list++;
			listUpdateS = false;
		}
		
		override public function update():void 
		{
			if (GlobalVariables.gameState == GlobalVariables.PLAYING)
			{
				CheckIfShot();
			}
		}
		
		public static function resetList():void // Total number of entities existing.
		{
			list = 0;
			shootInterval = 0.5;
			timeElapsed = 0;
		}
		
		public static function calculateMaxShots():void 
		{
			maxShots = uint(list / 10);
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
				b.destroy();
			}
		}
		
		override public function destroy():void 
		{
			Stats_Obj.scoreS = points;
			list--;
			listUpdateS = true;
			Explosion(world.create(Explosion)).reset(this.x + this.halfWidth, this.y + this.halfHeight, 1, 0x7138c6, 10);
			if (list % 10 == 0)
			{
				Small.calculateMaxShots();
			}
			super.destroy();
		}
		
		override public function spawnBullet(x:Number, y:Number):void 
		{
			BulletEnemy(world.create(BulletEnemy)).reset(x, y, 350, 1, GlobalVariables.IMG_BULLET, "Bullet_Enem_Small");
		}
	}
	
}