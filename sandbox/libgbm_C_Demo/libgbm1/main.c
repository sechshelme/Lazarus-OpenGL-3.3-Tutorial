
// gcc -o main main.c -lgbm


#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <gbm.h>

int main() {
    int drm_fd = open("/dev/dri/renderD128", O_RDWR); // Öffne das Standard-DRM-Device (kann je nach System abweichen)
    if (drm_fd < 0) {
        perror("open");
        return 1;
    }

    struct gbm_device *gbm = gbm_create_device(drm_fd);
    if (!gbm) {
        fprintf(stderr, "gbm_create_device failed\n");
        close(drm_fd);
        return 1;
    }

    struct gbm_bo *bo = gbm_bo_create(gbm, 640, 480, GBM_FORMAT_XRGB8888, GBM_BO_USE_RENDERING);
    if (!bo) {
        fprintf(stderr, "gbm_bo_create failed\n");
        gbm_device_destroy(gbm);
        close(drm_fd);
        return 1;
    }

    printf("GBM Buffer erfolgreich erstellt!\n");

    gbm_bo_destroy(bo);
    gbm_device_destroy(gbm);
    close(drm_fd);
    return 0;
}

