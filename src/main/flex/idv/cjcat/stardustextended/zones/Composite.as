﻿package idv.cjcat.stardustextended.zones
{

import idv.cjcat.stardustextended.geom.MotionData2D;

/**
 * This is a group of zones.
 *
 * <p>
 * The <code>calculateMotionData2D()</code> method returns random points in these zones.
 * These points are more likely to be situated in zones with bigger area.
 * </p>
 */
public class Composite extends Zone {

    protected var zoneCollection:ZoneCollection;

    public function get zones():Vector.<Zone> {
        return zoneCollection.zones;
    }

    public function set zones(value:Vector.<Zone>):void {
        zoneCollection.zones = value;
    }


    public function Composite() {
        zoneCollection = new ZoneCollection();
    }

    override public function calculateMotionData2D():MotionData2D {
        return zoneCollection.getRandomPointInZones();
    }

    override public function contains(x:Number, y:Number):Boolean {
        return zoneCollection.contains(x, y);
    }

    public final function addZone(zone:Zone):void {
        zoneCollection.zones.push(zone);
    }

    public final function removeZone(zone:Zone):void {
        var index:int;
        while ((index = zoneCollection.zones.indexOf(zone)) >= 0) {
            zoneCollection.zones.splice(index, 1);
        }
    }
}
}