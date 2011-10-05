package objects.player 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import objects.enemies.Small;
	import worlds.objs.BlackScreen;
	import worlds.objs.Stats_Obj;
	import worlds.SoundSystem;
	
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
		private var mouseDelta:int;
		private var recoilY:NumTween;
		private var BulletsMax:Number;
		private var playerSpr:Spritemap = new Spritemap(GlobalVariables.IMG_PLAYER, 64, 64);;
		
		private var soundShoot:Sfx = new Sfx(GlobalVariables.SHOOT);
		private var soundExplosion:Sfx = new Sfx(GlobalVariables.EXPLOSIONP);
		private var soundExplosionm:Sfx = new Sfx(GlobalVariables.EXPLOSIONPM);
		
		public static function getlife():uint 
		{
			return life;
		}
		
		public function Player() 
		{
			super();
			fade = new BlackScreen(0xff0000);
			recoilY = new NumTween();
			FP.world.add(fade);
			FP.world.addTween(recoilY);
			
			playerSpr.add("idle", [0, 1, 2, 1], 15, true);
			image = new Image(GlobalVariables.IMG_PLAYER, new Rectangle(0, 0, 64, 64));
			playerSpr.smooth = true;
			image.smooth = true;
			var size:int = Math.ceil(Math.sqrt(image.width * image.width + image.height * image.height));
			maskBmp = new BitmapData(size, size, true, 0);
			maskObj = new Pixelmask(maskBmp);
			maskBmp.fillRect(maskBmp.rect, 0);
			this.mask = maskObj;
			image.render(maskBmp, FP.zero, FP.zero);
			
			speed = 300;
			
			type = "player";
			
			BulletsMax = 3;
			
			graphic = playerSpr;
			playerSpr.play("idle");
		}
		
		public function reset(x:Number, y:Number, dif:Boolean = false, hp:uint = 3):void 
		{
			this.x = x - image.width / 2;
			this.y = y;
			if (dif)
			{
				resetHp(hp);
			}else
			{
				resetHp(3);
			}
		}
		
		public function resetHp(hp:uint = 3):void 
		{
			while (hpG != hp) 
			{
				if (hpG < hp)
				{
					hpS = 1;
				}else if (hpG > hp)
				{
					hpS = -1;
				}
			}
			life = hpG;
			Stats_Obj.updateStats();
		}
		
		override public function update():void 
		{
			if (GlobalVariables.gameState == GlobalVariables.PLAYING)
			{
				if (playerSpr.locked)
				{
					playerSpr.unlock();
				}
				/**************** MOVEMENT ****************/
				movement();
				
				/**************** SHOOT BULLET ****************/
				shootInput();
				
				/**************** Check if shot by enemies ****************/
				checkIfShot();
			}else
			{
				if (GlobalVariables.gameState == GlobalVariables.PAUSE)
				{
					if (!playerSpr.locked)
					{
						playerSpr.lock();
					}
				}
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
			
			if (recoilY.active)
			{
				this.y = recoilY.value;
			}
			
			if (GlobalVariables.MOUSE)
			{
				mouseDelta = Input.mouseX - this.centerX
				if (mouseDelta > 0)						// Right
				{
					if (mouseDelta < speed * FP.elapsed)
					{
						this.x = Input.mouseX - this.width /2;
					}else 
					{
						this.x += speed * FP.elapsed;
					}
					if (this.x > FP.width - this.width) // Out of screen
					{
						this.x = FP.width - this.width;
					}
				}else if (mouseDelta < 0)				// Left
				{
					if (Math.abs(mouseDelta) < speed * FP.elapsed)
					{
						this.x = Input.mouseX - this.width/2;
					}else 
					{
						this.x -= speed * FP.elapsed;
					}
					if (this.x < 0)
					{
						this.x = 0;
					}
				}
			}
		}
		
		/**
		 * Checks if player shoots.
		 */
		private function shootInput():void 
		{
			if (Input.pressed("shoot"))
			{
				shoot();
			}else if (GlobalVariables.MOUSE)
			{
				if (Input.mousePressed)
				{
					shoot();
				}
			}
		}
		
		/**
		 * Spawns a player bullet.
		 */
		public function shoot():void 
		{
			if (BulletPlayer.list < BulletsMax )
			{
 				SoundSystem.play(soundShoot, this.centerX);
				recoilY.tween(400, 405, 0.1, Ease.backOut);
				recoilY.complete = recoilCompleted;
				spawnBullet(this.x + image.width / 2, this.y);
				BulletPlayer.bulletsShot++;
			}
		}
		
		private function recoilCompleted():void 
		{
			recoilY.tween(this.y, 400, 0.2, Ease.sineInOut);
			recoilY.complete = null;
		}
		
		public function spawnBullet(x:Number, y:Number):void 
		{
			BulletPlayer(world.create(BulletPlayer)).reset(x, y, -700, 1, GlobalVariables.IMG_BULLET_PLAYER, "bullet_P");
		}
		
		public function checkIfShot():void
		{
			var b:Bullet = collideTypes(["Bullet_Enem_Small", "Bullet_Enem_Medium", "Bullet_Enem_Big", "Bullet_Enem_Bonus"], x, y) as Bullet;
			
			if (b)
			{
				takeDamage(b.damageG);
				fade.fadeOut(0.2, 0.8, true);
				SoundSystem.play(soundExplosionm, this.centerX);
				//Explosion(world.create(Explosion)).reset(this.x + this.halfWidth, this.y + this.halfHeight, -1, 0xffff00);
				Explosion(world.create(Explosion)).reset(b.x, b.y, -1, 0xffff00, 5);
				b.destroy();
				life = hpG;
				Stats_Obj.updateStats();
			}
		}
		
		override public function destroy(points:uint = 0):void
		{
			if (world)
			{
				Explosion(world.create(Explosion)).reset(this.x + this.halfWidth, this.y + this.halfHeight, -1, 0xffff00);
				SoundSystem.play(soundExplosion, this.centerX);
				super.destroy();
			}
		}
		
	}

}