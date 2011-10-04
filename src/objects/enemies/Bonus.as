package objects.enemies 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import objects.bullets.Bullet;
	import objects.bullets.BulletEnemy;
	import objects.Explosion;
	/**
	 * ...
	 * @author konsnos
	 */
	public class Bonus extends Alien 
	{
		public static const Points:uint = 40;
		public static var list:Number;
		public var timeThisWillShoot:Number;
		private var speedB:uint;
		private var directionB:int;
		private var timeElapsed:Number;
		
		public function Bonus() 
		{
			graphic = image = new Image(GlobalVariables.IMG_ENEMY_B);
			
			listUpdateS = false;
			
			hpS = 1;
			speedB = 200;
			
			super();
			
			width = image.width * image.scale;
			height = image.height * image.scale;
			
			layer = 0;
			type = "Bonus";
		}
		
		override public function update():void 
		{
			if (GlobalVariables.gameState == GlobalVariables.PLAYING)
			{
				CheckIfShot();
				move();
				
				if (timeElapsed > timeThisWillShoot)
				{
					Shoot();
					timeThisWillShoot = FP.rand(4);
					timeElapsed -= timeThisWillShoot;
					
				}
				
				timeElapsed += FP.elapsed;
			}
		}
		
		/**
		 * Moves the Bonus alien.
		 */
		public function move():void
		{
			this.x += (FP.elapsed * speedB) * directionB;
			
			if (this.x < -this.width || this.x > FP.width)
			{
				destroySilently();
			}
		}
		
		/**
		 * Resets the total number of Bonus alien existing.
		 */
		public static function resetList():void
		{
			list = 0;
		}
		
		/**
		 * Checks if the entity was shot.
		 */
		override public function CheckIfShot():void 
		{
			super.CheckIfShot();
		}
		
		/**
		 * calculates when the alien will shoot.
		 */
		public function calculateShootTime():void
		{
			timeThisWillShoot = FP.rand(3);
		}
		
		override public function Shoot():void 
		{
			super.Shoot();
		}
		
		/**
		 * Spawns a bullet.
		 * @param	x Position in the x axis.
		 * @param	y Position in the y axis.
		 */
		override public function spawnBullet(x:Number, y:Number):void
		{
			// Fix it
			BulletEnemy(world.create(BulletEnemy)).reset(x, y, 500, 3, GlobalVariables.IMG_BULLET, "Bullet_Enem_Bonus");
		}
		
		/**
		 * Resets the position of the Bonus.
		 */
		override public function reset(x:Number, y:Number):void 
		{
			if (hpG == 0)
			{
				hpS = 1;
			}
			Bonus.list++;
			Alien.list++;
			speedB = 280;
			timeElapsed = 0;
			directionB = FP.random;
			if (directionB > 0.5)
			{
				directionB = 1;
				this.x = -this.width;
				this.y = 10;
			}else
			{
				directionB = -1;
				this.x = FP.width;
				this.y = 10;
			}
			
			listUpdateS = true;
			calculateShootTime();
		}
		
		/**
		 * Recycles the Bonus alien. Erases it from the list. Spawns Explosion. Sets to score the points.
		 */
		override public function destroy(points:uint = Bonus.Points):void 
		{
			Bonus.list--;
			listUpdateS = true;
			Explosion(world.create(Explosion)).reset(this.x + this.halfWidth, this.y + this.halfHeight, 1, 0x8c8c71);
			super.destroy(points);
		}
		
		/**
		 * Recycles the Bonus alien. Erases it from the list, without explosion or sound.
		 */
		public function destroySilently():void 
		{
			Bonus.list--;
			Alien.list--;
			FP.world.recycle(this);
		}
	}

}