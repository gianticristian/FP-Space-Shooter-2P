package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	
	public class Enemy extends Entity 
	{
		[Embed(source = "../assets/ufoGreen.png")]
		private const ENEMY_IMG:Class;
		private var enemyImage:Image; 
		private var health:int = 5;
		// Shoot
		private var fireRate:Number = 1;
		private var fireWait:Number = 0;
		private var canShoot:Boolean = true;
		// Referencia a la nave del jugador
		private var playerShip:Ship;
		private var playerShip2:Ship2;
		// Random X move
		private var destination:Number = 0;
		// Movement
		private var speed:Number = 0.5;
		private var vx:Number = 0;
		private var vy:Number = 0;
		// Sound
		[Embed(source="../assets/Sound/sfx_laser2.mp3")]
		private const ENEMY_SHOOT_SFX:Class; 
		private var shoot:Sfx; 
		[Embed(source = "../assets/Sound/sfx_twoTone.mp3")]
		private const ENEMY_DAMAGE_SFX:Class; 
		private var damage:Sfx; 
		[Embed(source = "../assets/Sound/sfx_shieldUp.mp3")]
		private const ENEMY_DIE_SFX:Class;
		private var die:Sfx;
		
		
		public function Enemy(x:Number = 0, y:Number = 0) 
		{
			enemyImage = new Image(ENEMY_IMG); 
			playerShip = new Ship();
			playerShip2 = new Ship2();
			shoot = new Sfx(ENEMY_SHOOT_SFX);
			damage = new Sfx(ENEMY_DAMAGE_SFX);
			die = new Sfx(ENEMY_DIE_SFX);
		}
		
		public override function added(): void
		{
			graphic = enemyImage;
			enemyImage.scale = 0.5;
			width = enemyImage.scaledWidth;
			height = enemyImage.scaledHeight;
			enemyImage.smooth = true;
			type = "Enemy";
			Spawn();
		}
		
		override public function update():void 
		{
			FireTime();
			Movement();
			CheckDestination();
			Hit();
			OutScreen();
			super.update();
		}
		
		private function Spawn():void 
		{
			// ----- Posicion X -----
			// Obtiene un numero entre 0 y el ancho de la ventana
			this.x = FP.rand(FP.screen.width - width);
			// Si esta muy a la izquierda, lo acomoda
			if (this.x <= 0) this.x = width * 2;
			// Si esta muy a la derecha, lo acomoda
			if (this.x >= FP.screen.width) this.x = FP.screen.width - width * 2;
			// ----- Posicion Y -----
			this.y = FP.rand(height * 10) * - 1;
			// ----- Velocidad -----
			vx = 0;
			vy = 0;
			// ----- Destino -----
			SetDestination();
		}
		
		public function TakeDamage():void 
		{
			this.collidable = false;
			health--;
			if (health <= 0) Die();
			else 
				damage.play();
			this.collidable = true;
		}
		
		private function Die():void 
		{
			die.play();
			world.remove(this);
		}
		
		private function Movement():void 
		{
			vy += speed;
			if (x < destination) vx += speed * 2;
			if (x > destination) vx -= speed;
			x += vx * FP.elapsed;
			y += vy * FP.elapsed;
		}
		
		private function FireTime():void 
		{
			fireWait += FP.elapsed;
			if (fireWait >= fireRate) 
			{
				canShoot = true;
				Fire();
			}
		}
		
		private function Fire():void 
		{
			playerShip = world.getInstance("Ship") as Ship;
			if (playerShip) 
			{
				var _distanceX:Number = x - playerShip.GetPosition();
				if (_distanceX > 0 && _distanceX < 50 && y > 0)
				{
					canShoot = false;
					fireWait = 0;
					this.world.add(new EnemyBullet(centerX, bottom + 10));
					shoot.play();
				}
			}
			playerShip2 = world.getInstance("Ship2") as Ship2;
			if (playerShip2) 
			{
				var _distanceX2:Number = x - playerShip2.GetPosition();
				if (_distanceX2 > 0 && _distanceX2 < 50 && y > 0)
				{
					canShoot = false;
					fireWait = 0;
					this.world.add(new EnemyBullet(centerX, bottom + 10));
					shoot.play();
				}
			}
		}
		
		private function Hit():void 
		{
			var ship:Ship = this.collide("Ship", x, y) as Ship;	
			if (ship) 
			{
				ship.TakeDamage();
				this.Die();
			}
			var ship2:Ship2 = this.collide("Ship2", x, y) as Ship2;	
			if (ship2) 
			{
				ship2.TakeDamage();
				this.Die();
			}
			
		}
		
		private function OutScreen():void 
		{
			if (y > FP.screen.height + height) Spawn();
		}
		
		private function SetDestination():void 
		{
			vx = 0;
			destination = FP.rand(FP.screen.width / 2) + FP.screen.width / 5;
		}
		
		private function CheckDestination():void 
		{
			if (x == destination) SetDestination();
		}
		
	}

}