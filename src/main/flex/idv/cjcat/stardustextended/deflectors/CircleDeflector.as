﻿package idv.cjcat.stardustextended.deflectors
{
import flash.geom.Point;

import idv.cjcat.stardustextended.geom.MotionData4D;
import idv.cjcat.stardustextended.geom.MotionData4DPool;
import idv.cjcat.stardustextended.geom.Vec2D;
import idv.cjcat.stardustextended.geom.Vec2DPool;
import idv.cjcat.stardustextended.particles.Particle;

/**
 * Circular obstacle.
 *
 * <p>
 * When a particle hits the obstacle, it bounces back.
 * </p>
 */
public class CircleDeflector extends Deflector
{

    /**
     * The X coordinate of the center of the obstacle.
     */
    public var x : Number = 0;
    /**
     * The Y coordinate of the center of the obstacle.
     */
    public var y : Number = 0;
    /**
     * The radius of the obstacle.
     */
    public var radius : Number;

    public function CircleDeflector(x : Number = 0, y : Number = 0, radius : Number = 100)
    {
        this.x = x;
        this.y = y;
        this.radius = radius;
    }

    private var cr : Number;
    private var r : Vec2D;
    private var len : Number;
    private var v : Vec2D;
    private var factor : Number;

    override protected function calculateMotionData4D(particle : Particle) : MotionData4D
    {
        //normal displacement
        cr = particle.collisionRadius * particle.scale;
        r = Vec2DPool.get(particle.x - x, particle.y - y);

        //no collision detected
        len = r.length - cr;
        if (len > radius) {
            Vec2DPool.recycle(r);
            return null;
        }

        //collision detected
        r.length = radius + cr;
        v = Vec2DPool.get(particle.vx, particle.vy);
        v.projectThis(r);

        factor = 1 + bounce;

        Vec2DPool.recycle(r);
        Vec2DPool.recycle(v);
        return MotionData4DPool.get(x + r.x, y + r.y,
                (particle.vx - v.x * factor) * slipperiness, (particle.vy - v.y * factor) * slipperiness);
    }

    override public function setPosition(xc : Number, yc : Number) : void
    {
        x = xc;
        y = yc;
    }

    override public function getPosition() : Point
    {
        position.setTo(x, y);
        return position;
    }

}
}