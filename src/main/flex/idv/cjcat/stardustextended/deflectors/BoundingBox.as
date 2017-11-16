﻿package idv.cjcat.stardustextended.deflectors
{
import flash.geom.Point;

import idv.cjcat.stardustextended.geom.MotionData4D;
import idv.cjcat.stardustextended.geom.MotionData4DPool;
import idv.cjcat.stardustextended.particles.Particle;

/**
 * Causes particles to be bounded within a rectangular region.
 *
 * <p>
 * When a particle hits the walls of the region, it bounces back.
 * </p>
 */
public class BoundingBox extends Deflector
{

    /**
     * The X coordinate of the top-left corner.
     */
    public var x : Number;
    /**
     * The Y coordinate of the top-left corner.
     */
    public var y : Number;
    /**
     * The width of the region.
     */
    public var width : Number;
    /**
     * The height of the region.
     */
    public var height : Number;

    public function BoundingBox(x : Number = 0, y : Number = 0, width : Number = 640, height : Number = 480)
    {
        this.bounce = 1;
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;
    }

    private var radius : Number;
    private var left : Number;
    private var right : Number;
    private var top : Number;
    private var bottom : Number;
    private var factor : Number;
    private var finalX : Number;
    private var finalY : Number;
    private var finalVX : Number;
    private var finalVY : Number;
    private var deflected : Boolean;

    override protected function calculateMotionData4D(particle : Particle) : MotionData4D
    {
        radius = particle.collisionRadius * particle.scale;
        left = x + radius;
        right = x + width - radius;
        top = y + radius;
        bottom = y + height - radius;

        factor = -bounce;

        finalX = particle.x;
        finalY = particle.y;
        finalVX = particle.vx;
        finalVY = particle.vy;

        deflected = false;
        if (particle.x <= left) {
            finalX = left;
            finalVX *= factor;
            deflected = true;
        } else if (particle.x >= right) {
            finalX = right;
            finalVX *= factor;
            deflected = true;
        }
        if (particle.y <= top) {
            finalY = top;
            finalVY *= factor;
            deflected = true;
        } else if (particle.y >= bottom) {
            finalY = bottom;
            finalVY *= factor;
            deflected = true;
        }

        if (deflected) return MotionData4DPool.get(finalX, finalY, finalVX, finalVY);
        else return null;
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