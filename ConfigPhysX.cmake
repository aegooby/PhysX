if (APPLE)
    set(TARGET_BUILD_PLATFORM "mac")
endif (APPLE)
if (WIN32)
    set(TARGET_BUILD_PLATFORM "windows")
endif (WIN32)
if (UNIX AND NOT APPLE)
    set(TARGET_BUILD_PLATFORM "linux")
endif (UNIX AND NOT APPLE)
set(PX_BUILDSNIPPETS OFF CACHE BOOL "Generate the snippets")
set(PX_BUILDPUBLICSAMPLES OFF CACHE BOOL "Generate the samples projects")
set(PX_GENERATE_STATIC_LIBRARIES ON CACHE BOOL "Generate static libraries")
set(PX_FLOAT_POINT_PRECISE_MATH OFF CACHE BOOL "Float point precise math")
set(NV_USE_STATIC_WINCRT ON CACHE BOOL "Use the statically linked windows CRT")
if (CMAKE_BUILD_TYPE STREQUAL "Debug")
    set(NV_USE_DEBUG_WINCRT ON CACHE BOOL "Use the debug version of the CRT")
endif (CMAKE_BUILD_TYPE STREQUAL "Debug")
if (CMAKE_BUILD_TYPE STREQUAL "Release")
    set(NV_USE_DEBUG_WINCRT OFF CACHE BOOL "Use the release of the CRT")
endif (CMAKE_BUILD_TYPE STREQUAL "Release")
set(PHYSX_ROOT_DIR ${PHYSX_SUBMODULE_DIR}/physx)
set(PXSHARED_PATH ${PHYSX_ROOT_DIR}/../pxshared)
set(PXSHARED_INSTALL_PREFIX ${CMAKE_INSTALL_PREFIX})
set(CMAKEMODULES_VERSION "1.27")
set(CMAKEMODULES_PATH ${PHYSX_ROOT_DIR}/../externals/cmakemodules)
set(PX_OUTPUT_LIB_DIR ${CMAKE_CURRENT_BINARY_DIR}/PhysX)
set(PX_OUTPUT_BIN_DIR ${CMAKE_CURRENT_BINARY_DIR}/PhysX)
set(PHYSX_LIBRARIES
    PhysX
    PhysXCommon
    PhysXFoundation
    PhysXExtensions
    PhysXCooking
    PhysXCharacterKinematic
)

# Windows only
if (TARGET_BUILD_PLATFORM STREQUAL "windows")
	IF(CMAKE_SIZEOF_VOID_P EQUAL 8)
		SET(LIBPATH_SUFFIX "64")
	ELSE()
		SET(LIBPATH_SUFFIX "32")
	ENDIF()
	GetPlatformBinName(PLATFORM_BIN_NAME ${LIBPATH_SUFFIX})
	set(PhysxOutputPath ${PX_OUTPUT_LIB_DIR}/bin/${PLATFORM_BIN_NAME}/)
	message("Physx Output Path: " ${PhysxOutputPath})
	add_custom_command(TARGET target_name POST_BUILD
		COMMAND ${CMAKE_COMMAND} -E copy_directory
        "${PhysxOutputPath}" "$<TARGET_FILE_DIR:target_name >/..")
endif(TARGET_BUILD_PLATFORM STREQUAL "windows")