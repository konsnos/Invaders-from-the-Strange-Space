package objects.player 
{
	import flash.display.BitmapData;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	import worlds.Lost_Obj;
	import worlds.Level;
	import objects.Actor;
	import objects.Explosion;
	import objects.bullets.BulletPlayer;
	import objects.bullets.Bullet;
	import objects.enemies.Little;
	import GlobalVariables;
	
	/**
	 * ...
	 * @author konsnos
	 */
	public class Player extends Actor 
	{
		private var speed:Number;
		
		private var BulletsMax:Number;
		private var BulletsShot:Number;
		
		private var little:Little;
		
		public function Player(x:Number, y:Number) 
		{
			super();
			
			graphic = image = new Image(GlobalVariables.IMG_PLAYER);
			image.scale = 0.8;
			
			hpS = 3;
			speed = 270;
			
			this.x = x - image.width / 2;
			this.y = y;
			
			width = image.width * image.scale;
			height = image.height * image.scale;
			
			type = "player";
			
			BulletsMax = 2;
			
			layer = 1;
		}
		
		override public function update():void 
		{
			if (Level.gameStateG == GlobalVariables.PLAYING)
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
				
				/**************** ALIENS COLLIDED WITH PLAYER ****************/
				little = collide("little", x, y) as Little;
				
				if (little)
				{
					hpS = -little.hpG;
				}
				
				little = null;
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
				spawnBullet(this.x + halfWidth, this.y);
			}
		}
		
		public function spawnBullet(x:Number, y:Number):void 
		{
			BulletPlayer(world.create(BulletPlayer)).reset(x, y);
		}
		
		public function checkIfShot():void 
		{
			var b:Bullet = collide("bullet_L", x, y) as Bullet;
			
			if (b)
			{
				takeDamage(b.damageG);
				b.destroy();
			}
		}
		
		override public function destroy():void 
		{
			Explosion(world.create(Explosion)).reset(this.x + this.halfWidth, this.y + this.halfHeight, -1, 0xffff00);
			super.destroy();
		}
		
	}

}