﻿package idv.cjcat.stardustextended.actions
{

import idv.cjcat.stardustextended.emitters.Emitter;
import idv.cjcat.stardustextended.geom.Vec2D;
import idv.cjcat.stardustextended.geom.Vec2DPool;
import idv.cjcat.stardustextended.particles.Particle;

/**
 * Accelerates particles along their velocity directions.
 */
public class Accelerate extends Action
{

    /**
     * The amount of acceleration in each second.
     */
    public var acceleration : Number;
    protected var _timeDeltaOneSec : Number;

    public function Accelerate(acceleration : Number = 60)
    {
        this.acceleration = acceleration;
    }

    override public function preUpdate(emitter : Emitter, time : Number) : void
    {
        _timeDeltaOneSec = time * 60;
    }

    override public function update(emitter : Emitter, particle : Particle, timeDelta : Number, currentTime : Number) : void
    {
        var v : Vec2D = Vec2DPool.get(particle.vx, particle.vy);
        const vecLength : Number = v.length;
        if (vecLength > 0) {
            var finalVal : Number = vecLength + acceleration * _timeDeltaOneSec;
            if (finalVal < 0) {
                finalVal = 0;
            }
            v.length = finalVal;
            particle.vx = v.x;
            particle.vy = v.y;
        }
        Vec2DPool.recycle(v);
    }

}
}