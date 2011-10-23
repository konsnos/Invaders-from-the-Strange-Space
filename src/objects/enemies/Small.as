package objects.enemies 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import objects.Explosion;
	import objects.bullets.Bullet;
	import GlobalVariables;
	/**
	 * ...
	 * @author konsnos
	 */
	public class Small extends Alien 
	{
		public static const Points:uint = 10;
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
			sprite = new Spritemap(GlobalVariables.IMG_ENEMY_S, 32, 32);
			sprite.smooth = true;
			sprite.add("idle", [0, 1, 2, 3, 4, 5, 5, 5, 5, 5, 5, 5], 16, true);
			
			listUpdateS = false;
			
			super();
			
			hpS = 1;
			
			setHitbox(sprite.width - 12, sprite.height - 4, -6, -1);
			
			graphic = sprite;
			sprite.play("idle");
			
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
				if (sprite.locked)
				{
					sprite.unlock();
				}
				CheckIfShot();
			}else if (GlobalVariables.gameState == GlobalVariables.PAUSE)
			{
				if (!sprite.locked)
				{
					sprite.lock();
				}
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
		
		override public function CheckIfShot():void 
		{
			super.CheckIfShot();
		}
		
		override public function destroy(points:uint = Small.Points):void 
		{
			list--;
			listUpdateS = true;
			Explosion(world.create(Explosion)).reset(this.x + this.halfWidth, this.y + this.halfHeight, 1, 0x8d388d, 10);
			if (list % 10 == 0)
			{
				Small.calculateMaxShots();
			}
			super.destroy(points);
		}
		
		override public function spawnBullet(x:Number, y:Number):void 
		{
			Bullet(world.create(Bullet)).reset(x, y, 250, 1, "Bullet_Enem_Small");
		}
	}
	
}