package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Sfx;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Key;
	import net.flashpunk.utils.Input;
	import net.flashpunk.FP;
	
	public class Ship extends Entity 
	{
		// Sprite
		[Embed(source = "../assets/playerShip1_red.png")]
		private const SHIP_IMG:Class;
		private var shipImage:Image; 
		// Movement
		private var speed:Number = 15;
		private var vx:Number = 0;
		private var vy:Number = 0;
		private var friction:Number = 0.95;
		// Shoot
		private var fireRate:Number = 0.2;
		private var fireWait:Number = 0;
		private var canShoot:Boolean = true;
		// Life / Health
		private var health:int = 5;
		// Sound
		[Embed(source="../assets/Sound/sfx_laser1.mp3")]
		private const SHIP_SHOOT_SFX:Class; 
		private var shoot:Sfx; 
		[Embed(source = "../assets/Sound/sfx_shieldDown.mp3")]
		private const SHIP_DAMAGE_SFX:Class; 
		private var damage:Sfx; 
		[Embed(source = "../assets/Sound/sfx_lose.mp3")]
		private const SHIP_DIE_SFX:Class;
		private var die:Sfx;
		
		public function Ship(x:Number = 0, y:Number = 0) 
		{
			this.shipImage = new Image(SHIP_IMG); 
			shoot = new Sfx(SHIP_SHOOT_SFX);
			damage = new Sfx(SHIP_DAMAGE_SFX); 
			die = new Sfx(SHIP_DIE_SFX);
			super(x, y);
		}
		
		public override function added(): void
		{
			graphic = shipImage;
			shipImage.scale = 0.5;
			width = shipImage.scaledWidth;
			height = shipImage.scaledHeight;
			shipImage.smooth = true;
			type = "Ship";
			name = "Ship";
		}
		
		override public function update():void 
		{
			FireTime();
			CheckKeys();
			Movement();
			CheckBoundry();
		}
		
		public function GetPosition():Number 
		{
			return x;
		}
		
		private function CheckKeys():void 
		{
			// Movement
			if (Input.check(Key.A)) 
				vx -= speed;
			else if (Input.check(Key.D))
				vx += speed;
			else
				vx *= friction;
			if (Input.check(Key.W))
				vy -= speed;
			else if (Input.check(Key.S))
				vy += speed;
			else
				vy *= friction;
			// Shoot
			if (Input.check(Key.G) && canShoot)
				Fire();
		}
		
		private function Movement():void 
		{
			x += vx * FP.elapsed;
			y += vy * FP.elapsed;
		}
		
		private function CheckBoundry():void 
		{
			// Check left
			if (x < width) 
			{
				x = width;
				vx = 0;
			}
			// Check right
			if (x > FP.screen.width - width * 2) 
			{
				x = FP.screen.width - width * 2;
				vx = 0;
			}
			// Check up
			if (y < height) 
			{
				y = height;
				vy = 0;
			}
			// Check down
			if (y > FP.screen.height - height * 2) 
			{
				y = FP.screen.height - height * 2;
				vy = 0;
			}
		}
		
		// Controla si ya paso el tiempo de espera para poder dispara otra bala
		private function FireTime():void 
		{
			fireWait += FP.elapsed;
			if (fireWait >= fireRate) canShoot = true;
		}
		
		private function Fire():void 
		{
			canShoot = false;
			fireWait = 0;
			this.world.add(new ShipBullet(centerX, top - 10));
			shoot.play();
		}
		
		// Si recibe daño disminuye su energia
		public function TakeDamage():void 
		{
			health--;
			if (health <= 0) Die();
			else damage.play();
		}
		
		// Si es destruido lo elimina
		private function Die():void 
		{
			die.play();
			world.remove(this);
		}
		
	}

}