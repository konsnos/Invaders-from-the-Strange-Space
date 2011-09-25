package objects.enemies 
{
	import flash.media.Sound;
	import flash.sampler.NewObjectSample;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Sfx;
	import objects.Actor;
	import objects.bullets.BulletEnemy;
	import objects.FloatingText;
	import worlds.objs.Stats_Obj;
	import worlds.SoundSystem;
	
	/**
	 * ...
	 * @author konsnos
	 */
	public class Alien extends Actor 
	{
		public static var list:Number; // Total number of aliens in the game.
		
		protected var speed:Number;
		protected var direction:Number;
		
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
		
		public function Shoot():void 
		{
			spawnBullet(this.x + halfWidth, this.y + height);
		}
		
		public function spawnBullet(x:Number, y:Number):void 
		{
			BulletEnemy(world.create(BulletEnemy)).reset(x, y, 350,1,GlobalVariables.IMG_BULLET,"Bullet_Enem_Small");
		}
		
		public function walkOn():void 
		{
			this.x += speed * direction;
		}
		
		public function reverseDirection():void 
		{
			direction *= -1;
		}
		
		public function ComeCloser():void 
		{
			this.y += Math.abs(speed) * 2;
		}
		
		override public function takeDamage(damageTaken:Number):void 
		{
			SoundSystem.play(soundHit, this.centerX);
			super.takeDamage(damageTaken);
		}
		
		/**
		 * Recycles the Alien. Plays the explosion sound and removes 1 from the list.
		 */
		override public function destroy(points:uint = 0):void 
		{
			Stats_Obj.scoreS = points;
			SoundSystem.play(soundExplosion, this.centerX);
			FloatingText(world.create(FloatingText)).reset(this.x + this.halfWidth, this.y+halfHeight, points.toString());
			list--;
			super.destroy();
		}
		
	}

}