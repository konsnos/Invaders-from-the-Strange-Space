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
	public class Medium extends Alien 
	{
		public static const Points:uint = 15;
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
		
		public function Medium() 
		{
			graphic = image = new Image(GlobalVariables.IMG_ENEMY_M);
			
			listUpdateS = false;
			
			super();
			
			width = image.width;
			height = image.height;
			
			type = "Medium";
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
		
		override public function spawnBullet(x:Number, y:Number):void 
		{
			BulletEnemy(world.create(BulletEnemy)).reset(x, y, 300,1,GlobalVariables.IMG_BULLET,"Bullet_Enem_Medium");
		}
		
		public static function resetList():void // Total number of entities existing.
		{
			list = 0;
			shootInterval = 0.3;
			timeElapsed = 0;
		}
		
		public static function calculateMaxShots():void 
		{
			maxShots = uint(list / 5);
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
		
		override public function destroy(points:uint = Medium.Points):void 
		{
			list--;
			listUpdateS = true;
			Explosion(world.create(Explosion)).reset(this.x + this.halfWidth, this.y + this.halfHeight, 1, 0x0044b5, 10);
			if (list % 5 == 0)
			{
				Small.calculateMaxShots();
			}
			super.destroy(points);
		}
		
	}

}