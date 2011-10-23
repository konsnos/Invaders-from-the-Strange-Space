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
	public class Bonus extends Alien 
	{
		public static const Points:uint = 40;
		public static var list:Number;
		public var timeThisWillShoot:Number;
		private var speedB:uint;
		private var directionB:Number;
		private var timeElapsed:Number;
		
		public function Bonus() 
		{
			sprite = new Spritemap(GlobalVariables.IMG_ENEMY_B, 32, 32);
			sprite.smooth = true;
			sprite.add("idle", [0], 1, false);
			
			listUpdateS = false;
			
			hpS = 1;
			speedB = 200;
			
			super();
			
			setHitbox(sprite.width, sprite.height - 14, 0, -6);
			
			layer = 0;
			type = "Bonus";
			graphic = sprite;
			sprite.play("idle");
		}
		
		override public function update():void 
		{
			if (GlobalVariables.gameState == GlobalVariables.PLAYING)
			{
				CheckIfShot();
				move();
				
				if (timeElapsed > timeThisWillShoot)
				{
					shoot();
					timeThisWillShoot = FP.rand(3);
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
		
		override public function shoot():void 
		{
			super.shoot();
		}
		
		/**
		 * Spawns a bullet.
		 * @param	x Position in the x axis.
		 * @param	y Position in the y axis.
		 */
		override public function spawnBullet(x:Number, y:Number):void
		{
			Bullet(world.create(Bullet)).reset(x, y, 500, 3, "Bullet_Enem_Bonus");
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
			
			if (y != 0)
			{
				this.y = y;
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
			Explosion(world.create(Explosion)).reset(this.x + this.halfWidth, this.y + this.halfHeight, 1, 0x8dc61c);
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