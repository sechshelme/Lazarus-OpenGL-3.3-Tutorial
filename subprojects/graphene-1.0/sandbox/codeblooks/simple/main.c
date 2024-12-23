


// gcc main.c -o main `pkg-config --cflags --libs graphene-1.0`

// https://www.perplexity.ai/search/gib-mir-ein-c-beispiel-mit-gra-OWAbA5DTT_u45fYw0R.ViA

#include <graphene.h>
#include <stdio.h>

int main() {
    // Initialisiere Graphene
    graphene_simd4f_t v1, v2, result;

    // Erstelle zwei 4D-Vektoren
    v1 = graphene_simd4f_init(1.0f, 2.0f, 3.0f, 4.0f);
    v2 = graphene_simd4f_init(5.0f, 6.0f, 7.0f, 8.0f);

    // Addiere die Vektoren
    result = graphene_simd4f_add(v1, v2);

    // Gib das Ergebnis aus
    float x, y, z, w;
//    graphene_simd4f_get(result, &x, &y, &z, &w);

result.x=123;

x = graphene_simd4f_get_x(result);
y = graphene_simd4f_get_y(result);
z = graphene_simd4f_get_z(result);
w = graphene_simd4f_get_w(result);


    printf("Ergebnis: (%.2f, %.2f, %.2f, %.2f)\n", x, y, z, w);
    printf("Ergebnis: %d\n", sizeof(graphene_simd4f_t));
    printf("Ergebnis: %d\n", sizeof(graphene_simd4x4f_t));
    printf("Ergebnis: %d\n", sizeof(x));

    return 0;

}
