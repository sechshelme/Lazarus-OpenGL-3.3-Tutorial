/* graphene-quad.h: Quad
 *
 * SPDX-License-Identifier: MIT
 *
 * Copyright 2014  Emmanuele Bassi
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#pragma once

#include "graphene-types.h"
#include "graphene-point.h"



/**
 * graphene_quad_t:
 *
 * A 4 vertex quadrilateral, as represented by four #graphene_point_t.
 *
 * The contents of a #graphene_quad_t are private and should never be
 * accessed directly.
 *
 * Since: 1.0
 */
struct _graphene_quad_t
{
  /*< private >*/
  graphene_point_t points;
};

extern
graphene_quad_t *       graphene_quad_alloc             (void);
extern
void                    graphene_quad_free              (graphene_quad_t        *q);

extern
graphene_quad_t *       graphene_quad_init              (graphene_quad_t        *q,
                                                         const graphene_point_t *p1,
                                                         const graphene_point_t *p2,
                                                         const graphene_point_t *p3,
                                                         const graphene_point_t *p4);
extern
graphene_quad_t *       graphene_quad_init_from_rect    (graphene_quad_t        *q,
                                                         const graphene_rect_t  *r);
extern
graphene_quad_t *       graphene_quad_init_from_points  (graphene_quad_t        *q,
                                                         const graphene_point_t  points[]);

extern
bool                    graphene_quad_contains          (const graphene_quad_t  *q,
                                                         const graphene_point_t *p);

extern
void                    graphene_quad_bounds            (const graphene_quad_t  *q,
                                                         graphene_rect_t        *r);

extern
const graphene_point_t *graphene_quad_get_point         (const graphene_quad_t  *q,
                                                         unsigned int            index_);


