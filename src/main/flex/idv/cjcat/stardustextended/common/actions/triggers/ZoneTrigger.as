﻿package idv.cjcat.stardustextended.common.actions.triggers
{

	import idv.cjcat.stardustextended.common.particles.Particle;
	import idv.cjcat.stardustextended.common.emitters.Emitter;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.twoD.actions.IZoneContainer;
	import idv.cjcat.stardustextended.twoD.zones.SinglePoint;
	import idv.cjcat.stardustextended.twoD.zones.Zone;
	
	/**
	 * This trigger is triggered when a particle is contained in a zone.
	 */
	public class ZoneTrigger extends Trigger implements IZoneContainer
    {
		
		private var _zone:Zone;
		public function ZoneTrigger(zone:Zone = null) {
			this.zone = zone;
		}
		
		public function get zone():Zone { return _zone; }
		public function set zone(value:Zone):void {
			if (!value) value = new SinglePoint(0, 0);
			_zone = value;
		}
		
		override public function testTrigger(emitter:Emitter, particle:Particle, time:Number):Boolean {
			return _zone.contains(particle.x, particle.y);
		}
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getRelatedObjects():Array {
			return [_zone];
		}
		
		override public function getXMLTagName():String {
			return "ZoneTrigger";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			xml.@zone = _zone.name;
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			zone = builder.getElementByName(xml.@zone) as Zone;
		}
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}