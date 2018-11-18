﻿using Microsoft.Xna.Framework.Graphics;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Text;
using Microsoft.Xna.Framework;

namespace SimplexCore
{
    public class Sprite
    {
        public Texture2D Texture { get; set; }
        public int TextureRows { get; set; }
        public int TextureCellsPerRow { get; set; }
        public float ImageSpeed;
        public int Size;
        public float ImageIndex;
        public float ImageAngle;
        public float ImageAngleTarget;
        public float TransformSpeed;
        public Vector2 ImageScale;
        public Vector2 ImageScaleTarget;
        public Vector2 ImageSize;
        public Rectangle ImageRectangle;

        public Sprite()
        {
            ImageScale = Vector2.One;
            ImageScaleTarget = Vector2.One;
            ImageAngle = 0;
            ImageAngleTarget = 0;
            ImageIndex = 0;
            TransformSpeed = 0.2f;
        }

        public void UpdateImageAngle()
        {
            ImageAngle = SimplexMath.Lerp(ImageAngle, ImageAngleTarget, TransformSpeed);
        }

        public void UpdateImageScale()
        {
            ImageScale = new Vector2(SimplexMath.Lerp(ImageScale.X, ImageScaleTarget.X, TransformSpeed), SimplexMath.Lerp(ImageScale.Y, ImageScaleTarget.Y, TransformSpeed));
        }

        public void UpdateImageRectangle()
        {
            int y = ((int)ImageIndex / TextureCellsPerRow);
            int x = ((int)ImageIndex % TextureCellsPerRow);

            Debug.WriteLine("x:" + x + " y: " + y);

            ImageRectangle = new Rectangle(x * (int)ImageSize.X, y * (int)ImageSize.Y, (int)ImageSize.X, (int)ImageSize.Y);
        }
    }
}
