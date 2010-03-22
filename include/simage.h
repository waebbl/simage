#ifndef SIMAGE_H
#define SIMAGE_H

/*
 * Copyright (c) Kongsberg Oil & Gas Technologies
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */

/*
 * simage:
 *
 * A simple library for loading images. This library is designed
 * for loading textures to be used as OpenGL textures.
 * Only pixel formats directly supported by OpenGL (v1.0) will be
 * returned. The user is responsible for resizing the texture to
 * a 2^n width/height though.
 *
 * This library does not support the "new" OpenGL v1.1 image
 * formats. In the future this might be supported though. We still
 * have some old SGI HW with only OpenGL v1.0 installed...
 *
 * Usage information:
 *
 * simage_check_supported(filename):
 *
 *   Will return 1 if filename can be loaded, 0 otherwise.
 *
 * simage_read_image(filename, width, height, numComponents)
 *
 *   Will (attempt to) read filename, and return a pointer to
 *   the image data. NULL is returned if the image could not
 *   be loaded. The memory is allocated using malloc(), and
 *   it is the callers responsibility to free the memory (using free())
 *   width and height contains the width and height of the image,
 *   and numComponents is a number indicating the following:
 *     1 : Grayscale image (GL_LUMINANCE)
 *     2 : Grayscale with alpha channel (GL_LUMINANCE_ALPHA)
 *     3 : RGB data (GL_RGB)
 *     4 : RGB data with alpha component (GL_RGBA)
 *
 * int simage_check_save_supported(const char * filenameextension)
 *
 *   Returns 1 if a saver of type filenameextension is added. The
 *   built-in savers are gif, jpg/jpeg, png, tif/tiff and rgb.
 *
 * int simage_save_image(const char * filename,
 *                       const unsigned char * bytes,
 *                       int w, int h, int numcomponents,
 *                       const char * filenameextension)
 *
 *   Saves image in the format specified in filenameextension.
 *
 * A couple of functions for your convenience:
 *
 * simage_resize(imagedata, width, height, numComponents,
 *               newwidth, newheight)
 *
 *   A convenience function that can be used to resize an image.
 *   Since OpenGL textures must have width and height equal to 2^n,
 *   this is often needed. A pointer to the new image data is returned.
 *   imagedata is not freed. Uses the algorithm "Filtered Image
 *   Rescaling" by Dale Schumacher, from GGems III.
 *
 * simage_next_power_of_two(int val)
 *
 *   Will return the first 2^n bigger or equal to val.
 *   If simage_next_power_of_two(size) != size, you'll typically
 *   need to resize your image to be able to use it in an OpenGL app.
 *
 * The movie functions:
 *
 * s_movie * s_movie_create(const char * filename, s_params * params)
 *
 *   Will create a new move file named filename and attempt to locate a
 *   suitable encoder based on the parameters (params) supplied.
 *
 *   Returns a pointer to the opened movie on success, NULL on failure
 *
 *   Common parameters:
 *   - "mime-type" <string> : The requested encoder type. There are currently
 *     2 encoders available, with mime-types "video/mpeg" and "video/avi".
 *   - width <int> : Frame width (all input images must have this width)
 *   - height <int> : Frame height (all input images must have this height)
 *
 *   Parameters specific for the avi encoder
 *   - fps <int> : Number of frames per second in output file
 *   - parameter file <int> : If this parameter is missing (or empty ""),
 *     a GUI will pop up each time this functions is run, asking the user
 *     to specify compression settings. If a filename is specified and the
 *     file doesn't exist, a GUI pops up, and the compression settings are
 *     saved in a new file with the specified filename. If the file exists,
 *     no GUI pops up, and the compression settings are read from the file.
 *     The format of the file is unspecified, and copying such a file between
 *     different computers probably won't work.
 *   - width and height must be divisible by 4
 *
 * int s_movie_put_image(s_movie * movie, s_image * image, s_params * params)
 *
 *   Adds (encodes) the image as one frame to the movie. params is currently
 *   used only for optimizing avi encoding:
 *   - "allow image modification" <int> : Set to "1" to allow the encoder
 *     to modify the image buffer. If this parameter is not set, the encoder
 *     will make a local copy of the image before it is encoded.
 *
 *   Example code:
 *
 *   s_params *imgparams = s_params_create();
 *   s_params_set(imgparams,
 *                "allow image modification", S_INTEGER_PARAM_TYPE, 1,
 *                NULL);
 *   for(;;) {
 *     s_image_set(image, width, height, 1, <get image from somewhere>);
 *     for (int i=0; i<repeatCount;i++)
 *       s_movie_put_image(movie, image, imgparams);
 *   }
 *   s_params_destroy(imgparams);
 *
 *   Returns 1 on success, 0 on failure
 *
 * void s_movie_close(s_movie * movie)
 *
 *   Closes the newly created movie file
 *
 * void s_movie_destroy(s_movie * movie)
 *
 *   Cleans up all resources allocated by s_movie_create(...)
 *
 */

