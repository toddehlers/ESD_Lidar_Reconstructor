set(SUBSYS_NAME io)
set(SUBSYS_DESC "Point cloud IO library")
set(SUBSYS_DEPS common octree)

set(build TRUE)
PCL_SUBSYS_OPTION(build ${SUBSYS_NAME} ${SUBSYS_DESC} ON)
if(WIN32)
    PCL_SUBSYS_DEPEND(build ${SUBSYS_NAME} DEPS ${SUBSYS_DEPS} OPT_DEPS openni vtk)
else(WIN32)
    PCL_SUBSYS_DEPEND(build ${SUBSYS_NAME} DEPS ${SUBSYS_DEPS} OPT_DEPS openni vtk libusb-1.0)
endif(WIN32)

PCL_ADD_DOC(${SUBSYS_NAME})

if(build)
    OPTION(BUILD_OPENNI "Build the OpenNI Grabber." ON)
    MARK_AS_ADVANCED(BUILD_OPENNI)
    if(NOT BUILD_OPENNI)
      # Set OPENNI_FOUND to false locally to avoid building anything OpenNI related
      # Remember that other modules (libraries) need to check explicitly for BUILD_OPENNI
      set(OPENNI_FOUND FALSE) 
    endif()
    if(OPENNI_FOUND)
        set(OPENNI_GRABBER_INCLUDES
            include/pcl/io/openni_grabber.h
            include/pcl/io/oni_grabber.h
            )
        set(OPENNI_INCLUDES
            include/pcl/io/openni_camera/openni_depth_image.h
            include/pcl/io/openni_camera/openni_device.h
            include/pcl/io/openni_camera/openni_device_kinect.h
            include/pcl/io/openni_camera/openni_device_primesense.h
            include/pcl/io/openni_camera/openni_device_xtion.h
            include/pcl/io/openni_camera/openni_device_oni.h
            include/pcl/io/openni_camera/openni_driver.h
            include/pcl/io/openni_camera/openni_exception.h
            include/pcl/io/openni_camera/openni_image.h
            include/pcl/io/openni_camera/openni_image_bayer_grbg.h
            include/pcl/io/openni_camera/openni_image_yuv_422.h
            include/pcl/io/openni_camera/openni_image_rgb24.h
            include/pcl/io/openni_camera/openni_ir_image.h
            )
        set(OPENNI_GRABBER_SOURCES src/openni_camera/openni_device.cpp
            src/openni_camera/openni_device_primesense.cpp
            src/openni_camera/openni_image_bayer_grbg.cpp
            src/openni_camera/openni_depth_image.cpp
            src/openni_camera/openni_ir_image.cpp
            src/openni_camera/openni_device_kinect.cpp
            src/openni_camera/openni_device_xtion.cpp
            src/openni_camera/openni_device_oni.cpp
            src/openni_camera/openni_driver.cpp
            src/openni_camera/openni_exception.cpp
            src/openni_camera/openni_image_yuv_422.cpp
            src/openni_camera/openni_image_rgb24.cpp
            src/openni_grabber.cpp
            src/oni_grabber.cpp
            )
    endif(OPENNI_FOUND)

    if (VTK_FOUND AND NOT ANDROID_NDK)
        set(VTK_USE_FILE ${VTK_USE_FILE} CACHE INTERNAL "VTK_USE_FILE")
        include (${VTK_USE_FILE})
        set(VTK_IO_INCLUDES 
            include/pcl/${SUBSYS_NAME}/vtk_lib_io.h
            include/pcl/${SUBSYS_NAME}/impl/vtk_lib_io.hpp
           )
        set(VTK_IO_SOURCE 
            src/vtk_lib_io.cpp
           )
        set(VTK_IO_TARGET_LINK_LIBRARIES vtkCommon vtkWidgets vtkIO vtkImaging)
    endif ()

    set(PLY_SOURCES src/ply/ply_parser.cpp)
    set(PLY_INCLUDES 
        include/pcl/${SUBSYS_NAME}/ply/byte_order.h
        include/pcl/${SUBSYS_NAME}/ply/io_operators.h
        include/pcl/${SUBSYS_NAME}/ply/ply.h
        include/pcl/${SUBSYS_NAME}/ply/ply_parser.h
       )
    PCL_ADD_LIBRARY(pcl_io_ply ${SUBSYS_NAME} ${PLY_SOURCES} ${PLY_INCLUDES})
    PCL_ADD_INCLUDES(${SUBSYS_NAME} ${SUBSYS_NAME}/ply ${PLY_INCLUDES})

    set(srcs 
        src/pcd_grabber.cpp
        src/pcd_io.cpp
        src/vtk_io.cpp
        src/ply_io.cpp
        src/compression.cpp
        src/lzf.cpp
        src/obj_io.cpp
        ${VTK_IO_SOURCE}
        ${OPENNI_GRABBER_SOURCES}
        )

    set(incs 
        include/pcl/${SUBSYS_NAME}/file_io.h
        include/pcl/${SUBSYS_NAME}/lzf.h
        include/pcl/${SUBSYS_NAME}/io.h
        include/pcl/${SUBSYS_NAME}/grabber.h
        include/pcl/${SUBSYS_NAME}/pcd_grabber.h
        include/pcl/${SUBSYS_NAME}/pcd_io.h
        include/pcl/${SUBSYS_NAME}/pcl_io_exception.h
        include/pcl/${SUBSYS_NAME}/vtk_io.h
        include/pcl/${SUBSYS_NAME}/ply_io.h
        include/pcl/${SUBSYS_NAME}/tar.h
        include/pcl/${SUBSYS_NAME}/obj_io.h 
        ${VTK_IO_INCLUDES}
        ${OPENNI_GRABBER_INCLUDES}
        )

    set(compression_incs
        include/pcl/compression/octree_pointcloud_compression.h
        include/pcl/compression/color_coding.h
        include/pcl/compression/compression_profiles.h
        include/pcl/compression/entropy_range_coder.h
        include/pcl/compression/point_coding.h
       )

    set(impl_incs 
        include/pcl/${SUBSYS_NAME}/impl/pcd_io.hpp
        include/pcl/compression/impl/entropy_range_coder.hpp
        include/pcl/compression/impl/octree_pointcloud_compression.hpp
       )

    set(LIB_NAME pcl_${SUBSYS_NAME})

    include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include ${VTK_INCLUDE_DIRECTORIES})
    PCL_ADD_LIBRARY(${LIB_NAME} ${SUBSYS_NAME} ${srcs} ${incs} ${compression_incs} ${impl_incs} ${OPENNI_INCLUDES})
    link_directories(${VTK_LINK_DIRECTORIES})
    target_link_libraries(${LIB_NAME} pcl_common pcl_io_ply ${VTK_IO_TARGET_LINK_LIBRARIES})

    if(OPENNI_FOUND)
      target_link_libraries(${LIB_NAME} ${OPENNI_LIBRARIES})
      if(NOT WIN32)
        find_package(libusb-1.0 REQUIRED)
        target_link_libraries(${LIB_NAME} ${LIBUSB_1_LIBRARIES})
        include_directories(${LIBUSB_1_INCLUDE_DIR})
      endif()
    endif(OPENNI_FOUND)

    set(EXT_DEPS eigen3)
    if(OPENNI_FOUND)
      list(APPEND EXT_DEPS openni-dev)
    endif(OPENNI_FOUND)
    PCL_MAKE_PKGCONFIG(${LIB_NAME} ${SUBSYS_NAME} "${SUBSYS_DESC}"
      "${SUBSYS_DEPS}" "${EXT_DEPS}" "" "" "")

    # Install include files
    PCL_ADD_INCLUDES(${SUBSYS_NAME} ${SUBSYS_NAME} ${incs})
    PCL_ADD_INCLUDES(${SUBSYS_NAME} compression ${compression_incs})
    PCL_ADD_INCLUDES(${SUBSYS_NAME} ${SUBSYS_NAME}/openni_camera ${OPENNI_INCLUDES})
    PCL_ADD_INCLUDES(${SUBSYS_NAME} ${SUBSYS_NAME}/impl ${impl_incs})
                
    add_subdirectory(tools)

    if(BUILD_TESTS)
        add_subdirectory(test)
    endif(BUILD_TESTS)

endif(build)
