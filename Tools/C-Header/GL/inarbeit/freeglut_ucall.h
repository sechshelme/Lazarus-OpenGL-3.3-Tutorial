#ifndef  __FREEGLUT_UCALL_H__
#define  __FREEGLUT_UCALL_H__

/*
 * freeglut_ucall.h
 *
 * Callbacks with user data arguments.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
 * PAWEL W. OLSZTA BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#ifdef __cplusplus
    extern "C" {
#endif

/*
 * Menu stuff, see fg_menu.c
 */
 int   glutCreateMenuUcall( void (* callback)( int menu, void* user_data ), void* user_data );

/*
 * Global callback functions, see fg_callbacks.c
 */
 void  glutTimerFuncUcall( unsigned int time, void (* callback)( int, void* ), int value, void* user_data );
 void  glutIdleFuncUcall( void (* callback)( void* ), void* user_data );

/*
 * Window-specific callback functions, see fg_callbacks.c
 */
 void  glutKeyboardFuncUcall( void (* callback)( unsigned char, int, int, void* ), void* user_data );
 void  glutSpecialFuncUcall( void (* callback)( int, int, int, void* ), void* user_data );
 void  glutReshapeFuncUcall( void (* callback)( int, int, void* ), void* user_data );
 void  glutVisibilityFuncUcall( void (* callback)( int, void* ), void* user_data );
 void  glutDisplayFuncUcall( void (* callback)( void* ), void* user_data );
 void  glutMouseFuncUcall( void (* callback)( int, int, int, int, void* ), void* user_data );
 void  glutMotionFuncUcall( void (* callback)( int, int, void* ), void* user_data );
 void  glutPassiveMotionFuncUcall( void (* callback)( int, int, void* ), void* user_data );
 void  glutEntryFuncUcall( void (* callback)( int, void* ), void* user_data );

 void  glutKeyboardUpFuncUcall( void (* callback)( unsigned char, int, int, void* ), void* user_data );
 void  glutSpecialUpFuncUcall( void (* callback)( int, int, int, void* ), void* user_data );
 void  glutJoystickFuncUcall( void (* callback)( unsigned int, int, int, int, void* ), int pollInterval, void* user_data );
 void  glutMenuStatusFuncUcall( void (* callback)( int, int, int, void* ), void* user_data );
 void  glutOverlayDisplayFuncUcall( void (* callback)( void* ), void* user_data );
 void  glutWindowStatusFuncUcall( void (* callback)( int, void* ), void* user_data );

 void  glutSpaceballMotionFuncUcall( void (* callback)( int, int, int, void* ), void* user_data );
 void  glutSpaceballRotateFuncUcall( void (* callback)( int, int, int, void* ), void* user_data );
 void  glutSpaceballButtonFuncUcall( void (* callback)( int, int, void* ), void* user_data );
 void  glutButtonBoxFuncUcall( void (* callback)( int, int, void* ), void* user_data );
 void  glutDialsFuncUcall( void (* callback)( int, int, void* ), void* user_data );
 void  glutTabletMotionFuncUcall( void (* callback)( int, int, void* ), void* user_data );
 void  glutTabletButtonFuncUcall( void (* callback)( int, int, int, int, void* ), void* user_data );

 void  glutMouseWheelFuncUcall( void (* callback)( int, int, int, int, void* ), void* user_data );
 void  glutPositionFuncUcall( void (* callback)( int, int, void* ), void* user_data );
 void  glutCloseFuncUcall( void (* callback)( void* ), void* user_data );
 void  glutWMCloseFuncUcall( void (* callback)( void* ), void* user_data );
 void  glutMenuDestroyFuncUcall( void (* callback)( void* ), void* user_data );

/*
 * Multi-touch/multi-pointer extensions
 */
 void  glutMultiEntryFuncUcall( void (* callback)( int, int, void* ), void* user_data );
 void  glutMultiButtonFuncUcall( void (* callback)( int, int, int, int, int, void* ), void* user_data );
 void  glutMultiMotionFuncUcall( void (* callback)( int, int, int, void* ), void* user_data );
 void  glutMultiPassiveFuncUcall( void (* callback)( int, int, int, void* ), void* user_data );

/*
 * Initialization functions, see fg_init.c
 */
#include <stdarg.h>
 void  glutInitErrorFuncUcall( void (* callback)( const char *fmt, va_list ap, void* user_data ), void* user_data );
 void  glutInitWarningFuncUcall( void (* callback)( const char *fmt, va_list ap, void* user_data ), void* user_data );

/* Mobile platforms lifecycle */
 void  glutInitContextFuncUcall( void (* callback)( void* ), void* user_data );
 void  glutAppStatusFuncUcall( void (* callback)( int, void* ), void* user_data );

/*
 * Continued "hack" from GLUT applied to Ucall functions.
 * For more info, see bottom of freeglut_std.h
 */

/* to get the prototype for exit() */
#include <stdlib.h>

#if defined(_WIN32) && !defined(GLUT_DISABLE_ATEXIT_HACK) && !defined(__WATCOMC__)
 int  __glutCreateMenuUcallWithExit(void(*func)(int, void*), void( *exitfunc)(int), void* user_data);
#ifndef FREEGLUT_BUILDING_LIB
#if defined(__GNUC__)
#define FGUNUSED __attribute__((unused))
#else
#define FGUNUSED
#endif
/*
static int  FGUNUSED glutCreateMenuUcall_ATEXIT_HACK(void(*func)(int, void*), void* user_data) { return __glutCreateMenuUcallWithExit(func, exit, user_data); }
*/
#define glutCreateMenuUcall glutCreateMenuUcall_ATEXIT_HACK
#endif
#endif

#ifdef __cplusplus
    }
#endif

/*** END OF FILE ***/

#endif /* __FREEGLUT_UCALL_H__ */

