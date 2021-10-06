package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';

	public var holdTimer:Float = 0;
	
	public var noteSkin:String = "";

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
	{
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;

		var tex:FlxAtlasFrames;
		antialiasing = true;

		switch (curCharacter)
		{
			case 'gf':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('Hal');
				frames = tex;
				animation.addByIndices('danceLeft', 'Hal Dancing beat0', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'Hal Dancing beat0', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				playAnim('danceRight');

			case 'dad':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('Neon_Apatite');
				frames = tex;
				animation.addByPrefix('idle', 'Neon Apatite Idle0', 24);
				animation.addByPrefix('singUP', 'Neon Apatite Up0', 24);
				animation.addByPrefix('singRIGHT', 'Neon Apatite Right0', 24);
				animation.addByPrefix('singDOWN', 'Neon Apatite Down0', 24);
				animation.addByPrefix('singLEFT', 'Neon Apatite Left0', 24);

				addOffset('idle', 0, 50);
				addOffset("singUP", 4, 58);
				addOffset("singRIGHT", -13, 37);
				addOffset("singLEFT", 5, 56);
				addOffset("singDOWN", 101, -150);


				playAnim('idle');

			case 'bf':
				var tex = Paths.getSparrowAtlas('BOYFRIEND');
				frames = tex;
				animation.addByPrefix('idle', 'Scottie Idle0', 24, false);
				animation.addByPrefix('singUP', 'Scottie Up0', 24, false);
				animation.addByPrefix('singLEFT', 'Scottie Left0', 24, false);
				animation.addByPrefix('singRIGHT', 'Scottie Right0', 24, false);
				animation.addByPrefix('singDOWN', 'Scottie Down0', 24, false);
				animation.addByPrefix('singUPmiss', 'Scottie Up miss0', 24, false);
				animation.addByPrefix('singLEFTmiss', 'Scottie Left miss0', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'Scottie Right miss0', 24, false);
				animation.addByPrefix('singDOWNmiss', 'Scottie Down miss0', 24, false);
				//animation.addByPrefix('hey', 'BF HEY', 24, false);
				//animation.addByPrefix('spinMic', 'BF MIC SPIN', 24, false);

				animation.addByPrefix('firstDeath', "Scottie dies0", 24, false);
				animation.addByPrefix('deathLoop', "Scottie Death loop0", 24, true);
				animation.addByPrefix('deathConfirm', "Scottie Death confirm", 24, false);

				//animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -11, -6);
				addOffset("singUP", -16, 20);
				addOffset("singRIGHT", -17, -4);
				addOffset("singLEFT", -15, -3);
				addOffset("singDOWN", -2, -43);
				addOffset("singUPmiss", -21, 21);
				addOffset("singRIGHTmiss", -26, -3);
				addOffset("singLEFTmiss", -18, -7);
				addOffset("singDOWNmiss", -4, -40);
				addOffset('firstDeath', 147, 1);
				addOffset('deathLoop', 187, 25);
				addOffset('deathConfirm', 259, 67);

				playAnim('idle');

				flipX = true;

		}

		dance();

		if (isPlayer)
		{
			flipX = !flipX;

			// Doesn't flip for BF, since his are already in the right place???
			if (!curCharacter.startsWith('bf'))
			{
				// var animArray
				var oldRight = animation.getByName('singRIGHT').frames;
				animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
				animation.getByName('singLEFT').frames = oldRight;



				// IF THEY HAVE MISS ANIMATIONS??
				if (animation.getByName('singRIGHTmiss') != null)
				{
					var oldMiss = animation.getByName('singRIGHTmiss').frames;
					animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
					animation.getByName('singLEFTmiss').frames = oldMiss;
				}
			}
		}
	}

	override function update(elapsed:Float)
	{
		if (!curCharacter.startsWith('bf'))
		{
			if (animation.curAnim.name.startsWith('sing'))
			{
				holdTimer += elapsed;
			}

			var dadVar:Float = 4;

			if (curCharacter == 'dad')
				dadVar = 6.1;
			if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001)
			{
				dance();
				holdTimer = 0;
			}
		}

		switch (curCharacter)
		{
			case 'gf':
				if (animation.curAnim.name == 'hairFall' && animation.curAnim.finished)
					playAnim('danceRight');
		}

		super.update(elapsed);
	}

	private var danced:Bool = false;

	/**
	 * FOR GF DANCING SHIT
	 */
	public function dance()
	{
		if (!debugMode)
		{
			switch (curCharacter)
			{
				case 'gf':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'gf-christmas':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'gf-car':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}
				case 'gf-pixel':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'spooky':
					danced = !danced;

					if (danced)
						playAnim('danceRight');
					else
						playAnim('danceLeft');
				default:
					playAnim('idle');
			}
		}
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		animation.play(AnimName, Force, Reversed, Frame);

		var daOffset = animOffsets.get(AnimName);
		if (animOffsets.exists(AnimName))
		{
			offset.set(daOffset[0], daOffset[1]);
		}
		else
			offset.set(0, 0);

		if (curCharacter == 'gf')
		{
			if (AnimName == 'singLEFT')
			{
				danced = true;
			}
			else if (AnimName == 'singRIGHT')
			{
				danced = false;
			}

			if (AnimName == 'singUP' || AnimName == 'singDOWN')
			{
				danced = !danced;
			}
		}
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}
