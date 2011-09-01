package player 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	import worlds.Lost_Obj;
	import objects.bullets.BulletPlayer;
	import objects.bullets.Bullet;
	import objects.GlobalVariables;
	import enemies.Little;
	
	/**
	 * ...
	 * @author konsnos
	 */
	public class Player extends Entity 
	{
		private var image:Image;
		
		private var hp:Number;
		private var speed:Number;
		
		private var BulletsMax:Number;
		private var BulletsShot:Number;
		
		private var little:Little;
		
		// Gets-Sets
		public function get hpG():Number
		{
			return hp;
		}
		public function set hpS(setValue:Number):void 
		{
			hp += setValue;
			if (hp <= 0)
			{
				destroy();
			}
		}
		
		public function Player(x:Number, y:Number) 
		{
			graphic = image = new Image(GlobalVariables.IMG_PLAYER);
			image.scale = 0.8;
			
			hp = 3;
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
			
			if (little) // Γιατί το έκανα αυτό;
			{
				hp -= little.hpG;
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
		
		public function takeDamage(damageTaken:Number):void 
		{
			hpS = -damageTaken;
		}
		
		public function destroy():void 
		{
			FP.world.recycle(this);
			FP.world.add(new Lost_Obj);
		}
		
	}

}