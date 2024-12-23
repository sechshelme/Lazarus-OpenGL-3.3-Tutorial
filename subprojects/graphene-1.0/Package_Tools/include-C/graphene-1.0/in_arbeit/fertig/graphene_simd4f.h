/* graphene-simd4f.h: SIMD wrappers and operations
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
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SH1_0 THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */



/* Platform specific operations */

extern
graphene_simd4f_t       graphene_simd4f_init            (float                   x,
                                                         float                   y,
                                                         float                   z,
                                                         float                   w);
extern
graphene_simd4f_t       graphene_simd4f_init_zero       (void);
extern
graphene_simd4f_t       graphene_simd4f_init_4f         (const float            *v);
extern
graphene_simd4f_t       graphene_simd4f_init_3f         (const float            *v);
extern
graphene_simd4f_t       graphene_simd4f_init_2f         (const float            *v);

extern
void                    graphene_simd4f_dup_4f          (const graphene_simd4f_t s,
                                                         float                  *v);
extern
void                    graphene_simd4f_dup_3f          (const graphene_simd4f_t s,
                                                         float                  *v);
extern
void                    graphene_simd4f_dup_2f          (const graphene_simd4f_t s,
                                                         float                  *v);

extern
float                   graphene_simd4f_get             (const graphene_simd4f_t s,
                                                         unsigned int            i);
extern
float                   graphene_simd4f_get_x           (const graphene_simd4f_t s);
extern
float                   graphene_simd4f_get_y           (const graphene_simd4f_t s);
extern
float                   graphene_simd4f_get_z           (const graphene_simd4f_t s);
extern
float                   graphene_simd4f_get_w           (const graphene_simd4f_t s);

extern
graphene_simd4f_t       graphene_simd4f_splat           (float                   v);
extern
graphene_simd4f_t       graphene_simd4f_splat_x         (const graphene_simd4f_t s);
extern
graphene_simd4f_t       graphene_simd4f_splat_y         (const graphene_simd4f_t s);
extern
graphene_simd4f_t       graphene_simd4f_splat_z         (const graphene_simd4f_t s);
extern
graphene_simd4f_t       graphene_simd4f_splat_w         (const graphene_simd4f_t s);

extern
graphene_simd4f_t       graphene_simd4f_add             (const graphene_simd4f_t a,
                                                         const graphene_simd4f_t b);
extern
graphene_simd4f_t       graphene_simd4f_sub             (const graphene_simd4f_t a,
                                                         const graphene_simd4f_t b);
extern
graphene_simd4f_t       graphene_simd4f_mul             (const graphene_simd4f_t a,
                                                         const graphene_simd4f_t b);
extern
graphene_simd4f_t       graphene_simd4f_div             (const graphene_simd4f_t a,
                                                         const graphene_simd4f_t b);

extern
graphene_simd4f_t       graphene_simd4f_sqrt            (const graphene_simd4f_t s);
extern
graphene_simd4f_t       graphene_simd4f_reciprocal      (const graphene_simd4f_t s);
extern
graphene_simd4f_t       graphene_simd4f_rsqrt           (const graphene_simd4f_t s);

extern
graphene_simd4f_t       graphene_simd4f_cross3          (const graphene_simd4f_t a,
                                                         const graphene_simd4f_t b);
extern
graphene_simd4f_t       graphene_simd4f_dot3            (const graphene_simd4f_t a,
                                                         const graphene_simd4f_t b);
extern
float                   graphene_simd4f_dot3_scalar     (const graphene_simd4f_t a,
                                                         const graphene_simd4f_t b);

extern
graphene_simd4f_t       graphene_simd4f_min             (const graphene_simd4f_t a,
                                                         const graphene_simd4f_t b);
extern
graphene_simd4f_t       graphene_simd4f_max             (const graphene_simd4f_t a,
                                                         const graphene_simd4f_t b);

