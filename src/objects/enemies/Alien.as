package objects.enemies 
{
	import flash.media.Sound;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Sfx;
	import objects.Actor;
	import objects.bullets.Bullet;
	import objects.bullets.BulletEnemy;
	import objects.bullets.BulletPlayer;
	import objects.FloatingText;
	import worlds.Level;
	import worlds.objs.Stats_Obj;
	import worlds.SoundSystem;
	
	/**
	 * ...
	 * @author konsnos
	 */
	public class Alien extends Actor 
	{
		protected var sprite:Spritemap;
		
		public static var list:uint; // Total number of aliens in the game.
		public static var levelList:uint; // Starting number of aliens in the level.
		
		public static var speed:uint;
		public static var direction:int;
		
		protected var soundExplosion:Sfx;
		protected var soundHit:Sfx;
		
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
		
		public function Alien() 
		{
			super();
			
			soundExplosion = new Sfx(GlobalVariables.EXPLOSION[0]);
			soundHit = new Sfx(GlobalVariables.EXPLOSION[1]);
			
		}
		
		public function reset(x:Number, y:Number):void 
		{
			this.x = x;
			this.y = y;
			list++;
		}
		
		override public function update():void 
		{
			
		}
		
		public static function resetList():void 
		{
			list = 0;
		}
		
		public function shoot():void 
		{
			spawnBullet(this.x + halfWidth, this.y + height);
		}
		
		public function spawnBullet(x:Number, y:Number):void 
		{
			BulletEnemy(world.create(BulletEnemy)).reset(x, y, 350,1,GlobalVariables.IMG_BULLET,"Bullet_Enem_Small");
		}
		
		public function walkOn(speed:uint, direction:int):void 
		{
			this.x += speed * direction;
		}
		
		public static function reverseDirection():void 
		{
			direction *= -1;
		}
		
		public function ComeCloser(speed:uint):void 
		{
			this.y += speed;
		}
		
		public function CheckIfShot():void 
		{
			var b:Bullet = collide("bullet_P", x, y) as Bullet;
			
			if (b)
			{
 				takeDamage(b.damageG);
				BulletPlayer.bulletsHitT++;
				b.destroy();
			}
		}
		
		override public function takeDamage(damageTaken:uint):void 
		{
			SoundSystem.play(soundHit, this.centerX);
			super.takeDamage(damageTaken);
		}
		
		/**
		 * Recycles the Alien. Plays the explosion sound and removes 1 from the list.
		 * Then it calculates the dead ratio to increase the movement speed.
		 */
		override public function destroy(points:uint = 0):void 
		{
			Stats_Obj.scoreS = points;
			SoundSystem.play(soundExplosion, this.centerX);
			FloatingText(world.create(FloatingText)).reset(this.x + this.halfWidth, this.y+halfHeight, points.toString());
			list--;
			var deadRatio:Number = (list + ((list - levelList) / -2)) / levelList;
			Level(FP.world).changeAlienMovSpeed(deadRatio);
			super.destroy();
		}
		
	}

}