/***************************************************************************/

/* A unique identifier to recognize in sourcecode whether or not this
 * file is included.
 */
#define __SIMAGE__

/* version 1.1 introduced saving */
#define SIMAGE_VERSION_1_1

/* version 1.2 added a new API, and support for movies */
#define SIMAGE_VERSION_1_2

/* version 1.3 added simage_resize3d */
#define SIMAGE_VERSION_1_3

/* version 1.4 added API for stream I/O */
#define SIMAGE_VERSION_1_4

/* version 1.5 added API for seeking and getting ("telling") the
   current position in a stream
   added API for setting and getting component order of an
   image */
#define SIMAGE_VERSION_1_5

/* version 1.6 added API for reading images line-by-line
   added API for loading dynamic libraries at run-time */
#define SIMAGE_VERSION_1_6

/* These are available for adding or omitting features based on simage
 * version numbers in "client" sources. NB: they are automatically
 * synchronized with the settings in configure.in when configure is
 * run. The #ifndefs are necessary because during development, these
 * are also defined in the config.h file generated by configure.
 */
#if !defined(SIMAGE_MAJOR_VERSION)
#undef SIMAGE_MAJOR_VERSION
#endif /* !SIMAGE_MAJOR_VERSION */
#if !defined(SIMAGE_MINOR_VERSION)
#undef SIMAGE_MINOR_VERSION
#endif /* !SIMAGE_MINOR_VERSION */
#if !defined(SIMAGE_MICRO_VERSION)
#undef SIMAGE_MICRO_VERSION
#endif /* !SIMAGE_MICRO_VERSION */
#if !defined(SIMAGE_VERSION)
#undef SIMAGE_VERSION
#endif /* !SIMAGE_VERSION */

/***************************************************************************/

/* Precaution to avoid an error easily made by the application programmer. */
#ifdef SIMAGE_DLL_API
# error Leave the internal SIMAGE_DLL_API define alone.
#endif /* SIMAGE_DLL_API */

/*
  On MSWindows platforms, one of these defines must always be set when
  building application programs:

  - "SIMAGE_DLL", when the application programmer is using the
  library in the form of a dynamic link library (DLL)

  - "SIMAGE_NOT_DLL", when the application programmer is using the
  library in the form of a static object library (LIB)

  Note that either SIMAGE_DLL or SIMAGE_NOT_DLL _must_ be defined by
  the application programmer on MSWindows platforms, or else the
  #error statement will hit. Set up one or the other of these two
  defines in your compiler environment according to how the library
  was built -- as a DLL (use "SIMAGE_DLL") or as a LIB (use
  "SIMAGE_NOT_DLL").

  (Setting up defines for the compiler is typically done by either
  adding something like "/DSIMAGE_DLL" to the compiler's argument line
  (for command-line build processes), or by adding the define to the
  list of preprocessor symbols in your IDE GUI (in the MSVC IDE, this
  is done from the "Project"->"Settings" menu, choose the "C/C++" tab,
  then "Preprocessor" from the dropdown box and add the appropriate
  define)).

  It is extremely important that the application programmer uses the
  correct define, as using "SIMAGE_NOT_DLL" when "SIMAGE_DLL" is
  correct will cause mysterious crashes.
*/
#if defined(WIN32) || defined(_WIN32) || defined(__WIN32__) || defined(__NT__)
# ifdef SIMAGE_INTERNAL
#  ifdef SIMAGE_MAKE_DLL
#   define SIMAGE_DLL_API __declspec(dllexport)
#  endif /* SIMAGE_MAKE_DLL */
# else /* !SIMAGE_INTERNAL */
#  ifdef SIMAGE_DLL
#   define SIMAGE_DLL_API __declspec(dllimport)
#  else /* !SIMAGE_DLL */
#   ifndef SIMAGE_NOT_DLL
#    error Define either SIMAGE_DLL or SIMAGE_NOT_DLL as appropriate for your linkage!
#   endif /* SIMAGE_NOT_DLL */
#  endif /* !SIMAGE_DLL */
# endif /* !SIMAGE_INTERNAL */
#endif /* Microsoft Windows */

