cmake_minimum_required ( VERSION 3.30 )
project ( lpeg VERSION 1.1.0.2
               LANGUAGES C )

if ( CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT )
  set_property ( CACHE CMAKE_INSTALL_PREFIX PROPERTY VALUE ${PROJECT_SOURCE_DIR} )
endif ()

set ( LPEG_DIR "src" CACHE PATH "Source Directory of 'gvvaughan/lpeg' module" )

set ( ENV{LUA_DIR} "externals/lua" )
find_package ( Lua REQUIRED )
message( STATUS "Lua Version ${LUA_VERSION_STRING}" )
message( STATUS "Lua Includes ${LUA_INCLUDE_DIR}" )
message( STATUS "Lua Library ${LUA_LIBRARY}" )
message( STATUS "Lua Libraries ${LUA_LIBRARIES}" )

add_compile_options ( /W4 )

# from src/makefile
set ( SRC_FILES
    lpvm.c lpcap.c lptree.c lpcode.c lpprint.c lpcset.c )
set ( SRC_DEF lpeg.def )

list ( TRANSFORM SRC_FILES PREPEND "${LPEG_DIR}/" )
list ( TRANSFORM SRC_DEF PREPEND "${LPEG_DIR}/" )

add_library ( lpeg MODULE ${SRC_FILES} )
target_compile_definitions ( lpeg PRIVATE
        # LPEG_DEBUG
        # INITBACK=400
        # MAXBACK=400
        # MAXRULES=1000
        # MAXRECLEVEL=200
)
target_include_directories ( lpeg PRIVATE ${LUA_INCLUDE_DIR} )
target_link_options ( lpeg PRIVATE ${CMAKE_LINK_DEF_FILE_FLAG}${PROJECT_SOURCE_DIR}/${SRC_DEF} )
target_link_libraries ( lpeg ${LUA_LIBRARIES} )
set_target_properties ( lpeg PROPERTIES OUTPUT_NAME "lpeg" )

install ( TARGETS lpeg LIBRARY DESTINATION "bin" )
install ( FILES ${LPEG_DIR}/re.lua DESTINATION "bin" )
