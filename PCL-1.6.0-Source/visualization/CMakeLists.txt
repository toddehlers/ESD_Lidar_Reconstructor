set(SUBSYS_NAME visualization)
set(SUBSYS_DESC "Point cloud visualization library")
set(SUBSYS_DEPS common io kdtree geometry search)

if(NOT VTK_FOUND)
    set(DEFAULT FALSE)
    set(REASON "VTK was not found.")
else(NOT VTK_FOUND)
    set(DEFAULT TRUE)
    set(REASON)
    set(VTK_USE_FILE ${VTK_USE_FILE} CACHE INTERNAL "VTK_USE_FILE")
    include (${VTK_USE_FILE})
    include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)
endif(NOT VTK_FOUND)

PCL_SUBSYS_OPTION(build ${SUBSYS_NAME} ${SUBSYS_DESC} ${DEFAULT} ${REASON})
PCL_SUBSYS_DEPEND(build ${SUBSYS_NAME} DEPS ${SUBSYS_DEPS} EXT_DEPS vtk OPT_DEPS openni)

if (ANDROID_NDK)
  set (build FALSE)
  message("VTK was found, but cannot be compiled for Android. Please use VES instead.")
endif ()

PCL_ADD_DOC(${SUBSYS_NAME})

if(build)
    set(srcs
        src/point_picking_event.cpp
        src/interactor_style.cpp
        src/point_cloud_handlers.cpp
        src/pcl_visualizer.cpp
        src/histogram_visualizer.cpp
        src/common/common.cpp
        src/common/io.cpp
        src/common/shapes.cpp
        src/cloud_viewer.cpp
        src/image_viewer.cpp
        src/window.cpp
        src/range_image_visualizer.cpp
        src/common/float_image_utils.cpp
        src/vtk/pcl_image_canvas_source_2d.cpp
        )
    if("${VTK_MAJOR_VERSION}.${VTK_MINOR_VERSION}" VERSION_LESS "5.6")
        # A custom interactor is necessary on VTK 5.4 and below
        set(srcs ${srcs} src/interactor.cpp)
    endif("${VTK_MAJOR_VERSION}.${VTK_MINOR_VERSION}" VERSION_LESS "5.6")

    set(incs 
        include/pcl/${SUBSYS_NAME}/cloud_viewer.h
        include/pcl/${SUBSYS_NAME}/histogram_visualizer.h
        include/pcl/${SUBSYS_NAME}/image_viewer.h
        include/pcl/${SUBSYS_NAME}/interactor_style.h
        include/pcl/${SUBSYS_NAME}/pcl_visualizer.h
        include/pcl/${SUBSYS_NAME}/registration_visualizer.h
        include/pcl/${SUBSYS_NAME}/point_cloud_handlers.h
        include/pcl/${SUBSYS_NAME}/keyboard_event.h
        include/pcl/${SUBSYS_NAME}/point_picking_event.h
        include/pcl/${SUBSYS_NAME}/mouse_event.h
        include/pcl/${SUBSYS_NAME}/window.h
        include/pcl/${SUBSYS_NAME}/range_image_visualizer.h
        include/pcl/${SUBSYS_NAME}/interactor.h
        include/pcl/${SUBSYS_NAME}/vtk.h
        )

    set(common_incs 
        include/pcl/${SUBSYS_NAME}/common/actor_map.h
        include/pcl/${SUBSYS_NAME}/common/common.h
        include/pcl/${SUBSYS_NAME}/common/io.h
        include/pcl/${SUBSYS_NAME}/common/ren_win_interact_map.h
        include/pcl/${SUBSYS_NAME}/common/shapes.h
        include/pcl/${SUBSYS_NAME}/common/float_image_utils.h
        )

    set(impl_incs 
        include/pcl/${SUBSYS_NAME}/impl/histogram_visualizer.hpp
        include/pcl/${SUBSYS_NAME}/impl/pcl_visualizer.hpp
        include/pcl/${SUBSYS_NAME}/impl/image_viewer.hpp
        include/pcl/${SUBSYS_NAME}/impl/registration_visualizer.hpp
        include/pcl/${SUBSYS_NAME}/impl/point_cloud_handlers.hpp
        )

    set(common_impl_incs include/pcl/${SUBSYS_NAME}/common/impl/shapes.hpp)

    set(vtk_incs 
        include/pcl/${SUBSYS_NAME}/vtk/pcl_image_canvas_source_2d.h
        )

    set(LIB_NAME pcl_${SUBSYS_NAME})
    PCL_ADD_LIBRARY(${LIB_NAME} ${SUBSYS_NAME} ${srcs} ${incs} ${common_incs} ${impl_incs} ${common_impl_incs} ${vtk_incs})
    
    if(APPLE)
      find_package(OpenGL)
    endif(APPLE)
    
    if("${VTK_MAJOR_VERSION}.${VTK_MINOR_VERSION}" VERSION_LESS "5.6")
      target_link_libraries(${LIB_NAME} pcl_common pcl_io pcl_kdtree vtkCommon vtkWidgets vtkHybrid vtkFiltering vtkRendering ${OPENGL_LIBRARIES})
    else()
      target_link_libraries(${LIB_NAME} pcl_common pcl_io pcl_kdtree vtkCommon vtkWidgets vtkHybrid vtkCharts vtkFiltering vtkRendering ${OPENGL_LIBRARIES})
    endif()

    set(EXT_DEPS "")
    if(OPENNI_FOUND)
      list(APPEND EXT_DEPS openni-dev)
    endif(OPENNI_FOUND)
    PCL_MAKE_PKGCONFIG(${LIB_NAME} ${SUBSYS_NAME} "${SUBSYS_DESC}"
      "${SUBSYS_DEPS}" "${EXT_DEPS}" "" "" "")

    # Install include files
    PCL_ADD_INCLUDES(${SUBSYS_NAME} ${SUBSYS_NAME} ${incs})
    PCL_ADD_INCLUDES(${SUBSYS_NAME} ${SUBSYS_NAME}/common ${common_incs})
    PCL_ADD_INCLUDES(${SUBSYS_NAME} ${SUBSYS_NAME}/impl ${impl_incs})
    PCL_ADD_INCLUDES(${SUBSYS_NAME} ${SUBSYS_NAME}/common/impl ${common_impl_incs})
    PCL_ADD_INCLUDES(${SUBSYS_NAME} ${SUBSYS_NAME}/vtk ${vtk_incs})

    if(BUILD_TESTS)
        add_subdirectory(test)
    endif(BUILD_TESTS)

    add_subdirectory(tools)

endif(build)