/* Empty define to avoid errors when _not_ compiling an MSWindows DLL. */
#ifndef SIMAGE_DLL_API
# define SIMAGE_DLL_API
#endif /* !SIMAGE_DLL_API */

/***************************************************************************/

#ifdef __cplusplus
extern "C" {
#endif

  /* Note specifically for MSWindows that by leaving out the APIENTRY
     keyword for the function definitions, we default to the __cdecl
     calling convention. This is important to take into consideration
     when explicitly linking to the library at run-time: when using
     the wrong calling convention, obscure errors due to stack
     corruption can occur under certain (possibly rare) conditions. */

  /* run-time version checking */
  SIMAGE_DLL_API void simage_version(int * major, int * minor, int * micro);

  /* check if image file format is supported */
  SIMAGE_DLL_API int simage_check_supported(const char * filename);

  /* reading and parsing image files */
  /* returned image buffer must be freed by simage_free_image() */
  SIMAGE_DLL_API unsigned char * simage_read_image(const char * filename,
                                                   int * w, int * h,
                                                   int * numcomponents);

  /* check this if simage_read_image returns NULL or simage_write_image returns 0 */
  SIMAGE_DLL_API const char * simage_get_last_error(void);

  /* free resources allocated by either simage_read_image() or
     simage_resize() (Windows goes berzerk if you call free() from the
     client application) */
  SIMAGE_DLL_API void simage_free_image(unsigned char * imagedata);

  /* convenience function */
  SIMAGE_DLL_API int simage_next_power_of_two(int val);

  /* scale the input image and return a new image with the given dimensions */
  /* returned image buffer must be freed by simage_free_image() */
  SIMAGE_DLL_API unsigned char * simage_resize(unsigned char * imagedata,
                                               int width, int height,
                                               int numcomponents,
                                               int newwidth, int newheight);

  /* use the plugin interface described below for extending simage to
     handle more file formats */

  struct simage_plugin
  {
    unsigned char *(*load_func)(const char * name, int * width, int * height,
                                int * numcomponents);
    int (*identify_func)(const char * filename,
                         const unsigned char * header, int headerlen);
    int (*error_func)(char * textbuffer, int bufferlen);
  };

  SIMAGE_DLL_API void * simage_add_loader(const struct simage_plugin * l,
                                          int addbefore);
  SIMAGE_DLL_API void simage_remove_loader(void * handle);


  /*****************************************************************/
  /**** NOTE: new methods for simage version 1.1 *******************/
  /*****************************************************************/

  /* check if export is available for a filetype. Returns 1 if supported, 0 otherwise */
  SIMAGE_DLL_API int simage_check_save_supported(const char * filenameextension);

  /* save image. use simage_check_write_supported first, please */
  SIMAGE_DLL_API int simage_save_image(const char * filename,
                                       const unsigned char * bytes,
                                       int w, int h, int numcomponents,
                                       const char * filenameextension);

  SIMAGE_DLL_API void * simage_add_saver(int (*save_func)(const char * name,
                                                          const unsigned char * bytes,
                                                          int width, int height, int nc),
                                         int (*error_func)(char * textbuffer, int bufferlen),
                                         const char * extensions,
                                         const char * fullname,
                                         const char * description,
                                         int addbefore);

  SIMAGE_DLL_API void simage_remove_saver(void * handle);
  SIMAGE_DLL_API int simage_get_num_savers(void);
  SIMAGE_DLL_API void * simage_get_saver_handle(int idx);
  SIMAGE_DLL_API const char * simage_get_saver_extensions(void * handle);
  SIMAGE_DLL_API const char * simage_get_saver_fullname(void * handle);
  SIMAGE_DLL_API const char * simage_get_saver_description(void * handle);


  /*****************************************************************/
  /**** NOTE: new methods for simage version 1.2 *******************/
  /*****************************************************************/

  typedef struct simage_image_s s_image;
  typedef struct simage_movie_s s_movie;
  typedef struct simage_parameters_s s_params;
  typedef int s_movie_open_func(const char *, s_movie *);
  typedef int s_movie_create_func(const char *, s_movie *, s_params *);
  typedef s_image * s_movie_get_func(s_movie *, s_image *, s_params *);
  typedef int s_movie_put_func(s_movie *, s_image *, s_params *);
  typedef void s_movie_close_func(s_movie *);

  SIMAGE_DLL_API s_image * s_image_create(int w, int h, int components,
                                          unsigned char * prealloc /* | NULL */);
  SIMAGE_DLL_API void s_image_destroy(s_image * image);

  SIMAGE_DLL_API int s_image_width(s_image * image);
  SIMAGE_DLL_API int s_image_height(s_image * image);
  SIMAGE_DLL_API int s_image_components(s_image * image);
  SIMAGE_DLL_API unsigned char * s_image_data(s_image * image);
  SIMAGE_DLL_API void s_image_set(s_image * image, int w, int h, int components,
                                  unsigned char * data, int copydata);

  SIMAGE_DLL_API s_image * s_image_load(const char * filename, s_image * prealloc /* | NULL */);
  SIMAGE_DLL_API int s_image_save(const char * filename, s_image * image,
                                  s_params * params /* | NULL */);

  SIMAGE_DLL_API s_movie * s_movie_open(const char * filename);
  SIMAGE_DLL_API s_movie * s_movie_create(const char * filename, s_params * params /* | NULL */);
  SIMAGE_DLL_API s_image * s_movie_get_image(s_movie * movie, s_image * prealloc /* | NULL */,
                                             s_params * params /* | NULL */);
  SIMAGE_DLL_API int s_movie_put_image(s_movie * movie, s_image * image,
                                       s_params * params /* | NULL */);
  SIMAGE_DLL_API void s_movie_close(s_movie * movie);
  SIMAGE_DLL_API void s_movie_destroy(s_movie * movie);

  SIMAGE_DLL_API void s_movie_importer_add(s_movie_open_func * open,
                                           s_movie_get_func * get,
                                           s_movie_close_func * close);

  SIMAGE_DLL_API void s_movie_exporter_add(s_movie_create_func * create,
                                           s_movie_put_func * put,
                                           s_movie_close_func * close);

  enum {
    S_INTEGER_PARAM_TYPE,
    S_BOOL_PARAM_TYPE = S_INTEGER_PARAM_TYPE,
    S_FLOAT_PARAM_TYPE,
    S_DOUBLE_PARAM_TYPE,
    S_STRING_PARAM_TYPE,
    S_POINTER_PARAM_TYPE,
    S_FUNCTION_PARAM_TYPE
  };

  SIMAGE_DLL_API s_params * s_params_create(void);
  SIMAGE_DLL_API s_params * s_params_copy(s_params * params);
  SIMAGE_DLL_API void s_params_destroy(s_params * params);

  SIMAGE_DLL_API void s_params_set(s_params * params, ...);
  SIMAGE_DLL_API int s_params_get(s_params * params, ...);

  /*****************************************************************/
  /**** NOTE: new methods for simage version 1.3 *******************/
  /*****************************************************************/

  /* returned image buffer must be freed by simage_free_image() */
  SIMAGE_DLL_API unsigned char * simage_resize3d(unsigned char * imagedata,
                                                 int width, int height,
                                                 int numcomponents,
                                                 int layers,
                                                 int newwidth, int newheight,
                                                 int newlayers);

  /*****************************************************************/
  /**** NOTE: new methods for simage version 1.4 *******************/
  /*****************************************************************/

  typedef struct simage_stream_s s_stream;
  typedef int s_stream_open_func(const char *, s_stream *, s_params *);
  typedef int s_stream_create_func(const char *, s_stream *, s_params *);
  typedef void * s_stream_get_func(s_stream *, void *, int *, s_params *);
  typedef int s_stream_put_func(s_stream *, void *, int, s_params *);
  typedef void s_stream_close_func(s_stream *);

  SIMAGE_DLL_API s_stream * s_stream_open(const char * filename,
                                          s_params * params /* | NULL */);
  SIMAGE_DLL_API s_stream * s_stream_create(const char * filename,
                                            s_params * params /* | NULL */);
  SIMAGE_DLL_API void * s_stream_get_buffer(s_stream * stream,
                                            void * prealloc /* | NULL */,
                                            int *size /* | NULL */,
                                            s_params * params /* | NULL */);
  SIMAGE_DLL_API int s_stream_put_buffer(s_stream * stream, void * buffer,
                                         int size,
                                         s_params * params /* | NULL */);
  SIMAGE_DLL_API void s_stream_close(s_stream * stream);
  SIMAGE_DLL_API void s_stream_destroy(s_stream * stream);
  SIMAGE_DLL_API s_params * s_stream_params(s_stream * stream);

  SIMAGE_DLL_API void s_stream_importer_add(s_stream_open_func * open,
                                            s_stream_get_func * get,
                                            s_stream_close_func * close);

  SIMAGE_DLL_API void s_stream_exporter_add(s_stream_create_func * create,
                                            s_stream_put_func * put,
                                            s_stream_close_func * close);

  /*****************************************************************/
  /**** NOTE: new methods for simage version 1.5 *******************/
  /*****************************************************************/

  typedef int s_stream_seek_func(s_stream *, int, int, s_params *);
  typedef int s_stream_tell_func(s_stream *, s_params *);

  enum {
    SIMAGE_SEEK_SET = 0,
    SIMAGE_SEEK_CUR = 1,
    SIMAGE_SEEK_END = 2
  };


  SIMAGE_DLL_API int s_stream_seek(s_stream * stream, int offset, int whence,
                                   s_params * params /* | NULL */);
  SIMAGE_DLL_API int s_stream_tell(s_stream *stream,
                                   s_params * params /* | NULL */);

  SIMAGE_DLL_API void s_stream_importer_add_ex(s_stream_open_func * open,
                                               s_stream_get_func * get,
                                               s_stream_seek_func * seek,
                                               s_stream_tell_func * tell,
                                               s_stream_close_func * close);

  SIMAGE_DLL_API void s_stream_exporter_add_ex(s_stream_create_func * create,
                                               s_stream_put_func * put,
                                               s_stream_seek_func * seek,
                                               s_stream_tell_func * tell,
                                               s_stream_close_func * close);

  enum {
    SIMAGE_ORDER_RGB = 0,
    SIMAGE_ORDER_BGR
  };
  SIMAGE_DLL_API int s_image_set_component_order(s_image * image, int order);
  SIMAGE_DLL_API int s_image_get_component_order(s_image * image);

  /*****************************************************************/
  /**** NOTE: new methods for simage version 1.6 *******************/
  /*****************************************************************/

  SIMAGE_DLL_API s_image * s_image_open(const char * file, int oktoreadall);
  SIMAGE_DLL_API int s_image_read_line(s_image * image,
                                       int line,
                                       unsigned char * buf);

  typedef void * s_dlopen_func(const char * filename);
  typedef void * s_dlsym_func(void * handle, const char * symbolname);
  typedef void s_dlclose_func(void * handle);

  SIMAGE_DLL_API void s_set_dynamic_loader_interface(s_dlopen_func *dlopen,
                                                     s_dlsym_func *dlsym,
                                                     s_dlclose_func *dlclose);



#ifdef __cplusplus
}
#endif

#endif /* ! SIMAGE_H */