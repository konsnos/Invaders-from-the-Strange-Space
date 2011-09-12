package objects.enemies 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	import objects.bullets.Bullet;
	import objects.bullets.BulletEnemy;
	import objects.Explosion;
	import worlds.objs.Stats_Obj;
	/**
	 * ...
	 * @author konsnos
	 */
	public class Medium extends Alien 
	{
		public static var list:Number;
		public static var timeElapsed:Number;
		public static var direction:Number;
		private static var maxShots:uint; // The amount of shots Medium aliens can shoot in game.
		private static var WhoShoots:uint; // The Medium that shoots.
		public static var shootInterval:Number; // The interval the Medium shoots.
		
		private static var listUpdate:Boolean; // Checks if the list with the Medium aliens needs to be updated.
		
		// Gets-Sets
		public static function get listUpdateG():Boolean
		{ 
			return listUpdate;
		}
		public static function get WhoShootsG():uint
		{
			return WhoShoots;
		}
		public static function get maxShotsG():uint 
		{
			return maxShots;
		}
		
		public function Medium(x:Number, y:Number) 
		{
			graphic = image = new Image(GlobalVariables.IMG_ENEMY_M);
			
			image.scale *= 0.7;
			
			listUpdateS = false;
			
			super(x, y);
			
			hpS = 2;
			speed = 15;
			direction = 1;
			points = 15;
			
			width = image.width * image.scale;
			height = image.height * image.scale;
			
			type = "Medium";
			
			list++;
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
			BulletEnemy(world.create(BulletEnemy)).reset(x, y, 350,1,GlobalVariables.IMG_BULLET_REDRECT,"Bullet_Enem_Medium");
		}
		
		public static function resetList():void // Total number of entities existing.
		{
			list = 0;
			shootInterval = 0.5;
			timeElapsed = 0;
		}
		
		public static function calculateMaxShots():void 
		{
			maxShots = (list / 5) as uint;

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
				Explosion(world.create(Explosion)).reset(this.x + this.halfWidth, this.y + this.halfHeight, 1, 0xff69b4, 5);
				b.destroy();
			}
		}
		
		override public function destroy():void 
		{
			Stats_Obj.scoreS = points;
			list--;
			listUpdateS = true;
			Explosion(world.create(Explosion)).reset(this.x + this.halfWidth, this.y + this.halfHeight, 1, 0xff69b4);
			if (list % 5 == 0)
			{
				Small.calculateMaxShots();
			}
			super.destroy();
		}
		
	}

}