package net.spider.modules{
	
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.system.*;
	import flash.ui.*;
	import flash.utils.*;
    import net.spider.main;
	import net.spider.handlers.ClientEvent;
	
	public class diswepanim extends MovieClip{

		public static var events:EventDispatcher = new EventDispatcher();
        private static var animTimer:Timer;

		public static function onCreate():void{
			diswepanim.events.addEventListener(ClientEvent.onToggle, onToggle);
		}

		public static function onToggle(e:Event):void{
			if(options.disWepAnim){
				animTimer = new Timer(0);
				animTimer.addEventListener(TimerEvent.TIMER, onTimer);
				animTimer.start();
			}else{
				animTimer.reset();
				animTimer.removeEventListener(TimerEvent.TIMER, onTimer);
				for(var playerMC:* in main.Game.world.avatars){
					if(!main.Game.world.avatars[playerMC].objData)
						continue;
					if(main.Game.world.avatars[playerMC].pMC){
						main.Game.world.avatars[playerMC].pMC.mcChar.weapon.mcWeapon.gotoAndPlay(0);
						(main.Game.world.avatars[playerMC].pMC.mcChar.weaponOff.getChildAt(0) as MovieClip).gotoAndPlay(0);
						movieClipPlayAll(main.Game.world.avatars[playerMC].pMC.mcChar.weapon.mcWeapon);
						movieClipPlayAll((main.Game.world.avatars[playerMC].pMC.mcChar.weaponOff.getChildAt(0) as MovieClip));
					}
				}
			}
		}

        public static function onTimer(e:TimerEvent):void{
			if(!main.Game.sfc.isConnected || !main.Game.world.myAvatar)
				return;
			for(var playerMC:* in main.Game.world.avatars){
				if(!main.Game.world.avatars[playerMC].objData)
					continue;
				if(options.filterChecks["chkDisWepAnim"])
					if(main.Game.world.avatars[playerMC].isMyAvatar)
						continue;
				if(main.Game.world.avatars[playerMC].pMC.mcChar.weapon.mcWeapon){
					main.Game.world.avatars[playerMC].pMC.mcChar.weapon.mcWeapon.gotoAndStop(0);
					(main.Game.world.avatars[playerMC].pMC.mcChar.weaponOff.getChildAt(0) as MovieClip).gotoAndStop(0);
					movieClipStopAll(main.Game.world.avatars[playerMC].pMC.mcChar.weapon.mcWeapon);
					movieClipStopAll((main.Game.world.avatars[playerMC].pMC.mcChar.weaponOff.getChildAt(0) as MovieClip));
				}
			}
		}

		public static function movieClipStopAll(container:MovieClip):void {
            for (var i:uint = 0; i < container.numChildren; i++)
                if (container.getChildAt(i) is MovieClip) {
                    (container.getChildAt(i) as MovieClip).gotoAndStop(0);
                    movieClipStopAll(container.getChildAt(i) as MovieClip);
                }
        }

		public static function movieClipPlayAll(container:MovieClip):void {
            for (var i:uint = 0; i < container.numChildren; i++)
                if (container.getChildAt(i) is MovieClip) {
                    (container.getChildAt(i) as MovieClip).gotoAndPlay(0);
                    movieClipPlayAll(container.getChildAt(i) as MovieClip);
                }
        }
	}
	
}
