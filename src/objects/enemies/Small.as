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
		private static var image:Image;
		public static var points:Number;
		public static var list:Number;
		public static var timeElapsed:Number;
		
		private static var speed:Number;
		private static var maxShots:uint; // The amount of shots Small aliens can shoot in game.
		private static var SmallShooting:uint; // The Small that shoots.
		public static var shootInterval:Number; // The interval the Smalls shoots.
		
		private static var listUpdate:Boolean; // Checks if the list with the Small aliens needs to be updated.
		
		// Gets-Sets
		public static function get listUpdateG():Boolean
		{ 
			return listUpdate;
		}
		public static function set listUpdateS(setValue:Boolean):void 
		{
			listUpdate = setValue;
		}
		public static function get SmallShootingG():uint
		{
			return SmallShooting;
		}
		public static function get maxShotsG():uint 
		{
			return maxShots;
		}
		
		public function Small(x:Number, y:Number)
		{
			graphic = image = new Image(GlobalVariables.IMG_ENEMY_S);
			
			image.scale *= 0.7;
			soundExplosion = new Sfx(GlobalVariables.EXPLOSION);
			
			listUpdateS = false;
			
			super(x, y);
			
			hpS = 1;
			speed = 15;
			fireChance = 0.0003;
			
			width = image.width * image.scale;
			height = image.height * image.scale;
			
			type = "Small";
			
			list++;
		}
		
		override public function update():void 
		{
			if (Level.gameStateG == GlobalVariables.PLAYING)
			{
				CheckIfShot();
			}
		}
		
		public function Shoot():void 
		{
			spawnBullet(this.x + halfWidth, this.y + height);
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
			shootInterval = 0.5;
			timeElapsed = 0;
		}
		
		public static function calculateMaxShots():void 
		{
			maxShots = (list / 10) as uint;

		}
		
		public static function calculateWhichShoot():uint
		{
			return SmallShooting = FP.random * list;
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
			}
		}
		
		override public function destroy():void 
		{
			Stats_Obj.scoreS = points;
			list--;
			listUpdateS = true;
			Explosion(world.create(Explosion)).reset(this.x + this.halfWidth, this.y + this.halfHeight, 1, 0x00FF00);
			if (list % 10 == 0)
			{
				Small.calculateMaxShots();
			}
			super.destroy();
		}
	}
	
}