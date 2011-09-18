package objects.player 
{
	import flash.display.BitmapData;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import objects.enemies.Small;
	import worlds.objs.BlackScreen;
	import worlds.objs.Stats_Obj;
	
	import worlds.objs.Lost_Obj;
	import worlds.Level;
	import objects.Actor;
	import objects.Explosion;
	import objects.bullets.BulletPlayer;
	import objects.bullets.Bullet;
	import objects.enemies.Small;
	import GlobalVariables;
	
	/**
	 * ...
	 * @author konsnos
	 */
	public class Player extends Actor
	{
		private var speed:Number;
		public static var life:uint;
		private var fade:BlackScreen;
		
		private var BulletsMax:Number;
		private var BulletsShot:Number;
		
		private var soundShoot:Sfx = new Sfx(GlobalVariables.SHOOT);
		private var soundExplosion:Sfx = new Sfx(GlobalVariables.EXPLOSIONP);
		private var soundExplosionm:Sfx = new Sfx(GlobalVariables.EXPLOSIONPM);
		
		public static function getlife():uint 
		{
			return life;
		}
		
		public function Player(x:Number, y:Number) 
		{
			super();
			fade = new BlackScreen(0xff0000);
			FP.world.add(fade);
			
			graphic = image = new Image(GlobalVariables.IMG_PLAYER);
			image.scale = 0.8;
			
			hpS = 3;
			life = hpG;
			Stats_Obj.updateStats();
			speed = 270;
			
			this.x = x - image.width / 2;
			this.y = y;
			
			width = image.width * image.scale;
			height = image.height * image.scale;
			
			type = "player";
			
			BulletsMax = 2;
		}
		
		override public function update():void 
		{
			if (GlobalVariables.gameState == GlobalVariables.PLAYING)
			{
				/**************** MOVEMENT ****************/
				movement();
				
				/**************** SHOOT BULLET ****************/
				if (Input.pressed("shoot"))
				{
					shoot();
				}
				
				/**************** Check if shot by enemies ****************/
				checkIfShot();
			}
		}
		
		public function movement():void 
		{
			if (Input.check("right"))
			{
				this.x += speed * FP.elapsed;
				if (this.x > FP.width - image.width)
				{
					this.x = FP.width - image.width;
				}
			}
			else if (Input.check("left"))
			{
				this.x -= speed * FP.elapsed;
				if (this.x < 0)
				{
					this.x = 0;
				}
			}
		}
		
		public function shoot():void 
		{
			if (BulletPlayer.list < BulletsMax )
			{
				soundShoot.play(1, GlobalVariables.panSound(this.centerX));
				spawnBullet(this.x + halfWidth, this.y);
			}
		}
		
		public function spawnBullet(x:Number, y:Number):void 
		{
			BulletPlayer(world.create(BulletPlayer)).reset(x, y);
		}
		
		public function checkIfShot():void
		{
			var b:Bullet = collideTypes(["Bullet_Enem_Small", "Bullet_Enem_Medium", "Bullet_Enem_Big", "Bullet_Enem_Bonus"], x, y) as Bullet;
			
			if (b)
			{
				takeDamage(b.damageG);
				fade.fadeOut(0.2, 0.8, true );
				soundExplosionm.play(1,GlobalVariables.panSound(this.centerX));
				Explosion(world.create(Explosion)).reset(this.x + this.halfWidth, this.y + this.halfHeight, -1, 0xffff00);
				b.destroy();
				life = hpG;
				Stats_Obj.updateStats();
			}
		}
		
		override public function destroy():void
		{
			Explosion(world.create(Explosion)).reset(this.x + this.halfWidth, this.y + this.halfHeight, -1, 0xffff00);
			soundExplosion.play(1, GlobalVariables.panSound(this.centerX));
			super.destroy();
		}
		
	}

}