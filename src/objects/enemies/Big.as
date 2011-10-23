package objects.enemies 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import objects.bullets.Bullet;
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
			sprite = new Spritemap(GlobalVariables.IMG_ENEMY_L, 32, 32);
			sprite.smooth = true;
			sprite.add("idle", [0, 1, 2, 3, 4, 3, 2, 1], 8, true);
			sprite.add("shoot", [5, 6, 7, 8, 9, 8, 7, 6], 60, false);
			
			listUpdateS = false;
			
			super();
			
			setHitbox(sprite.width, sprite.height - 8, 0,-6)
			
			type = "Big";
			graphic = sprite;
			sprite.play("idle");
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
				if (sprite.locked)
				{
					sprite.unlock();
				}
				if (sprite.currentAnim == "shoot" && sprite.complete)
				{
					sprite.play("idle");
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
		
		override public function shoot():void 
		{
			sprite.play("shoot");
			super.shoot();
		}
		
		override public function spawnBullet(x:Number, y:Number):void 
		{
			Bullet(world.create(Bullet)).reset(x, y - 20, 400, 1, "Bullet_Enem_Big");
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
		
		override public function CheckIfShot():void 
		{
			super.CheckIfShot();
		}
		
		override public function takeDamage(damageTaken:uint):void 
		{
			Explosion(world.create(Explosion)).reset(this.x + this.halfWidth, this.y + this.halfHeight, 1, 0x38c638, 5);
			super.takeDamage(damageTaken);
		}
		
		override public function destroy(points:uint = Big.Points):void 
		{
			list--;
			listUpdateS = true;
			Explosion(world.create(Explosion)).reset(this.x + this.halfWidth, this.y + this.halfHeight, 1, 0x38c638);
			if (list % 2 == 0)
			{
				Small.calculateMaxShots();
			}
			super.destroy(points);
		}
		
	}

}