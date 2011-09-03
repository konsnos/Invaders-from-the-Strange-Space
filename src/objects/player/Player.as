package objects.player 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import objects.Actor;
	
	import worlds.Lost_Obj;
	import worlds.Level;
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
			BulletPlayer.PlayerShotsS = 0;
			
			layer = 1;
			
		}
		
		override public function update():void 
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
			if (BulletPlayer.PlayerShotsG < BulletsMax )
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
			super.destroy();
			
			gameStateS(GlobalVariables.LOST);
			
			FP.world.add(new Lost_Obj);
		}
		
	}

}