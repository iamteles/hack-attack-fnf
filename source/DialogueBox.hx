package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitLeftsmug:FlxSprite;
	var portraitLefthuh:FlxSprite;
	var portraitLeftm:FlxSprite;
	var portraitLeftlmao:FlxSprite;
	var portraitLeftnotbad:FlxSprite;

	var portraitRight:FlxSprite;
	var portraitRightno:FlxSprite;
	var portraitRightsad:FlxSprite;
	var portraitRightplease:FlxSprite;
	var portraitRightyay:FlxSprite;
	var portraitRighthal:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
				
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
		}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 45);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);

			case 'cheerio':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble normal open0', 24, false);
				box.animation.addByIndices('normal', 'Speech Bubble normal0', [4], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -100;
				box.y = 375;

			case 'blazing':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble normal open0', 24, false);
				box.animation.addByIndices('normal', 'Speech Bubble normal0', [4], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -100;
				box.y = 375;
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;

		//enemy portraits
		portraitLeft = new FlxSprite(0, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
		portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;

		portraitLeftsmug = new FlxSprite(100, 100);
		portraitLeftsmug.frames = Paths.getSparrowAtlas('portrait/Neon_Apatite_Portrait');
		portraitLeftsmug.animation.addByPrefix('enter', 'Neon_Apatite_Portrait Smug0', 24, false);
		//portraitLeftsmug.setGraphicSize(Std.int(portraitLeftsmug.width * PlayState.daPixelZoom * 0.9));
		portraitLeftsmug.updateHitbox();
		portraitLeftsmug.scrollFactor.set();
		add(portraitLeftsmug);
		portraitLeftsmug.visible = false;

		portraitLefthuh = new FlxSprite(100, 100);
		portraitLefthuh.frames = Paths.getSparrowAtlas('portrait/Neon_Apatite_Portrait');
		portraitLefthuh.animation.addByPrefix('enter', 'Neon_Apatite_Portrait Huh0', 24, false);
		//portraitLefthuh.setGraphicSize(Std.int(portraitLefthuh.width * PlayState.daPixelZoom * 0.9));
		portraitLefthuh.updateHitbox();
		portraitLefthuh.scrollFactor.set();
		add(portraitLefthuh);
		portraitLefthuh.visible = false;

		portraitLeftm = new FlxSprite(100, 100);
		portraitLeftm.frames = Paths.getSparrowAtlas('portrait/Neon_Apatite_Portrait');
		portraitLeftm.animation.addByPrefix('enter', 'Neon_Apatite_Portrait M0', 24, false);
		//portraitLeftm.setGraphicSize(Std.int(portraitLeftm.width * PlayState.daPixelZoom * 0.9));
		portraitLeftm.updateHitbox();
		portraitLeftm.scrollFactor.set();
		add(portraitLeftm);
		portraitLeftm.visible = false;

		portraitLeftlmao = new FlxSprite(100, 100);
		portraitLeftlmao.frames = Paths.getSparrowAtlas('portrait/Neon_Apatite_Portrait');
		portraitLeftlmao.animation.addByPrefix('enter', 'Neon_Apatite_Portrait Lmao0', 24, false);
		//portraitLeftlmao.setGraphicSize(Std.int(portraitLeftlmao.width * PlayState.daPixelZoom * 0.9));
		portraitLeftlmao.updateHitbox();
		portraitLeftlmao.scrollFactor.set();
		add(portraitLeftlmao);
		portraitLeftlmao.visible = false;

		portraitLeftnotbad = new FlxSprite(100, 100);
		portraitLeftnotbad.frames = Paths.getSparrowAtlas('portrait/Neon_Apatite_Portrait');
		portraitLeftnotbad.animation.addByPrefix('enter', 'Neon_Apatite_Portrait NotBad0', 24, false);
		//portraitLeftnotbad.setGraphicSize(Std.int(portraitLeftnotbad.width * PlayState.daPixelZoom * 0.9));
		portraitLeftnotbad.updateHitbox();
		portraitLeftnotbad.scrollFactor.set();
		add(portraitLeftnotbad);
		portraitLeftnotbad.visible = false;

		//enemy portraits end :D

		//scottie portraits
		portraitRight = new FlxSprite(0, 0);
		portraitRight.frames = Paths.getSparrowAtlas('portrait/Scottie_Portrait');
		portraitRight.animation.addByPrefix('enter', 'Scottie_Portrait', 24, false);
		//portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;

		portraitRightno = new FlxSprite(650, 0);
		portraitRightno.frames = Paths.getSparrowAtlas('portrait/Scottie_Portrait');
		portraitRightno.animation.addByPrefix('enter', 'Scottie_Portrait No0', 24, false);
		//portraitRightno.setGraphicSize(Std.int(portraitRightno.width * PlayState.daPixelZoom * 0.9));
		portraitRightno.updateHitbox();
		portraitRightno.scrollFactor.set();
		add(portraitRightno);
		portraitRightno.visible = false;

		portraitRightsad = new FlxSprite(650, 0);
		portraitRightsad.frames = Paths.getSparrowAtlas('portrait/Scottie_Portrait');
		portraitRightsad.animation.addByPrefix('enter', 'Scottie_Portrait Sad0', 24, false);
		//portraitRightsad.setGraphicSize(Std.int(portraitRightsad.width * PlayState.daPixelZoom * 0.9));
		portraitRightsad.updateHitbox();
		portraitRightsad.scrollFactor.set();
		add(portraitRightsad);
		portraitRightsad.visible = false;

		portraitRightplease = new FlxSprite(650, 0);
		portraitRightplease.frames = Paths.getSparrowAtlas('portrait/Scottie_Portrait');
		portraitRightplease.animation.addByPrefix('enter', 'Scottie_Portrait Please0', 24, false);
		//portraitRightplease.setGraphicSize(Std.int(portraitRightplease.width * PlayState.daPixelZoom * 0.9));
		portraitRightplease.updateHitbox();
		portraitRightplease.scrollFactor.set();
		add(portraitRightplease);
		portraitRightplease.visible = false;

		portraitRightyay = new FlxSprite(650, 0);
		portraitRightyay.frames = Paths.getSparrowAtlas('portrait/Scottie_Portrait');
		portraitRightyay.animation.addByPrefix('enter', 'Scottie_Portrait Yay0', 24, false);
		//portraitRightyay.setGraphicSize(Std.int(portraitRightyay.width * PlayState.daPixelZoom * 0.9));
		portraitRightyay.updateHitbox();
		portraitRightyay.scrollFactor.set();
		add(portraitRightyay);
		portraitRightyay.visible = false;

		portraitRighthal = new FlxSprite(650, 0);
		portraitRighthal.frames = Paths.getSparrowAtlas('portrait/Scottie_Portrait');
		portraitRighthal.animation.addByPrefix('enter', 'Scottie_Portrait Hal0', 24, false);
		//portraitRighthal.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
		portraitRighthal.updateHitbox();
		portraitRighthal.scrollFactor.set();
		add(portraitRighthal);
		portraitRighthal.visible = false;
		
		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		box.updateHitbox();
		add(box);

		box.screenCenter(X);
		portraitLeft.screenCenter(X);

		handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox'));
		add(handSelect);


		if (!talkingRight)
		{
			// box.flipX = true;
		}

		dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = Paths.font("FridayFunkin-Regular.otf");
		dropText.color = 0xFFD89494;
		//add(dropText);

		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 48);
		swagDialogue.font = Paths.font("FridayFunkin-Regular.otf");
		swagDialogue.color = 0xFF000000;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (FlxG.keys.justPressed.ANY  && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns')
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{
			case 'dad':
				portraitRightno.visible = false;
				portraitRightsad.visible = false;
				portraitRightplease.visible = false;
				portraitRightyay.visible = false;
				portraitRighthal.visible = false;
				portraitLeftsmug.visible = false;
				portraitLefthuh.visible = false;
				portraitLeftm.visible = false;
				portraitLeftlmao.visible = false;
				portraitLeftnotbad.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'bf':
				portraitRightno.visible = false;
				portraitRightsad.visible = false;
				portraitRightplease.visible = false;
				portraitRightyay.visible = false;
				portraitRighthal.visible = false;
				portraitLeftsmug.visible = false;
				portraitLefthuh.visible = false;
				portraitLeftm.visible = false;
				portraitLeftlmao.visible = false;
				portraitLeftnotbad.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}
			case 'sno':
				portraitRightsad.visible = false;
				portraitRightplease.visible = false;
				portraitRightyay.visible = false;
				portraitRighthal.visible = false;
				portraitLeftsmug.visible = false;
				portraitLefthuh.visible = false;
				portraitLeftm.visible = false;
				portraitLeftlmao.visible = false;
				portraitLeftnotbad.visible = false;
				if (!portraitRightno.visible)
				{
					portraitRightno.visible = true;
					portraitRightno.animation.play('enter');
				}
			case 'ssad':
				portraitRightno.visible = false;
				portraitRightplease.visible = false;
				portraitRightyay.visible = false;
				portraitRighthal.visible = false;
				portraitLeftsmug.visible = false;
				portraitLefthuh.visible = false;
				portraitLeftm.visible = false;
				portraitLeftlmao.visible = false;
				portraitLeftnotbad.visible = false;
				if (!portraitRightsad.visible)
				{
					portraitRightsad.visible = true;
					portraitRightsad.animation.play('enter');
				}
			case 'splease':
				portraitRightno.visible = false;
				portraitRightsad.visible = false;
				portraitRightyay.visible = false;
				portraitRighthal.visible = false;
				portraitLeftsmug.visible = false;
				portraitLefthuh.visible = false;
				portraitLeftm.visible = false;
				portraitLeftlmao.visible = false;
				portraitLeftnotbad.visible = false;
				if (!portraitRightplease.visible)
				{
					portraitRightplease.visible = true;
					portraitRightplease.animation.play('enter');
				}
			case 'syay':
				portraitRightno.visible = false;
				portraitRightsad.visible = false;
				portraitRightplease.visible = false;
				portraitRighthal.visible = false;
				portraitLeftsmug.visible = false;
				portraitLefthuh.visible = false;
				portraitLeftm.visible = false;
				portraitLeftlmao.visible = false;
				portraitLeftnotbad.visible = false;
				if (!portraitRightyay.visible)
				{
					portraitRightyay.visible = true;
					portraitRightyay.animation.play('enter');
				}

			case 'shal':
				portraitRightno.visible = false;
				portraitRightsad.visible = false;
				portraitRightplease.visible = false;
				portraitRightyay.visible = false;
				portraitLeftsmug.visible = false;
				portraitLefthuh.visible = false;
				portraitLeftm.visible = false;
				portraitLeftlmao.visible = false;
				portraitLeftnotbad.visible = false;
				if (!portraitRighthal.visible)
				{
					portraitRighthal.visible = true;
					portraitRighthal.animation.play('enter');
				}
			case 'nsmug':
				portraitRightno.visible = false;
				portraitRightsad.visible = false;
				portraitRightplease.visible = false;
				portraitRightyay.visible = false;
				portraitRighthal.visible = false;
				portraitLefthuh.visible = false;
				portraitLeftm.visible = false;
				portraitLeftlmao.visible = false;
				portraitLeftnotbad.visible = false;
				if (!portraitLeftsmug.visible)
				{
					portraitLeftsmug.visible = true;
					portraitLeftsmug.animation.play('enter');
				}
			case 'nhuh':
				portraitRightno.visible = false;
				portraitRightsad.visible = false;
				portraitRightplease.visible = false;
				portraitRightyay.visible = false;
				portraitRighthal.visible = false;
				portraitLeftsmug.visible = false;
				portraitLeftm.visible = false;
				portraitLeftlmao.visible = false;
				portraitLeftnotbad.visible = false;
				if (!portraitLefthuh.visible)
				{
					portraitLefthuh.visible = true;
					portraitLefthuh.animation.play('enter');
				}
			case 'nm':
				portraitRightno.visible = false;
				portraitRightsad.visible = false;
				portraitRightplease.visible = false;
				portraitRightyay.visible = false;
				portraitRighthal.visible = false;
				portraitLeftsmug.visible = false;
				portraitLefthuh.visible = false;
				portraitLeftlmao.visible = false;
				portraitLeftnotbad.visible = false;
				if (!portraitLeftm.visible)
				{
					portraitLeftm.visible = true;
					portraitLeftm.animation.play('enter');
				}
			case 'nlmao':
				portraitRightno.visible = false;
				portraitRightsad.visible = false;
				portraitRightplease.visible = false;
				portraitRightyay.visible = false;
				portraitRighthal.visible = false;
				portraitLeftsmug.visible = false;
				portraitLefthuh.visible = false;
				portraitLeftm.visible = false;
				portraitLeftnotbad.visible = false;
				if (!portraitLeftlmao.visible)
				{
					portraitLeftlmao.visible = true;
					portraitLeftlmao.animation.play('enter');
				}
			case 'nnotbad':
				portraitRightno.visible = false;
				portraitRightsad.visible = false;
				portraitRightplease.visible = false;
				portraitRightyay.visible = false;
				portraitRighthal.visible = false;
				portraitLeftsmug.visible = false;
				portraitLefthuh.visible = false;
				portraitLeftm.visible = false;
				portraitLeftlmao.visible = false;
				if (!portraitLeftnotbad.visible)
				{
					portraitLeftnotbad.visible = true;
					portraitLeftnotbad.animation.play('enter');
				}
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}