extern
graphene_simd4f_t       graphene_simd4f_shuffle_wxyz    (const graphene_simd4f_t s);
extern
graphene_simd4f_t       graphene_simd4f_shuffle_zwxy    (const graphene_simd4f_t s);
extern
graphene_simd4f_t       graphene_simd4f_shuffle_yzwx    (const graphene_simd4f_t s);

extern
graphene_simd4f_t       graphene_simd4f_zero_w          (const graphene_simd4f_t s);
extern
graphene_simd4f_t       graphene_simd4f_zero_zw         (const graphene_simd4f_t s);

extern
graphene_simd4f_t       graphene_simd4f_merge_high      (const graphene_simd4f_t a,
                                                         const graphene_simd4f_t b);
extern
graphene_simd4f_t       graphene_simd4f_merge_low       (const graphene_simd4f_t a,
                                                         const graphene_simd4f_t b);
extern
graphene_simd4f_t       graphene_simd4f_merge_w         (const graphene_simd4f_t s,
                                                         float                   v);

extern
graphene_simd4f_t       graphene_simd4f_flip_sign_0101  (const graphene_simd4f_t s);
extern
graphene_simd4f_t       graphene_simd4f_flip_sign_1010  (const graphene_simd4f_t s);

extern
bool                    graphene_simd4f_cmp_eq          (const graphene_simd4f_t a,
                                                         const graphene_simd4f_t b);
extern
bool                    graphene_simd4f_cmp_neq         (const graphene_simd4f_t a,
                                                         const graphene_simd4f_t b);
extern
bool                    graphene_simd4f_cmp_lt          (const graphene_simd4f_t a,
                                                         const graphene_simd4f_t b);
extern
bool                    graphene_simd4f_cmp_le          (const graphene_simd4f_t a,
                                                         const graphene_simd4f_t b);
extern
bool                    graphene_simd4f_cmp_ge          (const graphene_simd4f_t a,
                                                         const graphene_simd4f_t b);
extern
bool                    graphene_simd4f_cmp_gt          (const graphene_simd4f_t a,
                                                         const graphene_simd4f_t b);
extern
graphene_simd4f_t       graphene_simd4f_neg             (const graphene_simd4f_t s);

// xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
/*
static inline graphene_simd4f_t
graphene_simd4f_madd (const graphene_simd4f_t m1,
                      const graphene_simd4f_t m2,
                      const graphene_simd4f_t a)
{
  return graphene_simd4f_add (graphene_simd4f_mul (m1, m2), a);
}

static inline graphene_simd4f_t
graphene_simd4f_sum (const graphene_simd4f_t v)
{
  const graphene_simd4f_t x = graphene_simd4f_splat_x (v);
  const graphene_simd4f_t y = graphene_simd4f_splat_y (v);
  const graphene_simd4f_t z = graphene_simd4f_splat_z (v);
  const graphene_simd4f_t w = graphene_simd4f_splat_w (v);

  return graphene_simd4f_add (graphene_simd4f_add (x, y),
                              graphene_simd4f_add (z, w));
}

static inline float
graphene_simd4f_sum_scalar (const graphene_simd4f_t v)
{
  return graphene_simd4f_get_x (graphene_simd4f_sum (v));
}

static inline graphene_simd4f_t
graphene_simd4f_dot4 (const graphene_simd4f_t a,
                      const graphene_simd4f_t b)
{
  return graphene_simd4f_sum (graphene_simd4f_mul (a, b));
}

static inline graphene_simd4f_t
graphene_simd4f_dot2 (const graphene_simd4f_t a,
                      const graphene_simd4f_t b)
{
  const graphene_simd4f_t m = graphene_simd4f_mul (a, b);
  const graphene_simd4f_t x = graphene_simd4f_splat_x (m);
  const graphene_simd4f_t y = graphene_simd4f_splat_y (m);

  return graphene_simd4f_add (x, y);
}

static inline graphene_simd4f_t
graphene_simd4f_length4 (const graphene_simd4f_t v)
{
  return graphene_simd4f_sqrt (graphene_simd4f_dot4 (v, v));
}

static inline graphene_simd4f_t
graphene_simd4f_length3 (const graphene_simd4f_t v)
{
  return graphene_simd4f_sqrt (graphene_simd4f_dot3 (v, v));
}

static inline graphene_simd4f_t
graphene_simd4f_length2 (const graphene_simd4f_t v)
{
  return graphene_simd4f_sqrt (graphene_simd4f_dot2 (v, v));
}

static inline graphene_simd4f_t
graphene_simd4f_normalize4 (const graphene_simd4f_t v)
{
  graphene_simd4f_t invlen = graphene_simd4f_rsqrt (graphene_simd4f_dot4 (v, v));
  return graphene_simd4f_mul (v, invlen);
}

static inline graphene_simd4f_t
graphene_simd4f_normalize3 (const graphene_simd4f_t v)
{
  graphene_simd4f_t invlen = graphene_simd4f_rsqrt (graphene_simd4f_dot3 (v, v));
  return graphene_simd4f_mul (v, invlen);
}

static inline graphene_simd4f_t
graphene_simd4f_normalize2 (const graphene_simd4f_t v)
{
  graphene_simd4f_t invlen = graphene_simd4f_rsqrt (graphene_simd4f_dot2 (v, v));
  return graphene_simd4f_mul (v, invlen);
}

static inline bool
graphene_simd4f_is_zero4 (const graphene_simd4f_t v)
{
  graphene_simd4f_t zero = graphene_simd4f_init_zero ();
  return graphene_simd4f_cmp_eq (v, zero);
}

static inline bool
graphene_simd4f_is_zero3 (const graphene_simd4f_t v)
{
  return fabsf (graphene_simd4f_get_x (v)) <= FLT_EPSILON &&
         fabsf (graphene_simd4f_get_y (v)) <= FLT_EPSILON &&
         fabsf (graphene_simd4f_get_z (v)) <= FLT_EPSILON;
}

static inline bool
graphene_simd4f_is_zero2 (const graphene_simd4f_t v)
{
  return fabsf (graphene_simd4f_get_x (v)) <= FLT_EPSILON &&
         fabsf (graphene_simd4f_get_y (v)) <= FLT_EPSILON;
}

static inline graphene_simd4f_t
graphene_simd4f_interpolate (const graphene_simd4f_t a,
                             const graphene_simd4f_t b,
                             float                   f)
{
  const graphene_simd4f_t one_minus_f = graphene_simd4f_sub (graphene_simd4f_splat (1.f),
                                                             graphene_simd4f_splat (f));

  return graphene_simd4f_add (graphene_simd4f_mul (one_minus_f, a),
                              graphene_simd4f_mul (graphene_simd4f_splat (f), b));
}

static inline graphene_simd4f_t
graphene_simd4f_clamp (const graphene_simd4f_t v,
                       const graphene_simd4f_t min,
                       const graphene_simd4f_t max)
{
  const graphene_simd4f_t tmp = graphene_simd4f_max (min, v);

  return graphene_simd4f_min (tmp, max);
}

static inline graphene_simd4f_t
graphene_simd4f_clamp_scalar (const graphene_simd4f_t v,
                              float                   min,
                              float                   max)
{
  return graphene_simd4f_clamp (v,
                                graphene_simd4f_splat (min),
                                graphene_simd4f_splat (max));
}

static inline graphene_simd4f_t
graphene_simd4f_min_val (const graphene_simd4f_t v)
{
  graphene_simd4f_t s = v;

  s = graphene_simd4f_min (s, graphene_simd4f_shuffle_wxyz (s));
  s = graphene_simd4f_min (s, graphene_simd4f_shuffle_zwxy (s));

  return s;
}

static inline graphene_simd4f_t
graphene_simd4f_max_val (const graphene_simd4f_t v)
{
  graphene_simd4f_t s = v;

  s = graphene_simd4f_max (s, graphene_simd4f_shuffle_wxyz (s));
  s = graphene_simd4f_max (s, graphene_simd4f_shuffle_zwxy (s));

  return s;
}
*/

