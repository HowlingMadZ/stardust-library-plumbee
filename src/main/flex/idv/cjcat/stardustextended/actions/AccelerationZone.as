﻿package idv.cjcat.stardustextended.actions
{

import idv.cjcat.stardustextended.emitters.Emitter;
import idv.cjcat.stardustextended.geom.Vec2D;
import idv.cjcat.stardustextended.geom.Vec2DPool;
import idv.cjcat.stardustextended.particles.Particle;
import idv.cjcat.stardustextended.zones.RectZone;
import idv.cjcat.stardustextended.zones.Zone;
import idv.cjcat.stardustextended.zones.ZoneCollection;

/**
 * Causes particles to change acceleration specified zone.
 *
 * <p>
 * Default priority = -6;
 * </p>
 */
public class AccelerationZone extends Action implements IZoneContainer
{

    /**
     * Inverts the zone region.
     */
    public var inverted : Boolean;

    /**
     * The acceleration applied in each step to particles inside the zone.
     */
    public var acceleration : Number;
    /**
     * Flag whether to use the particle's speed or the direction variable. Default is true.
     */
    public var useParticleDirection : Boolean;

    private var _direction : Vec2D;
    /**
     * the direction of the acceleration. Only used if useParticleDirection is true
     */
    public function get direction() : Vec2D
    {
        return _direction;
    }

    public function set direction(value : Vec2D) : void
    {
        value.length = 1;
        _direction = value;
    }

    protected var zoneCollection : ZoneCollection;

    public function get zones() : Vector.<Zone>
    {
        return zoneCollection.zones;
    }

    public function set zones(value : Vector.<Zone>) : void
    {
        zoneCollection.zones = value;
    }

    public function AccelerationZone(zones : Vector.<Zone> = null, _inverted : Boolean = false)
    {
        priority = -6;

        inverted = _inverted;
        acceleration = 200;
        useParticleDirection = true;
        _direction = Vec2DPool.get(100, 0);
        zoneCollection = new ZoneCollection();
        if (zones) {
            zoneCollection.zones = zones;
        }
        else {
            zoneCollection.zones.push(new RectZone());
        }
    }

    override public function update(emitter : Emitter, particle : Particle, timeDelta : Number, currentTime : Number) : void
    {
        var affected : Boolean = zoneCollection.contains(particle.x, particle.y);
        if (inverted) {
            affected = !affected;
        }
        if (affected) {
            if (useParticleDirection) {
                var v : Vec2D = Vec2DPool.get(particle.vx, particle.vy);
                const vecLength : Number = v.length;
                if (vecLength > 0) {
                    var finalVal : Number = vecLength + acceleration * timeDelta;
                    if (finalVal < 0) {
                        finalVal = 0;
                    }
                    v.length = finalVal;
                    particle.vx = v.x;
                    particle.vy = v.y;
                }
                Vec2DPool.recycle(v);
            }
            else {
                var finalX : Number = particle.vx + acceleration * _direction.x * timeDelta;
                var finalY : Number = particle.vy + acceleration * _direction.y * timeDelta;
                particle.vx = finalX;
                particle.vy = finalY;
            }
        }
    }

}
}